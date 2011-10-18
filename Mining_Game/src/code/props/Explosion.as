package code.props 
{
	import code.system.Registry;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Explosion extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/particles/explosion.png')] public var ImgExplosion:Class;
		
		public var timer:Number;
		public var registry:Registry;
		
		public function Explosion(_registry:Registry, X:Number, Y:Number)
		{
			registry = _registry;
			
			super(X, Y);
			
			loadGraphic(ImgExplosion, true, false, 32, 32);
			centerOffsets();
			addAnimation("explode", [0, 1, 2, 3, 4, 5], 10, false);
			play("explode");
			
			var rndm:Number = Math.random() + 1;
			scale.x = rndm;
			scale.y = rndm;
			
			timer = 0.6;
			
			registry.lights.add(this);
		}
		
		override public function destroy():void
		{
			registry.lights.remove(this, true);
			registry.explosions.remove(this);
			super.destroy();
		}
		
		override public function update():void
		{
			if (timer <= 0)
			{
				destroy();
			}
			super.update();
			timer -= FlxG.elapsed;
		}
	}

}