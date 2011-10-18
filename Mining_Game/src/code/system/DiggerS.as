package code.system 
{
	import code.objects.Treasure;
	import code.props.Mushroom;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class DiggerS extends Digger
	{
		
		public function DiggerS(_registry:Registry, X:int, Y:int, iterations:int) 
		{
			super(X, Y, iterations, 1, true);
			
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
				
				if (registry.map.getPixel(x, y) == 0)
				{
					registry.map.setPixel(x, y, 0xFFFFFF);
				}
				
				
				if (FlxU.round(Math.random() * 100) < 1)
				{
					registry.diggers.add(new DiggerS(registry, x, y, totiteration - curiteration));
				}
				
				if (items == true)
				{
					if (Math.random() * 100 <= 5)
					{
						registry.mushrooms.add(new Mushroom(registry, x * 8, y * 8));
					}
					if (Math.random() * 1000 <= 1)
					{
						treasure = new Treasure(registry, x * 8, y * 8);
						registry.objects.add(treasure);
					}
				}
				curiteration += 1;
				if (curiteration >= totiteration)
				{
					destroy();
				}
				if (registry.map.getPixel(x + 1, y) == 0xFFFFFF && registry.map.getPixel(x - 1, y) == 0xFFFFFF && registry.map.getPixel(x, y + 1) == 0xFFFFFF && registry.map.getPixel(x, y - 1) == 0xFFFFFF)
				{
					destroy();
				}
		}
	}

}