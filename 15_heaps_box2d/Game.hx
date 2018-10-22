import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2FixtureDef;
import box2D.collision.B2AABB;
import box2D.collision.shapes.B2Shape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2CircleShape;

/**
 * In order to compile it you would need to use version of box2d library
 * installed from https://github.com/openfl/box2d (not from haxelib, which is outdated)
 */
class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        
        new Game();
    }
    
    var world:B2World;
    var actors:Array<Actor> = [];	    // instances of Bitmap (from Heaps)
    var up:B2Vec2;

    override function init() 
    {
        world = new B2World(new B2Vec2(0, 10), true);
        up = new B2Vec2(0, -5);

        var bxFixDef = new B2FixtureDef();	// box fixture definition
        
        var blFixDef = new B2FixtureDef();	// ball fixture definition
        var bxCircleShape = new B2CircleShape();
        blFixDef.shape = bxCircleShape;
        bxFixDef.density = blFixDef.density = 1;

        var bodyDef = new B2BodyDef();
        bodyDef.type = B2BodyType.STATIC_BODY;

        // create ground
        var bxPolygonShape = new B2PolygonShape();
        bxPolygonShape.setAsBox(10, 1);
        bxFixDef.shape = bxPolygonShape;
        bodyDef.position.set(9, s2d.height / Constants.PIXELS_IN_METER + 1);
        world.createBody(bodyDef).createFixture(bxFixDef);

        bxPolygonShape.setAsBox(1, 100);
        bxFixDef.shape = bxPolygonShape;
        // left wall
        bodyDef.position.set(-1, 3);
        world.createBody(bodyDef).createFixture(bxFixDef);
        // right wall
        bodyDef.position.set(s2d.width / Constants.PIXELS_IN_METER + 1, 3);
        world.createBody(bodyDef).createFixture(bxFixDef);

        // both images are 200 x 200 px
        var bxBD = hxd.Res.load("crate.jpg").toImage().toTile();
        var blBD = hxd.Res.load("ball.png").toImage().toTile();

        // let's add 25 boxes and 25 balls!
        bodyDef.type = B2BodyType.DYNAMIC_BODY;
        for (i in 0...50)
        {
            var hw = 0.1 + Math.random() * 0.45;	// "half width"
            var hh = 0.1 + Math.random() * 0.45;	// "half height"

            var isCircle:Bool = (i >= 25);

            bxPolygonShape.setAsBox(hw, hh);
            bxFixDef.shape = bxPolygonShape;

            bxCircleShape.setRadius(hw);
            blFixDef.shape = bxCircleShape;
            
            bodyDef.position.set(Math.random() * 7, -5 + Math.random() * 5);

            var body = world.createBody(bodyDef);
            if (!isCircle) 
            {
                body.createFixture(bxFixDef);	// box
            }
            else
            {
                body.createFixture(blFixDef);	// ball
                hh = hw;
            }
            
            var actor = new Actor(isCircle ? blBD : bxBD, s2d);
            actor.body = body;
            actor.centerTile();

            // Need to adjust scale since tile scale
            actor.scaleX = hw;
            actor.scaleY = hh;
            
            actors.push(actor);
        }
    }
    
    override function update(dt:Float) 
    {
        world.step(1 / 60,  3,  3);
        world.clearForces();

        for (actor in actors)
        {
            actor.update();
        }

        if (hxd.Key.isPressed(hxd.Key.MOUSE_LEFT))
        {
            var body = getBodyAtMouse();
            if (body != null)
            {
                body.applyImpulse(up, body.getWorldCenter());
            }
        }
    }

    //======================
    // GetBodyAtMouse
    //======================
    private var mousePVec:B2Vec2 = new B2Vec2();
    public function getBodyAtMouse(includeStatic:Bool = false):B2Body 
    {
        // Make a small box.
        var mouseXWorldPhys = s2d.mouseX / Constants.PIXELS_IN_METER;
        var mouseYWorldPhys = s2d.mouseY / Constants.PIXELS_IN_METER;
        mousePVec.set(mouseXWorldPhys, mouseYWorldPhys);
        var aabb:B2AABB = new B2AABB();
        aabb.lowerBound.set(mouseXWorldPhys - 0.001, mouseYWorldPhys - 0.001);
        aabb.upperBound.set(mouseXWorldPhys + 0.001, mouseYWorldPhys + 0.001);
        var body:B2Body = null;
        var fixture:B2Fixture;
        
        // Query the world for overlapping shapes.
        function getBodyCallback(fixture:B2Fixture):Bool
        {
            var shape:B2Shape = fixture.getShape();
            if (fixture.getBody().getType() != 0 || includeStatic)
            {
                var inside:Bool = shape.testPoint(fixture.getBody().getTransform(), mousePVec);
                if (inside)
                {
                    body = fixture.getBody();
                    return false;
                }
            }

            return true;
        }

        world.queryAABB(getBodyCallback, aabb);
        return body;
    }
}