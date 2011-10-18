package code.props 
{
	import code.system.Registry;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Boulder extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/props/boulders.png')] public var ImgBoulders:Class;
		
		public var registry:Registry;
		
		public function Boulder(X:int, Y:int, _registry:Registry) 
		{
			registry = _registry
			super(X, Y);
			
			loadGraphic(ImgBoulders, true, true, 8, 8);
			
			addAnimation("1", [0], 0, true);
			addAnimation("2", [1], 0, true);
			addAnimation("3", [2], 0, true);
			addAnimation("4", [3], 0, true);
			addAnimation("5", [4], 0, true);
			
			var random:int = Math.round(Math.random() * 4);
			
			if (random == 0)
			{
				play("1");
			}
			if (random == 1)
			{
				play("2");
			}
			if (random == 2)
			{
				play("3");
			}
			if (random == 3)
			{
				play("4");
			}
			if (random == 4)
			{
				play("5");
			}
			
			var random2:int = Math.round(Math.random());
			if (random2 == 0)
			{
				facing = LEFT;
			}
			if (random2 == 1)
			{
				facing == RIGHT;
			}
		}
		
		override public function update():void
		{
			if (onScreen(registry.camera))
			{
				if (registry.collisionmap.getTile(x / 8, y / 8 + 1) == 0)
				{
					destroy();
				}
				
				super.update();
			}
		}
		
		override public function destroy():void
		{
			registry.surfaceprops.remove(this);
			super.destroy();
		}
		
	}
}