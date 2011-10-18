package code.system 
{
	import flash.display.BitmapData;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class LightObject extends FlxSprite
	{
		public var registry:Registry;
		public var lightobject:LightCast
		
		public function LightObject(_registry:Registry, _lightobject:LightCast) 
		{
			registry = _registry;
			lightobject = _lightobject
			super(0, 0);
			makeGraphic(800, 800);
		}
		
		override public function update():void
		{
			trace(lightobject.bitmapholder);
			super.update();
		}
	}

}