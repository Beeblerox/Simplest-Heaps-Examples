
// this example contains modified code from Flambe game engine: https://github.com/aduros/flambe
class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initLocal();
        
        new Game();
    }

    var b:h2d.Bitmap;

    var script:flambe.script.Script;

    override function init() 
    {
        b = new h2d.Bitmap(hxd.Res.haxeLogo.toTile(), s2d);
        b.x = 250;
        b.y = 250;
        
        // sequence of actions
        var sequence = new flambe.script.Sequence([
            // first action is just delay for 2.5 seconds
            new flambe.script.Delay(2.5),
            // then we just set color to red
            new flambe.script.CallFunction(function() { b.color = new h3d.Vector(1.0, 0.0, 0.0, 1.0); }),
            // then again delay for another 3.5 seconds
            new flambe.script.Delay(3.5),
            // and set color to blue
            new flambe.script.CallFunction(function() { b.color = new h3d.Vector(0.0, 0.0, 1.0, 1.0); }),
            // wait another 1.5 seconds
            new flambe.script.Delay(1.5),
            // and set color to normal
            new flambe.script.CallFunction(function() { b.color = new h3d.Vector(1.0, 1.0, 1.0, 1.0); })
        ]);

        // let's repeat this sequence forever (-1 means forever)
        var repeat = new flambe.script.Repeat(sequence, -1);

        // and create script object, which will run our repeat action
        script = new flambe.script.Script();
        script.run(repeat);

        // you want to execute this sequence just one time, then you could just call script.run(sequence);
    }

    override function update(dt:Float) 
    {
        // update script object
        script.update(hxd.Timer.elapsedTime);

        // if you'll want to stop this script, then you can just call script.stopAll() method.
    }
}