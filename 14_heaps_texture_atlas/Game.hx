class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        
        new Game();
    }

    var b:h2d.Bitmap;

    override function init() 
    {
        var atlas:hxd.res.Atlas = hxd.Res.load("spineboy-pro.atlas").to(hxd.res.Atlas);
        var tile = atlas.get("crosshair");
        
        b = new h2d.Bitmap(tile, s2d);
        b.tile = b.tile.center();
    }

    override function update(dt:Float) 
    {
        b.x = s2d.mouseX;
        b.y = s2d.mouseY;
    }
}