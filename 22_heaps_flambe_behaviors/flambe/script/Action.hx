//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.script;

/**
 * Represents a unit of execution that is called over time.
 */
interface Action
{
    /**
     * Called when the acting entity has been updated.
     *
     * @param dt The time elapsed since the last frame, in seconds.
     * @returns The amount of time in seconds spent this frame to finish the action, which may be
     *   less than dt. Or -1 if the action is not yet finished.
     */
    function update (dt :Float) :Float;
}
