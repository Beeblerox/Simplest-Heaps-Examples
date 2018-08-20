class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initLocal();
        
        new Game();
    }

    var obj:h3d.scene.Object;

    override function init() 
    {
        // Загружаем модель и добавляем объект на сцену
        var cache = new h3d.prim.ModelCache();
        obj = cache.loadModel(hxd.Res.Model);
        obj.scale(0.05);
        obj.rotate(0, 0, Math.PI);
        s3d.addChild(obj);

        // Загружаем анимацию, зашитую в Model.fbx
        var anim = cache.loadAnimation(hxd.Res.Model);
        // Воспроизводим анимацию
        // Обратите внимание, что одну и ту же анимацию
        // можно применять к разным моделям
        obj.playAnimation(anim);

        // Настраиваем освещение на сцене
        var light = new h3d.scene.DirLight(new h3d.Vector( 0.3, -0.4, -0.9), s3d);
		light.enableSpecular = true;
		light.color.set(0.28, 0.28, 0.28);
		s3d.lightSystem.ambientLight.set(0.74, 0.74, 0.74);

        // Создаем простой контроллер для камеры,
        // чтобы ей можно было управлять мышью
        new h3d.scene.CameraController(s3d).loadFromCamera();

        engine.backgroundColor = 0xFF808080;
    }
}