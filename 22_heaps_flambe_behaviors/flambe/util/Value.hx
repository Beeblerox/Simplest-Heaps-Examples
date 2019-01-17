//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.util;

/**
 * Wraps a single value.
 */
#if !js
@:generic // Generate typed templates on static targets
#end
class Value<A>
{
    /**
     * The wrapped value, setting this to a different value will fire the `changed` signal.
     */
    public var _ (get, set) :A;

    public function new (value :A)
    {
        _value = value;
    }

    inline private function get__ () :A
    {
        return _value;
    }

    private function set__ (newValue :A) :A
    {
        return _value = newValue;
    }

    #if debug @:keep #end public function toString () :String
    {
        return ""+_value;
    }

    private var _value :A;
}
