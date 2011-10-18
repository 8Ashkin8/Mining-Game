package code.objects
{
	import code.system.Registry;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Player extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/objects/player.png')] public var ImgPlayer:Class;
		[Embed(source = '../../assets/graphics/objects/drill.png')] public var ImgDrill:Class;
		[Embed(source = '../../assets/graphics/objects/gun.png')] public var ImgGun:Class;
		
		public var gun:FlxSprite;
		public var bomb:FlxSprite;
		public var drill:FlxSprite;
		public var aimangle:Number = 0;
		public var drillangle:String = "DOWN";
		public var bullet:Bullet;
		public var score:int = 0;
		public var energy:int = 10000;
		public var bombs:int = 3;
		public var ammo:int = 1;
		public var curse:String = null;
		public var cursetimer:Number = 0;
		public var controllable:Boolean = false;
		public var point1:FlxPoint;
		public var point2:FlxPoint;
		public var cooldowntimer:Number = 0;
		public var bulletnum:int = 0;
		public var bombnum:int = 0;
		public var gunangle:Number;
		public var centre:FlxPoint;
		public var airsliptimer:Number;
		public var tool:String = "drill";
		
		public var registry:Registry;
		
		public function Player(_registry:Registry,  X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgPlayer, true, true);
			addAnimation("idle", [0], 10, true);
			addAnimation("inactive", [5], 10, true);
			addAnimation("jump", [3], 10, true);
			addAnimation("fall", [4], 10, true);
			addAnimation("run", [0, 1, 0, 2], 10, true);
			width = 8;
			height = 8;
			origin.x = width / 2;
			origin.y = height / 2;
			centre = new FlxPoint(width / 2, height / 2);
			
			registry = _registry;
			
			gun = new FlxSprite(x, y);
			gun.loadGraphic(ImgGun, true, true, 8, 8);
			registry.objects.add(gun);
			gun.addAnimation("0", [0]);
			gun.addAnimation("1", [1]);
			gun.addAnimation("2", [2]);
			gun.addAnimation("3", [3]);
			gun.addAnimation("4", [4]);
			
			bomb = new FlxSprite(x, y);
			registry.objects.add(bomb);
			
			drill = new FlxSprite(x, y);
			drill.loadGraphic(ImgDrill, true, false, 7, 7);
			registry.objects.add(drill);
			drill.addAnimation("RIGHT_STOP", [0]);
			drill.addAnimation("RIGHT_DRILL", [0, 1, 2], 10);
			drill.addAnimation("DOWN_STOP", [3]);
			drill.addAnimation("DOWN_DRILL", [3, 4, 5], 10);
			drill.addAnimation("LEFT_STOP", [6]);
			drill.addAnimation("LEFT_DRILL", [6, 7, 8], 10);
			drill.addAnimation("UP_STOP", [9]);
			drill.addAnimation("UP_DRILL", [9, 10, 11], 10);
			
			acceleration.y = 300;
			maxVelocity.y = 100;
			drag.x = 800;
			maxVelocity.x = 100;
		}
		
		override public function update():void
		{
			//HAX
			if (FlxG.keys.justPressed("Z"))
			{
				energy = 10000;
			}
			if (FlxG.keys.justPressed("X"))
			{
				ammo = 9;
				bombs = 9;
			}
			if (tool == "drill")
			{
				drill.visible = true;
				bomb.visible = false;
				gun.visible = false;
				drillHandle();
			}
			if (tool == "bomb")
			{
				bomb.visible = true;
				drill.visible = false;
				gun.visible = false;
			}
			if (tool == "gun")
			{
				gun.visible = true;
				bomb.visible = false;
				drill.visible = false;
			}
			if (!isTouching(FLOOR) && airsliptimer <= 0)
			{
				drag.x = 800;
			}
			else if (!isTouching(FLOOR) && airsliptimer > 0)
			{
				drag.x = 0;
			}
			else if (isTouching(FLOOR))
			{
				drag.x = 800;
				airsliptimer = 0;
			}
			if (controllable == true)
			{
				if (FlxG.keys.justPressed("Q"))
				{
					switch (tool)
					{
						case "drill":
							tool = "gun";
							break;
						
						case "gun":
							tool = "bomb";
							break;
						
						case "bomb":
							tool = "drill";
							break;
					}
				}
				if (FlxG.keys.justPressed("E"))
				{
					switch (tool)
					{
						case "drill":
							tool = "bomb";
							break;
						
						case "gun":
							tool = "drill";
							break;
						
						case "bomb":
							tool = "gun";
							break;
					}
				}
				if (FlxG.mouse.justPressed())
				{
					if (tool == "gun")
					{
						airsliptimer = 2;
						gunshoot();
					}
					if (tool == "bomb")
					{
						bombdrop();
					}
				}
				if (FlxG.mouse.pressed() && tool == "drill")
				{
					dig();
				}
				else if (!FlxG.mouse.pressed() && tool == "drill")
				{
					if (drillangle == "RIGHT")
					{
						drill.play("RIGHT_STOP");
					}
					if (drillangle == "DOWN")
					{
						drill.play("DOWN_STOP");
					}
					if (drillangle == "LEFT")
					{
						drill.play("LEFT_STOP");
					}
					if (drillangle == "UP")
					{
						drill.play("UP_STOP");
					}
				}
				if (tool == "drill")
				{
					if (drillangle == "RIGHT")
					{
						drill.x = x + 8;
						drill.y = y;
					}
					if (drillangle == "DOWN")
					{
						drill.x = x;
						drill.y = y + 8;
					}
					if (drillangle == "LEFT")
					{
						drill.x = x - 8;
						drill.y = y;
					}
					if (drillangle == "UP")
					{
						drill.x = x;
						drill.y = y - 8;
					}
				}
				if (FlxG.keys.A)
				{
					if (curse != "sticky")
					{
						velocity.x -= 25;
						facing = LEFT;
						if (velocity.y == 0)
						{
							play("run");
						}
					}
					
					if (curse == "sticky" && velocity.y != 0)
					{
						velocity.x -= 25;
						facing = LEFT;
					}
				}
				if (FlxG.keys.D)
				{
					if (curse != "sticky")
					{
						velocity.x += 25;
						facing = RIGHT;
						if (velocity.y == 0)
						{
							play("run");
						}
					}
					
					if (curse == "sticky" && velocity.y != 0)
					{
						velocity.x += 25;
						facing = RIGHT;
					}
				}
				if (FlxG.keys.W && curse != "grounded")
				{
					if (curse != "stone")
					{
						velocity.y -= 20;
					}
					else if (curse == "stone")
					{
						velocity.y -= 10;
					}
					registry.jetpack.emitParticle();
				}
				
				if (!FlxG.keys.D && !FlxG.keys.A && velocity.y == 0)
				{
					play("idle");
				}
				if (velocity.y < 0)
				{
					play("jump");
				}
				if (velocity.y > 0)
				{
					play("fall");
				}
				
				switch (curse)
				{
					case "sapper":
						energy -= FlxG.elapsed * 5;
						break;
					
					case "goldthief":
						score -= 500;
						curse = null;
						break;
					
					case "stone":
						acceleration.y = 500;
						maxVelocity.y = 500;
						break;
					
					case null:
						acceleration.y = 300;
						maxVelocity.y = 200;
				}
				
				if (curse != null)
				{
					cursetimer -= FlxG.elapsed;
				}
				
				if (cursetimer < 0)
				{
					curse = null
					cursetimer = 0;
				}
			}
			energy -= FlxG.elapsed;
			if(cooldowntimer > 0) cooldowntimer -= FlxG.elapsed;
			airsliptimer -= FlxG.elapsed;
			if (energy > 0)
			{
				controllable = true;
			}
			if (energy <= 0)
			{
				controllable = false;
			}
			if (controllable == false)
			{
				play("inactive");
			}
			
			if (facing == LEFT)
			{
				registry.jetpack.x = x + 6;
				registry.jetpack.y = y + 2;
			}
			if (facing == RIGHT)
			{
				registry.jetpack.x = x + 1;
				registry.jetpack.y = y + 2;
			}
			super.update();
			gunHandle();
			if (score < 0)
			{
				score = 0;
			}
			if (ammo > 9)
			{
				ammo = 9;
			}
			if (bombs > 9)
			{
				bombs = 9;
			}
			if (ammo < 0)
			{
				ammo = 0;
			}
			if (bombs < 0)
			{
				bombs = 0;
			}
			if (x < 0)
			{
				x = 0;
			}
			if (x > registry.tilemap.width-width)
			{
				x = registry.tilemap.width-width;
			}
		}
		
		public function dig():void
		{
			if ((registry.collisionmap.getTile(drill.x / 8, drill.y / 8) == 1) || (registry.collisionmap.getTile(drill.x / 8, drill.y / 8) == registry.surfacemiddle) || (registry.collisionmap.getTile(drill.x / 8, drill.y / 8) == registry.surfacebottom))
			{
				x = Math.round(x / 8) * 8;
				y = Math.round(y / 8) * 8;
				registry.collisionmap.setTile(drill.x / 8, drill.y / 8, 0);
				registry.tilemap.setTile(drill.x / 8, drill.y / 8, 0);
				registry.tileparticles1.at(new FlxObject(drill.x, drill.y, 8, 8));
				registry.tileparticles1.emitParticle();
			}
			else if (registry.collisionmap.getTile(drill.x / 8, drill.y / 8) == registry.surfacetop)
			{
				x = Math.round(x / 8) * 8;
				y = Math.round(y / 8) * 8;
				registry.scenerymap.setTile(drill.x / 8, drill.y / 8 - 1, 0);
				registry.collisionmap.setTile(drill.x / 8, drill.y / 8, 0);
				registry.tilemap.setTile(drill.x / 8, drill.y / 8, 0);
				registry.tileparticles1.at(new FlxObject(drill.x, drill.y, 8, 8));
				registry.tileparticles1.emitParticle();
			}
			else if (registry.collisionmap.getTile(drill.x / 8, drill.y / 8 + 1) == 2)
			{
				x = Math.round(x / 8) * 8;
				y = Math.round(y / 8) * 8;
				registry.collisionmap.setTile(drill.x / 8, drill.y / 8, 0);
				registry.tilemap.setTile(drill.x / 8, drill.y / 8, 0);
				registry.tileparticles2.at(new FlxObject(drill.x, drill.y, 8, 8));
				registry.tileparticles2.start(false, 0, 0.01, 5);
				score += 10;
			}
			if (drillangle == "RIGHT") drill.play("RIGHT_DRILL");
			if (drillangle == "DOWN") drill.play("DOWN_DRILL");
			if (drillangle == "LEFT") drill.play("LEFT_DRILL");
			if (drillangle == "UP") drill.play("UP_DRILL");
		}
		
		public function bombdrop():void
		{
			if (bombs > 0)
			{
				if (registry.bombs.length - 1 < bombnum)
				{
					registry.bombs.add(new Bomb(registry, x + width / 2, y + width / 2 - 1));
				}
				else
				{
					registry.bombs.members[bombnum].reset(x + width / 2, y + width / 2 - 1);
				}
				if (facing == LEFT && !FlxG.keys.S)
				{
					registry.bombs.members[bombnum].velocity.y = -100;
					registry.bombs.members[bombnum].velocity.x = -50;
				}
				if (facing == RIGHT && !FlxG.keys.S)
				{
					registry.bombs.members[bombnum].velocity.y = -100;
					registry.bombs.members[bombnum].velocity.x = 50;
				}
				if (bombnum <= 99)
				{
					bombnum += 1;
				}
				else
				{
					bombnum = 0;
				}
				//bombs -= 1;
			}
		}
		
		public function gunshoot():void
		{
			if (ammo > 0)
			{
				if (registry.bullets.length < 100)
				{
					for (var i:int = 0; i < (100 - registry.bullets.length); i++)
					{
						registry.bullets.add(new Bullet(registry, -4, -4));
					}
				}
				var fireAngle:Number;
				registry.bullets.members[bulletnum].reset(x + width / 2, y + width / 2);
				registry.bullets.members[bulletnum].angle = gunangle;
				fireAngle = (gunangle * (Math.PI / 180));
				registry.bullets.members[bulletnum].velocity.x = (Math.cos(fireAngle) * 800)+(Math.random()*50-25);
				velocity.x += Math.cos(fireAngle - Math.PI) * 800;
				registry.bullets.members[bulletnum].velocity.y = (Math.sin(fireAngle) * 800)+(Math.random()*50-25);
				velocity.y += Math.sin(fireAngle - Math.PI) * 800;
				cooldowntimer = 0;
				if (bulletnum < 99)
				{
					bulletnum += 1;
				}
				else
				{
					bulletnum = 0;
				}
				cooldowntimer = 5;
				//ammo -= 1;
			}
		}
		
		public function drillHandle():void
		{
			var angle:Number = FlxU.getAngle(getScreenXY(null, registry.camera), new FlxPoint(FlxG.mouse.x, FlxG.mouse.y));
			if (angle >= 45 && angle < 135)
			{
				drillangle = "RIGHT";
			}
			if (angle >= 135 || angle < -135)
			{
				drillangle = "DOWN";
			}
			if (angle >= -135 && angle < -45)
			{
				drillangle = "LEFT";
			}
			if (angle >= -45 && angle < 45)
			{
				drillangle = "UP";
			}
		}
		
		public function gunHandle():void
		{
			gun.x = x;
			gun.y = y;
			
			point1 = new FlxPoint(getScreenXY(new FlxPoint(x, y), registry.camera).x, getScreenXY(new FlxPoint(x, y), registry.camera).y);
			point2 = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
			
			aimangle = FlxU.getAngle(point1, point2);
			//Right-facing
			if (aimangle >= 0 && aimangle < 36)
			{
				gunangle = -90;
				gun.play("0", true);
				gun.facing = RIGHT;
			}
			if (aimangle >= 36 && aimangle < 72)
			{
				gunangle = -45;
				gun.play("1", true);
				gun.facing = RIGHT;
			}
			if (aimangle >= 72 && aimangle < 108)
			{
				gunangle = 0;
				gun.play("2", true);
				gun.facing = RIGHT;
			}
			if (aimangle >= 108 && aimangle < 144)
			{
				gunangle = 45;
				gun.play("3", true);
				gun.facing = RIGHT;
			}
			if (aimangle >= 144 && aimangle < 180)
			{
				gunangle = 90;
				gun.play("4", true);
				gun.facing = RIGHT;
			}
			//Left-facing
			if (aimangle <= 0 && aimangle > -36)
			{
				gunangle = -90;
				gun.play("0", true);
				gun.facing = LEFT;
			}
			if (aimangle <= -36 && aimangle > -72)
			{
				gunangle = -135;
				gun.play("1", true);
				gun.facing = LEFT;
			}
			if (aimangle <= -72 && aimangle > -108)
			{
				gunangle = 180;
				gun.play("2", true);
				gun.facing = LEFT;
			}
			if (aimangle <= -108 && aimangle > -144)
			{
				gunangle = 135;
				gun.play("3", true);
				gun.facing = LEFT;
			}
			if (aimangle <= -144 && aimangle > -180)
			{
				gunangle = 90;
				gun.play("4", true);
				gun.facing = LEFT;
			}
		}
	}

}