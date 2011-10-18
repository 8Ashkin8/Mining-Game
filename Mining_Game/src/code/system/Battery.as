package code.system 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Battery extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/HUD/battery.png')] public var ImgBattery:Class;
		
		public var maximum:int = 0;
		public var minimum:int = 0;
		public var value:int = 0;
		
		public var registry:Registry;
		
		public function Battery(_registry:Registry, max:int, min:int) 
		{
			super();
			loadGraphic(ImgBattery, true, false, 8, 10);
			addAnimation("10", [0], 10, true);
			addAnimation("9", [1], 10, true);
			addAnimation("8", [2], 10, true);
			addAnimation("7", [3], 10, true);
			addAnimation("6", [4], 10, true);
			addAnimation("5", [5], 10, true);
			addAnimation("4", [6], 10, true);
			addAnimation("3", [7], 10, true);
			addAnimation("2", [8], 10, true);
			addAnimation("1", [9], 10, true);
			
			registry = _registry;
			
			maximum = max;
			minimum = min;
			
			value = (maximum - minimum) / 10;
			
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			
			y = 52;
			
			if (registry.healthbar.length == 0) x = 6;
			if (registry.healthbar.length == 1) x = 16;
			if (registry.healthbar.length == 2) x = 26;
			if (registry.healthbar.length == 3) x = 36;
			if (registry.healthbar.length == 4) x = 46;
			if (registry.healthbar.length == 5) x = 56;
			if (registry.healthbar.length == 6) x = 66;
			if (registry.healthbar.length == 7) x = 76;
			if (registry.healthbar.length == 8) x = 86;
			if (registry.healthbar.length == 9) x = 96;
		}
		
		override public function update():void
		{
			if (registry.player.energy >= maximum - (value * 1))
			{
				play("10");
				visible = true;
			}
			if (registry.player.energy >= maximum - (value * 2) && registry.player.energy < maximum - (value * 1))
			{
				play("9");
				visible = true;
			}
			if (registry.player.energy >= maximum - (value * 3) && registry.player.energy < maximum - (value * 2))
			{
				play("8");
				visible = true;
			}
			if (registry.player.energy >= maximum - (value * 4) && registry.player.energy < maximum - (value * 3))
			{
				play("7");
				visible = true;
			}
			if (registry.player.energy >= maximum - (value * 5) && registry.player.energy < maximum - (value * 4))
			{
				play("6");
				visible = true;
			}
			if (registry.player.energy >= maximum - (value * 6) && registry.player.energy < maximum - (value * 5))
			{
				play("5");
				visible = true;
			}
			if (registry.player.energy >= maximum - (value * 7) && registry.player.energy < maximum - (value * 6))
			{
				play("4");
				visible = true;
			}
			if (registry.player.energy >= maximum - (value * 8) && registry.player.energy < maximum - (value * 7))
			{
				play("3");
				visible = true;
			}
			if (registry.player.energy >= maximum - (value * 9) && registry.player.energy < maximum - (value * 8))
			{
				play("2");
				visible = true;
			}
			if (registry.player.energy > minimum && registry.player.energy < maximum - (value * 9))
			{
				play("1");
				visible = true;
			}
			if (registry.player.energy <= minimum)
			{
				visible = false;
			}
		}
	}

}