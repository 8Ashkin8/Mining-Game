package code.props 
{
	import code.system.Registry;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Mushroom extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/props/mushrooms.png')] public var ImgMushrooms:Class;
		
		public var added:Boolean = false;
		public var registry:Registry;
		
		public function Mushroom(_registry:Registry, X:int, Y:int) 
		{
			registry = _registry;
			super(X, Y);
			loadGraphic(ImgMushrooms, true, true, 8, 8);
			
			addAnimation("1", [0], 0, true);
			addAnimation("2", [1], 0, true);
			addAnimation("3", [2], 0, true);
			addAnimation("4", [3], 0, true);
			
			var random:int = Math.round(Math.random() * 3);
			
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
			if (x > registry.player.x - 500 && x < registry.player.x + 500 && y > registry.player.y - 500 && y < registry.player.y + 500)
			{
				if (registry.collisionmap.getTile(x / 8, y / 8 + 1) == 0)
				{
					destroy();
				}
				if (registry.collisionmap.getTile(x / 8, y / 8) != 0)
				{
					destroy();
				}
				if (added == false)
				{
					registry.lights.add(this);
					exists = true;
					added = true;
				}
			}
			else
			{
				if (added == true)
				{
					registry.lights.remove(this, true);
					exists = false;
					added = false;
				}
				if (registry.diggers.length != 0)
				{
					if (registry.collisionmap.getTile(x / 8, y / 8 + 1) == 0)
					{
						destroy();
					}
					if (registry.collisionmap.getTile(x / 8, y / 8) != 0)
					{
						destroy();
					}
				}
			}
		}
		
		override public function destroy():void
		{
			registry.lights.remove(this, true);
			registry.mushrooms.remove(this);
			super.destroy();
		}
	}

}