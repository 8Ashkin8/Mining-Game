package code.system 
{
	import flash.display.Sprite;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class LightThing extends FlxSprite
	{
		public var registry:Registry;
		public var lightcaster:LightCast;
		
		public function LightThing(_registry:Registry, _lightcaster:LightCast) 
		{
			registry = _registry;
			lightcaster = _lightcaster;
			loadGraphic(lightcaster.graphics as Class);
			super(0, 0);
		}
		
		override public function update():void
		{
			loadGraphic(lightcaster.graphics as Class);
			super.update();
		}
	}

}