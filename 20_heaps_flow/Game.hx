import h3d.mat.Material;
import hxd.App;

/**
 * h2d.Flow usage example.
 * Flow can be seen as flexible container
 */
class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        new Game();
    }

    var flow:h2d.Flow;

    override function init() 
    {
        flow = new h2d.Flow(s2d);
        // set flow direction
        // horizontal flow means that elements will placed horizontally until max width is reached
        flow.isVertical = false;
        // set max width
        flow.maxWidth = s2d.width - 100;

        // set min width, so width of Flow object won't be less than this value
        flow.minWidth = 200;
        // set multiline to true, so if total width of added objects is more than max width, then new line will be started
        flow.multiline = true;
        flow.x = 0.5 * (s2d.width - flow.maxWidth);
        flow.y = 50;
        // set alignment
        flow.horizontalAlign = Middle;
        flow.verticalAlign = Top;
        // set spacing between added objects
        flow.horizontalSpacing = 10;
        flow.verticalSpacing = 15;
        // set padding between objects and outer borders
        flow.padding = 10;

        // let's add some objects to flow
        var tile = h2d.Tile.fromColor(0xffffff, 64, 64);
        for (i in 0...30)
        {
            var b = new h2d.Bitmap(tile);
            b.scaleX = b.scaleY = Math.random() + 1;
            b.color.set(Math.random(), Math.random(), Math.random());
            flow.addChild(b);
        }

        // set flow border, so we can see its actual size
        flow.backgroundTile = hxd.Res.load("space.png").toImage().toTile();
        flow.borderWidth = flow.borderHeight = 2;

        // Get flow properties of the first element added to flow object.
        // We use index of 1 because first actual child of flow object is background border object.
        var flowProp = flow.getProperties(flow.getChildAt(1));
        if (flowProp != null)
        {
            // set align specific to this object
            flowProp.horizontalAlign = Left;
            flowProp.verticalAlign = Bottom;
        }

        // recalculate positions of added objects
        flow.needReflow = true;
        flow.reflow();
    }

    override function update(dt:Float) 
    {
        // lets change size of flow object, so we could see it in action
        flow.maxWidth = Std.int(s2d.mouseX - flow.x);
        // and recalculate object positions inside
        flow.reflow();
    }
}