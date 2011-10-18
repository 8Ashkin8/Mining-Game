package code.objects 
{
	import code.props.Explosion;
	import code.system.Registry;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Bullet extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/objects/bullet.png')] public var ImgBullet:Class;
		[Embed(source = '../../assets/graphics/particles/partsmoke.png')] public var PartSmoke:Class;
		
		public var explosiontimer:Number;
		public var smoke:FlxEmitter;
		public var registry:Registry;
		
		public function Bullet(_registry:Registry, X:int, Y:int) 
		{
			super(X, Y, ImgBullet);
			
			registry = _registry;
			
			maxVelocity.y = 200;
			maxVelocity.x = 200;
			
			smoke = new FlxEmitter(0, 0);
			smoke.makeParticles(PartSmoke, 10, 0);
			smoke.setRotation(0, 0);
			smoke.setSize(5, 5);
			smoke.setXSpeed(-5, 5);
			smoke.setYSpeed( -10, -20);
			smoke.start(false, 1, 0.1);
			
			explosiontimer = 2;
			
			registry.emitters.add(smoke);
		}
		
		override public function update():void
		{
			if (exists)
			{
				if (registry.collisionmap.getTile(x / 8, y / 8) != 0)
				{
					explode();
				}
				smoke.at(this);
				super.update();
			}
		}
		
		override public function revive():void
		{
			smoke.at(this);
			smoke.on = true;
			super.revive();
		}
		
		public function explode():void
		{
					//First x slice
					if (Math.random() < 0.5) registry.collisionmap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 3, 0);
					registry.collisionmap.setTile(Math.round(x / 8), Math.floor(y / 8) - 3, 0);
					if (Math.random() < 0.5) registry.collisionmap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 3, 0);
					//Second x slice
					registry.collisionmap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) - 2, 0);
					registry.collisionmap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 2, 0);
					registry.collisionmap.setTile(Math.round(x / 8), Math.floor(y / 8) - 2, 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 2, 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) - 2, 0);
					//Third x slice
					if(Math.random()<0.5)registry.collisionmap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8), Math.floor(y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) - 1, 0);
					if(Math.random()<0.5)registry.collisionmap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8) - 1, 0);
					//Fourth x slice (Player's slice)
					if(Math.random()<0.5)registry.collisionmap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8), 0);
					registry.collisionmap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8), 0);
					registry.collisionmap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8), 0);
					registry.collisionmap.setTile(Math.round(x / 8), Math.floor(y / 8), 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8), 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8), 0);
					if(Math.random()<0.5)registry.collisionmap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8), 0);
					//Fifth x slice
					if(Math.random()<0.5)registry.collisionmap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8), Math.floor(y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) + 1, 0);
					if(Math.random()<0.5)registry.collisionmap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8) + 1, 0);
					//Sixth x slice
					registry.collisionmap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) + 2, 0);
					registry.collisionmap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 2, 0);
					registry.collisionmap.setTile(Math.round(x / 8), Math.floor(y / 8) + 2, 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 2, 0);
					registry.collisionmap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) + 2, 0);
					//Seventh x slice
					if(Math.random()<0.5)registry.collisionmap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 3, 0);
					registry.collisionmap.setTile(Math.round(x / 8), Math.floor(y / 8) + 3, 0);
					if(Math.random()<0.5)registry.collisionmap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 3, 0);
					
					//First x slice
					if (registry.collisionmap.getTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 3) == 0) registry.tilemap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 3, 0);
					registry.tilemap.setTile(Math.round(x / 8), Math.floor(y / 8) - 3, 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 3) == 0) registry.tilemap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 3, 0);
					//Second x slice
					registry.tilemap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) - 2, 0);
					registry.tilemap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 2, 0);
					registry.tilemap.setTile(Math.round(x / 8), Math.floor(y / 8) - 2, 0);
					registry.tilemap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 2, 0);
					registry.tilemap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) - 2, 0);
					//Third x slice
					if (registry.collisionmap.getTile(Math.round(x / 8) - 3, Math.floor(y / 8) - 1) == 0) registry.tilemap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(x / 8), Math.floor(y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) - 1, 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 3, Math.floor(y / 8) - 1) == 0) registry.tilemap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8) - 1, 0);
					//Fourth x slice (Player's slice)
					if (registry.collisionmap.getTile(Math.round(x / 8) - 3, Math.floor(y / 8)) == 0) registry.tilemap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8), 0);
					registry.tilemap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8), 0);
					registry.tilemap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8), 0);
					registry.tilemap.setTile(Math.round(x / 8), Math.floor(y / 8), 0);
					registry.tilemap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8), 0);
					registry.tilemap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8), 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 3, Math.floor(y / 8)) == 0) registry.tilemap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8), 0);
					//Fifth x slice
					if (registry.collisionmap.getTile(Math.round(x / 8) - 3, Math.floor(y / 8) + 1) == 0) registry.tilemap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(x / 8), Math.floor(y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) + 1, 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 3, Math.floor(y / 8) + 1) == 0) registry.tilemap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8) + 1, 0);
					//Sixth x slice
					registry.tilemap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) + 2, 0);
					registry.tilemap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 2, 0);
					registry.tilemap.setTile(Math.round(x / 8), Math.floor(y / 8) + 2, 0);
					registry.tilemap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 2, 0);
					registry.tilemap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) + 2, 0);
					//Seventh x slice
					if (registry.collisionmap.getTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 3) == 0) registry.tilemap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 3, 0);
					registry.tilemap.setTile(Math.round(x / 8), Math.floor(y / 8) + 3, 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 3) == 0) registry.tilemap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 3, 0);
					
					//First x slice
					if (registry.collisionmap.getTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 3) == 0) registry.scenerymap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 4, 0);
					registry.scenerymap.setTile(Math.round(x / 8), Math.floor(y / 8) - 4, 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 3) == 0) registry.scenerymap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 4, 0);
					//Second x slice
					registry.scenerymap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) - 3, 0);
					registry.scenerymap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 3, 0);
					registry.scenerymap.setTile(Math.round(x / 8), Math.floor(y / 8) - 3, 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 3, 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) - 3, 0);
					//Third x slice
					if (registry.collisionmap.getTile(Math.round(x / 8) - 3, Math.floor(y / 8) - 1) == 0) registry.scenerymap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(x / 8), Math.floor(y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) - 2, 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 3, Math.floor(y / 8) - 1) == 0) registry.scenerymap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8) - 2, 0);
					//Fourth x slice (Player's slice)
					if (registry.collisionmap.getTile(Math.round(x / 8) - 3, Math.floor(y / 8)) == 0) registry.scenerymap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8), Math.floor(y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) - 1, 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 3, Math.floor(y / 8)) == 0) registry.scenerymap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8) - 1, 0);
					//Fifth x slice
					if (registry.collisionmap.getTile(Math.round(x / 8) - 3, Math.floor(y / 8) + 1) == 0) registry.scenerymap.setTile(Math.round(x / 8) - 3, Math.floor(y / 8), 0);
					registry.scenerymap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8), 0);
					registry.scenerymap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8), 0);
					registry.scenerymap.setTile(Math.round(x / 8), Math.floor(y / 8), 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8), 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8), 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 3, Math.floor(y / 8) + 1) == 0) registry.scenerymap.setTile(Math.round(x / 8) + 3, Math.floor(y / 8), 0);
					//Sixth x slice
					registry.scenerymap.setTile(Math.round(x / 8) - 2, Math.floor(y / 8) + 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8), Math.floor(y / 8) + 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 1, 0);
					registry.scenerymap.setTile(Math.round(x / 8) + 2, Math.floor(y / 8) + 1, 0);
					//Seventh x slice
					if (registry.collisionmap.getTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 3) == 0) registry.scenerymap.setTile(Math.round(x / 8) - 1, Math.floor(y / 8) + 2, 0);
					registry.scenerymap.setTile(Math.round(x / 8), Math.floor(y / 8) + 2, 0);
					if (registry.collisionmap.getTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 3) == 0) registry.scenerymap.setTile(Math.round(x / 8) + 1, Math.floor(y / 8) + 2, 0);
					
			registry.explosions.add(new Explosion(registry, Math.round((Math.random() * 10) + x), Math.round((Math.random() * 10) + y)));
			//registry.explosions.add(new Explosion(registry, Math.round((Math.random() * 10) + x), Math.round((Math.random() * 10) + y - 10)));
			//registry.explosions.add(new Explosion(registry, Math.round((Math.random() * 10) + x), Math.round((Math.random() * 10) + y + 10)));
			//registry.explosions.add(new Explosion(registry, Math.round((Math.random() * 10) + x - 10), Math.round((Math.random() * 10) + y)));
			//registry.explosions.add(new Explosion(registry, Math.round((Math.random() * 10) + x + 10), Math.round((Math.random() * 10) + y)));
			
			registry.camera.shake(0.005, 0.25);
			registry.camera.flash(0x33FFFFFF, 0.25);
			exists = false;
			smoke.on = false;
		}
	}

}