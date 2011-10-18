package code.props 
{
	import code.system.Registry;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Cloud extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/props/clouds.png')] public var ImgClouds:Class;
		
		public var registry:Registry;
		
		public function Cloud(_registry:Registry) 
		{
			registry = _registry;
			super(Math.random() * registry.tilemap.width, Math.random() * 200);
			loadGraphic(ImgClouds, true, true, 64, 32);
			
			
			
			addAnimation("0", [0]);
			addAnimation("1", [1]);
			addAnimation("2", [2]);
			addAnimation("3", [3]);
			
			var random1:int = Math.random() * 4;
			switch (random1)
			{
				case 0:
					play("0");
					break;
				
				case 1:
					play("1");
					break;
				
				case 2:
					play("2");
					break;
				
				case 3:
					play("3");
					break;
				
				default:
					play("0");
					break;
			}
			
			var random2:int = Math.random() * 2;
			switch (random2)
			{
				case 0:
					facing = RIGHT;
					break;
				
				case 1:
					facing = LEFT;
					break;
				
				default:
					break;
			}
			
			velocity.x = Math.random() * 10;
		}
		
		override public function update():void
		{
			if (x > registry.tilemap.width + width)
			{
				wrap();
			}
			
			super.update();
		}
		
		public function wrap():void
		{
			x = 0 - width;
			
			var random1:int = Math.random() * 4;
			switch (random1)
			{
				case 0:
					play("0");
					break;
				
				case 1:
					play("1");
					break;
				
				case 2:
					play("2");
					break;
				
				case 3:
					play("3");
					break;
				
				default:
					play("0");
					break;
			}
			
			var random2:int = Math.random() * 2;
			switch (random2)
			{
				case 0:
					facing = RIGHT;
					break;
				
				case 1:
					facing = LEFT;
					break;
				
				default:
					break;
			}
			
			velocity.x = Math.random() * 10;
		}
	}

}