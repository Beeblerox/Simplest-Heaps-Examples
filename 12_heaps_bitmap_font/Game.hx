class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        new Game();
    }

    override function init() 
    {
        // For bitmap font generation
        // use https://github.com/andryblack/fontbuilder/downloads (export to XML divo format) 
        // or http://www.kvazars.com/littera/ (export to XML format). 
        // BMFont tool doesn't supported (will throw exceprions all the time)
        
        var bmp = new hxd.res.BitmapFont(hxd.Res.load("font.fnt").entry);
		var fnt = bmp.toFont();
        
        var t = new h2d.Text(fnt, s2d);
        t.text = "Haxe Rocks!!!";
    }
}