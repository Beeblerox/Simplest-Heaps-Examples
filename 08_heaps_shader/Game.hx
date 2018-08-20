class MyShader extends hxsl.Shader
{
    static var SRC = {
        
        // Шейдер, от которого мы наследуемся.
        // Из него мы имеем доступ ко всем его 
        // аттрибутам и константам
        @:import h3d.shader.Base2d;

        // Определяем параметр шейдера, 
        // к которому можно будет обратиться из кода
        @param var color:Vec4;
        
        // Простейший фрагментный шейдер,
        // в котором мы переопределяем цвет на выходе
        function fragment()
        {
            output.color = color;
        }
    };
}

class MyShader2 extends hxsl.Shader
{
    static var SRC = {
        
        @:import h3d.shader.Base2d;

        @param var color:Vec4;
        
        function fragment()
        {
            output.color += color;
        }
    };
}

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
        b = new h2d.Bitmap(hxd.Res.haxeLogo.toTile(), s2d);
        var s = new MyShader();
        // задаем значение параметра шейдера, 
        // который мы добавили ранее
        s.color.set(1.0, 0.0, 0.0, 1.0);
        b.addShader(s);

        // Добавляем объекту второй шейдер
        var s2 = new MyShader2();
        s2.color.set(0.0, 0.0, 1.0, 0.0);
        b.addShader(s2);

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