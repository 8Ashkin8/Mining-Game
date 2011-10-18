package code.system 
{
	import code.system.Registry;
	
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Light extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/system/light.png')] public var ImgLight:Class;
		
		public var darkness:FlxSprite;
		public var registry:Registry;
		
		public function Light(_registry:Registry, _darkness:FlxSprite):void 
		{
			super(0, 0);
			loadGraphic(ImgLight, false, true, 200, 200);
			width = 200;
			height = 200;
			
			registry = _registry;
			
			darkness = _darkness;
			blend = "screen";
		}
		
		override public function update():void
		{
			
		}
		
		override public function draw():void
		{
			for (var i:int = 0; i < registry.lights.length;i++)
			{
				darkness.stamp(this, registry.lights.members[i].getScreenXY(null, registry.camera).x - (width / 2), registry.lights.members[i].getScreenXY(null, registry.camera).y - (height / 2));
			}
			darkness.stamp(this, registry.player.getScreenXY(null, registry.camera).x - (width / 2), registry.player.getScreenXY(null, registry.camera).y - (height / 2));
		}
	}

}