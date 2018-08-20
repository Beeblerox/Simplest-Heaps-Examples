class EffectShader extends hxsl.Shader
{
    static var SRC = {
        
        // Импортируем все определения из
        // базового шейдера для 3D
        @:import h3d.shader.BaseMesh;

        // Вершинный шейдер
        function vertex()
        {
            transformedPosition.z += sin(transformedPosition.y * 3 + global.time * 4) * 0.5;
        }
        
        // Фрагментный шейдер
        function fragment()
        {
            output.color.r *= transformedPosition.z;
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

    var obj:h3d.scene.Mesh;

    override function init() 
    {
        // Создаем простой куб и подготавливаем его для текстурирования
		var prim = new h3d.prim.Cube();
		prim.translate( -0.5, -0.5, -0.5);
		// Данная операция необходима для расчета нормалей каждой грани
		prim.unindex();
		// Добавление данных о нормалях вершин
		prim.addNormals();
		// Добавление данных о текстурных координатах
		prim.addUVs();

		// Загрузка текстуры для нашего куба
		var tex = hxd.Res.hxlogo.toTexture();

		// Создаем текстурированный материал
		var mat = h3d.mat.Material.create(tex);

		// Создаем Меш и добавляем его на сцену
		obj = new h3d.scene.Mesh(prim, mat, s3d);
		// Отключаем тени у материала куба
		obj.material.shadows = false;

        // Задаем шейдер для нашего объекта типа Mesh
        obj.material.mainPass.addShader(new EffectShader());

		// Настройка освещения на сцене
		var light = new h3d.scene.DirLight(new h3d.Vector(0.5, 0.5, -0.5), s3d);
		light.enableSpecular = true;

		s3d.lightSystem.ambientLight.set(0.3, 0.3, 0.3);

        // Создаем простой контроллер для камеры,
        // чтобы ей можно было управлять мышью
        new h3d.scene.CameraController(s3d).loadFromCamera();

        engine.backgroundColor = 0xFF808080;
    }
}