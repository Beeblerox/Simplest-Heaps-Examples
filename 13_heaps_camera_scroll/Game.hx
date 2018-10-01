import h2d.TileGroup;
import hxd.Key;
import hxd.App;

class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        
        new Game();
    }

    var camera:Camera;

    var char:h2d.Bitmap;
    var map:TileGroup;

    override function init() 
    {
        camera = new Camera(s2d);

        var tile = h2d.Tile.fromColor(0x00ff00, 16, 16);
        map = new TileGroup(tile, camera);

        for (i in 0...1000)
        {
            map.add(Std.int(s2d.width * Math.random()), Std.int(s2d.height * Math.random()), tile);
        }    

        char = new h2d.Bitmap(hxd.Res.load("haxeLogo.png").toImage().toTile(), camera);
        char.x = 250;
        char.y = 250;

        char.tile = char.tile.center();
        char.scaleX = char.scaleY = 0.25;
    }

    override function update(dt:Float) 
    {
        if (Key.isDown(Key.LEFT))
        {
            char.x--;
        }
        else if (Key.isDown(Key.RIGHT))
        {
            char.x++;
        }

        if (Key.isDown(Key.UP))
        {
            char.y--;
        }
        else if (Key.isDown(Key.DOWN))
        {
            char.y++;
        }

        camera.viewX = char.x;
        camera.viewY = char.y;
    }
}