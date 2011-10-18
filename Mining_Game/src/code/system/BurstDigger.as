package code.system 
{
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class BurstDigger extends Digger
	{
		
		
		public function BurstDigger(X:int, Y:int, iterations:int, direction:String = null) 
		{
			super(X, Y, 50, direction, 3);
		}
		
		override public function dig():void
		{
			switch (dir)
			{
				case null:
					random = FlxU.round(Math.random() * 4);
					break;
				
				case 'north':
					random = FlxU.round(Math.random() * 2);
					break;
				
				case 'east':
					random = FlxU.round(Math.random() * 3.5);
					break;
				
				case 'south':
					random = FlxU.round(Math.random() * 3.5 + 1);
					break;
				
				case 'west':
					random = FlxU.round(Math.random() * 4.5);
				
				default:
					dir = null;
					break;
			}
			
			CaveGen.map.setPixel(x, y, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 1, y, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 2, y, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 3, y, 0xFFFFFFFF);
			CaveGen.map.setPixel(x, y + 1, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 1, y + 1, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 2, y + 1, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 3, y + 1, 0xFFFFFFFF);
			CaveGen.map.setPixel(x, y + 2, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 1, y + 2, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 2, y + 2, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 3, y + 2, 0xFFFFFFFF);
			CaveGen.map.setPixel(x, y + 3, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 1, y + 3, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 2, y + 3, 0xFFFFFFFF);
			CaveGen.map.setPixel(x + 3, y + 3, 0xFFFFFFFF);
			
			switch (random)
			{
				case 0:
					if (x > 2)
					{
						x -= 2;
					}
					break;
				
				case 1:
					if (y > 2) 
					{
						y -= 2;
					}
					break;
				
				case 2:
					if (x < CaveGen.map.width - 3) 
					{
						x += 2;
					}
					break;
				
				case 3:
					if (y < CaveGen.map.height - 3) 
					{
						y += 2;
					}
					break;
				
				case 4:
					if (x > 2) 
					{
						x -= 2;
					}
					break;
				
				default:
					break;
			}
			
			if (FlxU.round(Math.random() * 100) < 5)
			{
				CaveGen.diggers.add(new DiggerXL(x, y, 50, dir));
			}
		}
	}

}