package;

import h2d.Scene;

class Camera extends h2d.Sprite
{
    public var viewX(get, set):Float;
    public var viewY(get, set):Float;

    var scene:Scene;

    public function new(scene:Scene)
    {
        super(scene);
        this.scene = scene;
    }

    private function set_viewX(value:Float):Float
    {
        this.x = 0.5 * scene.width - value;
        return value;
    }

    private function get_viewX():Float
    {
        return 0.5 * scene.width - this.x;
    }

    private function set_viewY(value:Float):Float
    {
        this.y = 0.5 * scene.height - value;
        return value;
    }

    private function get_viewY():Float
    {
        return 0.5 * scene.height - this.y;
    }
}