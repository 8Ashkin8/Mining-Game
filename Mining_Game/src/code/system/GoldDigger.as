package code.system 
{
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class GoldDigger extends Digger
	{
		
		
		public function GoldDigger(_registry:Registry, X:int, Y:int, iterations:int) 
		{
			super(X, Y, iterations, 0, false);
			
			registry = _registry;
		}
		
		override public function dig():void
		{
			random = Math.random() * 4;
			switch (random)
			{
				case 0:
					if (x > 1)
					{
						x -= 1;
					}
					else if (x <= 1)
					{
						destroy();
					}
					break;
				
				case 1:
					if (y > 1) 
					{
						y -= 1;
					}
					else if (y <= 1)
					{
						destroy();
					}
					break;
				
				case 2:
					if (x < registry.map.width - 2) 
					{
						x += 1;
					}
					else if (x >= registry.map.width - 2)
					{
						destroy();
					}
					break;
				
				case 3:
					if (y < registry.map.height - 2) 
					{
						y += 1;
					}
					else if (y >= registry.map.height - 2)
					{
						destroy();
					}
					break;
				
				case 4:
					if (x > 1) 
					{
						x -= 1;
					}
					else if (x <= 1)
					{
						destroy();
					}
					break;
				
				default:
					break;
			}
			registry.goldmap.setPixel(x, y, 0xFFFFFFFF);
			
			if (FlxU.round(Math.random() * 100) < 1)
			{
				registry.diggers.add(new GoldDigger(registry, x, y, totiteration - curiteration));
			}
			
			curiteration += 1;
			if (curiteration >= totiteration)
			{
				destroy();
			}
		}
	}

}