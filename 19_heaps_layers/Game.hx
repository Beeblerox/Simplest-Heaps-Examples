import hxd.Key;
import hxd.res.TiledMap;
import hxd.App;

/**
 * Layers usage example.
 * h2d.Layers class could be used as a lighter alternative to object hierarchies.
 * As you could guess from its name, this class organizes its children in separate layers.
 * Layers are divided by their indices. Layers with lower indices are drawn first, and layer with higher indices are drawn later.
 * In Heaps this class is used in h2d.CdvLevel class, so each "layer" is used for separate tile layer from tilemap.
 * 
 * For this example we'll try to load Tiled map.
 * This example is modified version of "Drawing tiles" example from official Heaps site: https://heaps.io/documentation/drawing-tiles.html 
 * 
 * Assets for this project taken from official Tiled examples: https://github.com/bjorn/tiled/tree/master/examples/
 */
class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        new Game();
    }

    var layers:h2d.Layers;

    override function init() 
    {
        // load map data
        var mapData:TiledMapData = hxd.Res.sewers.toMap();
        
        // get tile image (tiles.png) from resources
        var tileImage = hxd.Res.load("sewer_tileset.png").toImage().toTile();
        // tile size
        var tw:Int = 24;
        var th:Int = 24;
        // map size
        var mw = mapData.width;
        var mh = mapData.height;

        // make sub tiles from tile
        var tiles = [];
        for (y in 0...Std.int(tileImage.height / th))
        {
            for (x in 0...Std.int(tileImage.width / tw))
            {
                var t = tileImage.sub(x * tw, y * th, tw, th, 0, 0);
                tiles.push(t);
            }
        }

        // create h2d.Layers object and add it to 2d scene
        layers = new h2d.Layers(s2d);

        // iterate over all layers
        for (layer in mapData.layers) 
        {
            // get layer index
            var layerIndex:Int = mapData.layers.indexOf(layer);
            // create tile group for this layer
            var layerGroup:h2d.TileGroup = new h2d.TileGroup(tiles[0]);
            // and add it to layers object at specified index
            layers.add(layerGroup, layerIndex);
            // you can also add objects to layer over and under specified objects
            // by using `over()` and `under()` methods

            // iterate on x and y
            for (y in 0...mh)
            {
                for (x in 0...mw)
                {
                    // get the tile id at the current position 
                    var tid = layer.data[x + y * mw];
                    if (tid != 0) // skip transparent tiles
                    { 
                        // add a tile to layer
                        layerGroup.add(x * tw, y * tw, tiles[tid - 1]);
                    }
                }
            }

            // you can also iterate through all objects on specified layer with `getLayer()` method
            for (object in layers.getLayer(1))
            {
                object.alpha = 0.5;
            }
        }
    }
}
