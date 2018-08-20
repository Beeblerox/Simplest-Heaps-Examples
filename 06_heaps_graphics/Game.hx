class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initLocal();
        
        new Game();
    }

    var g:h2d.Graphics;

    override function init() 
    {
        g = new h2d.Graphics(s2d);
        g.beginFill(0xff00ff, 0.5);
        g.drawCircle(150, 150, 100);
    }

    override function update(dt:Float) 
    {
        if (hxd.Key.isDown(hxd.Key.RIGHT))
        {
            g.x++;
        }
        else if (hxd.Key.isDown(hxd.Key.LEFT))
        {
            g.x--;
        }
    }
}