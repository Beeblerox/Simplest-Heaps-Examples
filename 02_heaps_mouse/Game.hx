class Game extends hxd.App
{
    static function main()
    {
        new Game();
    }

    var b:h2d.Bitmap;

    override function init() 
    {
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

        // Интерактивный объект для обработки событий мыши
        // По умолчанию он задает прямоугольную область.
        // Добавляем этот объект как дочерний, 
        // чтобы он обрабатывал события для родительского объекта b
        var i = new h2d.Interactive(b.tile.width, b.tile.height, b);
        // необходимо сместить интерактивный объект для учета его якорной точки,
        // которая находится посередине тайла
        i.x = -0.5 * b.tile.width;
        i.y = -0.5 * b.tile.height;

        // Обработчики событий
        i.onOver = function(_) b.alpha = 0.5;
        i.onOut = function(_) b.alpha = 1.0;
    }

    override function update(dt:Float) 
    {
        b.rotation += 0.01;
    }
}