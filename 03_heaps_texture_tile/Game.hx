class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initLocal();
        
        new Game();
    }

    var b:h2d.Bitmap;

    override function init() 
    {
        // b = new h2d.Bitmap(hxd.Res.haxeLogo.toTile(), s2d);
        b = new h2d.Bitmap(hxd.Res.load("haxeLogo.png").toImage().toTile(), s2d);
        b.x = 250;
        b.y = 250;
        // центрируем тайл (задаем ему якорную точку),
        // таким образом все трансформации объекта на экране 
        // будут рассчитываться относительно центра тайла.
        // Если данный метод не вызывать, то тайл будет трансформироваться
        // относительно его левой верхней точки
        b.tile = b.tile.center();
        b.rotation = Math.PI / 4; // повороты задаются в радианах
    }

    override function update(dt:Float) 
    {
        b.rotation += 0.01;
    }
}