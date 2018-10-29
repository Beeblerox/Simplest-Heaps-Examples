import h2d.TileGroup;
import hxd.Key;
import hxd.App;

/**
 * ScaleGrid usage example.
 * ScaleGrid class implements https://en.wikipedia.org/wiki/9-slice_scaling for Heaps.
 * Asset taken from Kenney's asset pack: https://opengameart.org/content/pixel-ui-pack-750-assets
 */
class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        
        new Game();
    }

    override function init() 
    {
        var tile = hxd.Res.load("space.png").toImage().toTile();

        // first argument is tile which will be sliced and tiled
        // second argument is border width, which is the same on the left and on the right
        // third argument is border height, which is the same on the top and on the bottom
        var scaleGrid = new h2d.ScaleGrid(tile, 2, 2, s2d);
        scaleGrid.width = 300;
        scaleGrid.height = 200;
        scaleGrid.x = scaleGrid.y = 100;
    }
}