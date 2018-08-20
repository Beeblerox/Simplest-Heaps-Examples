import h2d.Bitmap;

class Game extends hxd.App
{
    static function main()
    {
        new Game();
    }

    var b:h2d.Bitmap;

    override function init() 
    {
        trace("Hello world!!!");

        b = new h2d.Bitmap(h2d.Tile.fromColor(0xff0000, 60, 60), s2d);
        b.x = 50;
        b.y = 100;
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