class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initLocal();
        
        new Game();
    }

    var g:h2d.TileGroup;

    override function init() 
    {
        // Разбиваем текстуру на кадры по сетке
        var tiles = hxd.Res.haxeLogo.toTile().gridFlatten(10, 0, 0);
        // создаем группу
        g = new h2d.TileGroup(tiles[0], s2d);
        // отключим blend mode для группы, это ускорит отрисовку тайлов
        g.blendMode = None;
        // и добавляем в нее тайлы, произвольно расположенные на экране
        for (i in 0...1000)
        {
            g.add(Std.random(s2d.width), Std.random(s2d.height), tiles[i % tiles.length]);
        }
    }

    override function update(dt:Float) 
    {
        g.rotation += 0.01;
    }
}