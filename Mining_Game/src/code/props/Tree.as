package code.props 
{
	import code.system.Registry;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Tree extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/props/trees.png')] public var ImgTrees:Class;
		[Embed(source = '../../assets/graphics/particles/leaves.png')] public var ImgLeaves:Class;
		
		public var registry:Registry;
		public var leafemitter:FlxEmitter;
		
		public function Tree(X:int, Y:int, _registry:Registry) 
		{
			registry = _registry
			super(X, Y);
			
			loadGraphic(ImgTrees, true, true, 8, 16);
			
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
			
			leafemitter = new FlxEmitter(x, y);
			leafemitter.setSize(8, 8);
			leafemitter.setXSpeed(5, 20);
			leafemitter.setYSpeed(1, 5);
			leafemitter.makeParticles(ImgLeaves, 10, 16, true);
			leafemitter.start(false, 0, 1);
			leafemitter.on = false;
			
			registry.emitters.add(leafemitter);
		}
		
		override public function update():void
		{
			if (onScreen(registry.camera))
			{
				leafemitter.on = true;
				
				if (registry.collisionmap.getTile(x / 8, y / 8 + 2) == 0)
				{
					destroy();
				}
				
				super.update();
			}
			
			else
			{
				leafemitter.on = false;
			}
		}
		
		override public function destroy():void
		{
			leafemitter.on = false;
			registry.surfaceprops.remove(this);
			super.destroy();
		}
		
	}
}