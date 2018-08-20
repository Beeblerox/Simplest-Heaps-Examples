class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initLocal();
        
        new Game();
    }

    var w:hxd.WaitEvent;

    override function init() 
    {
        w = new hxd.WaitEvent();
        // Отложенное выполнение функции
        w.wait(2, function() {trace("Kept you waiting, huh?");});
        // функция everyFrameRoutine будет выполняться каждый кадр
        w.add(everyFrameRoutine);
    }

    override function update(dt:Float) 
    {
        w.update(dt);
    }

    function everyFrameRoutine(dt:Float):Bool
    {
        trace("everyFrameRoutine");
        return false;
    }
}