/**
 * Heaps sound effect usage example.
 * Sound effects modify how it will sound :)
 * You can find all supported effects in hxd.snd.effect package:
 * Reverb, LowPass, Pitch, Spatialization are in Heaps v. 1.5.0
 * This demo will work correctly only on HashLink target.
 * (i think that sound effects are not supported on html5 target currently)
 */
class Game extends hxd.App
{
    static function main()
    {
        hxd.Res.initEmbed();
        new Game();
    }

    // Array of reverb effect presets we will be using in this demo
    var presets:Array<hxd.snd.effect.ReverbPreset>;
    // current index of preset to use
	var presetIndex:Int = 0;

    override function init() 
    {
        presets = [];

        // Let's just read all presets that are avaiable in ReverbPreset class.
        // They are static fields of this class (for example, DEFAULT and GENERIC).
        // You can see this list yourself just by opening `hxd.snd.effect.ReverbPreset` file
        // But i just lazy to manually type their names here, so i'll use some reflection:
		var presetsFields = Reflect.fields(hxd.snd.effect.ReverbPreset);
		for (f in presetsFields)
		{
			var firstChar = f.charAt(0);
			if (firstChar.toUpperCase() == firstChar)
			{
				presets.push(Reflect.field(hxd.snd.effect.ReverbPreset, f));
			}
		}
    }

    override function update(dt:Float) 
    {
        // we will be listening for Space key to play sound with applied effect.
        if (hxd.Key.isPressed(hxd.Key.SPACE)) 
		{
			// let's play sound
            var channel = hxd.Res.sound_fx.play();
            // and apply sound effect to newly created sound channel
			channel.addEffect(new hxd.snd.effect.Reverb(presets[presetIndex]));

            // btw, usually you'll apply it this way:
            // channel.addEffect(new hxd.snd.effect.Reverb(hxd.snd.effect.ReverbPreset.CONCERTHALL));
            
            // update preset index so it will be in array bounds
			presetIndex++;
			presetIndex %= presets.length;
		}
    }
}