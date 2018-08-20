class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initLocal();
        
        new Game();
    }

    override function init() 
    {
        var t = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        t.scale(10);
        t.text = "Haxe Rocks!!!";

        var t = new h2d.HtmlText(hxd.res.DefaultFont.get(), s2d);
        t.scale(10);
        t.y = 100;
        t.text = "Haxe <font color='#ff0000'>Rocks!!!</font>";

        var t = new h2d.TextInput(hxd.res.DefaultFont.get(), s2d);
        t.scale(10);
        t.y = 200;
        t.text = "Input text";
    }
}