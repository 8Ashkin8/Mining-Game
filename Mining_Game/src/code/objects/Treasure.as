package code.objects 
{
	import code.system.Registry;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Treasure extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/objects/chest.png')] public var ImgChest:Class;
		[Embed(source = '../../assets/sound/sfx/ammochest.mp3')] public var SndAmmo:Class;
		[Embed(source = '../../assets/sound/sfx/bombchest.mp3')] public var SndBomb:Class;
		[Embed(source = '../../assets/sound/sfx/cursechest.mp3')] public var SndCurse:Class;
		[Embed(source = '../../assets/sound/sfx/energychest.mp3')] public var SndEnergy:Class;
		[Embed(source = '../../assets/sound/sfx/goldchest.mp3')] public var SndGold:Class;
		
		
		public var timer:uint;
		public var opened:Boolean;
		public var random:int;
		public var rndm:int;
		public var infocus:Boolean = false;
		
		public var registry:Registry;
		
		public function Treasure(_registry:Registry, X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgChest, true, false, 8, 8);
			width = 8;
			height = 8;
			addAnimation("normal", [0], 10, true);
			addAnimation("open", [0, 1, 2, 3], 10, false);
			
			registry = _registry;
			
			acceleration.y = 600;
			maxVelocity.y = 300;
			
			opened = false;
			timer = 30;
			
			registry.objects.add(this);
		}
		
		override public function update():void
		{
			if (x > registry.player.x - 500 && x < registry.player.x + 500 && y > registry.player.y - 500 && y < registry.player.y + 500)
			{
				solid = true;
				if (opened == false)
				{
					play("normal");
				}
				if (FlxG.overlap(registry.player, this) && opened == false && FlxG.keys.justPressed("S"))
				{
					var random:Number = Math.round(Math.random() * 4);
					
					if (random == 0)
					{
						open("gold");
					}
					if (random == 1)
					{
						open("bomb");
					}
					if (random == 2)
					{
						open("ammo");
					}
					if (random == 3)
					{
						open("energy");
					}
					if (random == 4)
					{
						curse();
					}
					
					opened = true;
				}
				
				if (timer <= 0 && opened == true)
				{
					registry.objects.remove(this, true);
					destroy();
				}
				super.update();
				if (opened == true && timer > 0)
				{
					timer -= FlxG.elapsed;
					alpha -= FlxG.elapsed;
				}
			}
			else
			{
				solid = false;
			}
			if (solid)
			{
				acceleration.y = 600;
			}
			else if (!solid)
			{
				acceleration.y = 0;
			}
		}
		
		public function open(prize:String):void
		{
			play("open", false);
			timer = 100;
			if (prize == "gold")
			{
				registry.player.score += 100;
				registry.chestgoldparticles.at(this);
				registry.chestgoldparticles.emitParticle();
				registry.chestgoldparticles.setAll("alpha", 100);
				FlxG.play(SndGold);
			}
			if (prize == "bomb")
			{
				registry.player.bombs += 1;
				registry.chestbombparticles.at(this);
				registry.chestbombparticles.emitParticle();
				registry.chestbombparticles.setAll("alpha", 100);
				FlxG.play(SndBomb);
			}
			if (prize == "ammo")
			{
				registry.player.ammo += 1;
				registry.chestammoparticles.at(this);
				registry.chestammoparticles.emitParticle();
				registry.chestammoparticles.setAll("alpha", 100);
				FlxG.play(SndAmmo);
			}
			if (prize == "energy")
			{
				registry.player.energy += 1000;
				registry.chestenergyparticles.at(this);
				registry.chestenergyparticles.emitParticle();
				registry.chestenergyparticles.setAll("alpha", 100);
				FlxG.play(SndEnergy);
			}
		}
		
		public function curse():void
		{
			play("open", false);
			timer = 100;
			
			FlxG.play(SndCurse);
			
			/*
			 * Curse list
			 * sapper- Drains energy at a fast rate.
			 * goldthief- Subtracts gold from total score over time.
			 * grounded- Jetpack becomes useless.
			 * sticky- Cannot move while on the ground.
			 * pickbreak- Cannot dig.
			 * stone- Very heavy.
			 * ammodrop- Lose one ammo.
			 * bombdrop- One of your bombs is set off and falls on the ground near you.
			 */
			
			rndm = Math.random() * 6 + 1;
			
			registry.chestcurseparticles.at(this);
			registry.chestcurseparticles.emitParticle();
			registry.chestcurseparticles.setAll("alpha", 100);
			
			switch (rndm)
			{
				case 1:
					registry.player.curse = "sapper";
					registry.player.cursetimer = 20;
					break;
				
				case 2:
					registry.player.curse = "goldthief";
					break;
				
				case 3:
					registry.player.curse = "grounded";
					registry.player.cursetimer = 20;
					break;
				
				case 4:
					registry.player.curse = "sticky";
					registry.player.cursetimer = 20;
					break;
				
				case 5:
					registry.player.curse = "pickbreak";
					registry.player.cursetimer = 20;
					break;
				
				case 6:
					registry.player.curse = "stone";
					registry.player.cursetimer = 20;
					break;
				
				case null:
					break;
			}
		}
	}

}