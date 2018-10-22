import h2d.Bitmap;
import box2D.dynamics.B2Body;

class Actor extends Bitmap
{
    public var body:B2Body;
    
    public function new(tile:h2d.Tile, ?parent:h2d.Object)
    {
        super(tile, parent);
    }

    public function centerTile():Void
    {
        if (tile == null) return;
        tile = tile.center();
    }

    public function update():Void
    {
        var p = body.getPosition();
        this.x = p.x * Constants.PIXELS_IN_METER;	// updating actor
        this.y = p.y * Constants.PIXELS_IN_METER;
        this.rotation = body.getAngle();
    }
}