package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import code.props.Boulder;
	import code.props.Cloud;
	import code.props.Explosion;
	import code.props.Tree;
	
	import code.system.Battery;
	import code.system.BurstDigger;
	import code.system.Digger
	import code.system.DiggerL;
	import code.system.DiggerS;
	import code.system.DiggerXL;
	import code.system.GoldDigger;
	import code.system.Light;
	import code.system.LightCast;
	import code.system.LightObject;
	import code.system.LightThing;
	import code.system.Registry;
	import code.system.Score;
	
	import code.objects.Player;
	import code.objects.Treasure;
	
	import org.flixel.FlxCamera;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class CaveGen extends FlxState
	{
		//Font
		[Embed(source = 'assets/font/tiny.ttf', fontFamily = 'Tiny', embedAsCFF = 'false')] public var FntTiny:String;
		
		//Tilesets
		[Embed(source = 'assets/graphics/tilesets/tileset_weak.png')] public var tileset:Class;
		[Embed(source = 'assets/graphics/tilesets/tileset_tiny.png')] public var tilesettiny:Class;
		[Embed(source = 'assets/graphics/tilesets/tilesetcollision.png')] public var tilesetcollision:Class;
		[Embed(source = 'assets/graphics/tilesets/tileset_bg.png')] public var tilesetbg:Class;
		[Embed(source = 'assets/graphics/tilesets/tileset_scenery.png')] public var tilesetscenery:Class;
		
		//Particles
		[Embed(source = 'assets/graphics/particles/jetparticle.png')] public var PartJet:Class;
		[Embed(source = 'assets/graphics/particles/tile.png')] public var PartTile:Class;
		[Embed(source = 'assets/graphics/particles/goldparticle.png')] public var PartGold:Class;
		[Embed(source = 'assets/graphics/particles/partflame.png')] public var PartFlame:Class;
		[Embed(source = 'assets/graphics/particles/partsmoke.png')] public var PartSmoke:Class;
		[Embed(source = 'assets/graphics/particles/partexplosion.png')] public var PartExplosion:Class;
		[Embed(source = 'assets/graphics/particles/particleammo.png')] public var ChestPartAmmo:Class;
		[Embed(source = 'assets/graphics/particles/particlebomb.png')] public var ChestPartBomb:Class;
		[Embed(source = 'assets/graphics/particles/particlecurse.png')] public var ChestPartCurse:Class;
		[Embed(source = 'assets/graphics/particles/particleenergy.png')] public var ChestPartEnergy:Class;
		[Embed(source = 'assets/graphics/particles/particlegold.png')] public var ChestPartGold:Class;
		
		//Pretties
		[Embed(source = 'assets/graphics/system/light.png')] public var ImgLight:Class;
		[Embed(source = 'assets/graphics/props/grass.png')] public var ImgGrass:Class;
		[Embed(source = 'assets/graphics/backgrounds/skygradient.png')] public var ImgSkyGradient:Class;
		
		//HUD
		[Embed(source = 'assets/graphics/HUD/hud.png')] public var ImgHud:Class;
		[Embed(source = 'assets/graphics/HUD/pwrlight.png')] public var ImgPwrlight:Class;
		
		//Cursor
		[Embed(source = 'assets/graphics/HUD/cursor.png')] public var ImgCursor:Class;
		
		//Tilemap Helper
		public var tilemapswitch:Boolean;
		
		//Crater Helpers
		public var craterswitch:Boolean;
		
		//Objects
		public var digger:DiggerL;
		
		//Emitter Helper
		public var emitterswitch:Boolean;
		
		
		//HUD
		public var hud:FlxSprite;
		public var powerlight:FlxSprite;
		
		//Pretties
		public static var darkness:FlxSprite;
		public var darkfill:uint;
		public var sky:FlxSprite;
		public var cloudmap:BitmapData;
		public var clouds:FlxGroup;
		
		//Size Variables
		public var iterations:int;
		public var size:int;
		public var rndm:int;
		public var progressbar:FlxSprite;
		
		//Time
		public var time_min:Number;
		public var time_sec:Number;
		public var timedisplay1:FlxText;
		public var timedisplay2:FlxText;
		public var timedisplay3:FlxText;
		public var timedisplay4:FlxText;
		
		//Score
		public var scoredisplay1:FlxText;
		public var scoredisplay2:FlxText;
		public var scoredisplay3:FlxText;
		public var scoredisplay4:FlxText;
		public var scoredisplay5:FlxText;
		public var scoredisplay6:FlxText;
		
		//Bombs
		public var bombsdisplay:FlxText;
		
		//Ammo
		public var ammodisplay:FlxText;
		
		//Score array
		public var scoresave:FlxSave;
		
		
		//The Registry!
		public var registry:Registry;
		
		public var lightcaster:LightCast;
		
		override public function create():void
		{
			registry = new Registry();
			scoresave = new FlxSave();
			scoresave.bind("highscores");
			if (scoresave.data.highscores == null)
			{
				scoresave.data.highscores = new Array();
			}
			
			emitterswitch = false;
			size = 2;
			iterations = 300;
			if (size == 1)
			{
				registry.map = new BitmapData(100, 100, true, 0xFF000000);
				registry.goldmap = new BitmapData(100, 100, true, 0xFF000000);
			}
			if (size == 2)
			{
				registry.map = new BitmapData(400, 400, true, 0xFF000000);
				registry.goldmap = new BitmapData(400, 400, true, 0xFF000000);
			}
			if (size == 3)
			{
				registry.map = new BitmapData(800, 800, true, 0xFF000000);
				registry.goldmap = new BitmapData(800, 800, true, 0xFF000000);
			}
			registry.diggers = new FlxGroup();
			tilemapswitch = false;
			craterswitch = false;
			FlxG.mouse.hide();
			FlxG.bgColor = 0x0000110E;
			for (var t:int = 0; t < registry.goldmap.width * registry.goldmap.height; t++)
			{
				if (Math.random() * 1000 <= 1)
				{
					var X:int = Math.random() * registry.goldmap.width;
					var Y:int = Math.random() * registry.goldmap.height;
					registry.diggers.add(new GoldDigger(registry, X, Y, Y/5));
				}
			}
			for (var c:int = 0; c < registry.map.width * registry.map.height; c++)
			{
				if (Math.random() * 1000 <= 1)
				{
					var X3:int = Math.random() * (registry.map.width - 50) + 25;
					var Y3:int = Math.random() * (registry.map.height - 75) + 50;
					registry.diggers.add(new DiggerL(registry, X3, Y3, iterations));
				}
			}
			
			registry.chestammoparticles = new FlxEmitter(0, 0);
			registry.chestammoparticles.makeParticles(ChestPartAmmo, 5, 0, false, 0);
			registry.chestammoparticles.setRotation(0, 0);
			registry.chestammoparticles.setSize(1, 1);
			registry.chestammoparticles.setXSpeed(0, 0);
			registry.chestammoparticles.setYSpeed( -15, -15);
			registry.chestammoparticles.gravity = 0;
			registry.chestammoparticles.lifespan = 1;
			registry.chestammoparticles.particleDrag.y = 1;
			
			registry.chestbombparticles = new FlxEmitter(0, 0);
			registry.chestbombparticles.makeParticles(ChestPartBomb, 5, 0, false, 0);
			registry.chestbombparticles.setRotation(0, 0);
			registry.chestbombparticles.setSize(1, 1);
			registry.chestbombparticles.setXSpeed(0, 0);
			registry.chestbombparticles.setYSpeed( -15, -15);
			registry.chestbombparticles.gravity = 0;
			registry.chestbombparticles.lifespan = 1;
			registry.chestbombparticles.particleDrag.y = 1;
			
			registry.chestcurseparticles = new FlxEmitter(0, 0);
			registry.chestcurseparticles.makeParticles(ChestPartCurse, 5, 0, false, 0);
			registry.chestcurseparticles.setRotation(0, 0);
			registry.chestcurseparticles.setSize(1, 1);
			registry.chestcurseparticles.setXSpeed(0, 0);
			registry.chestcurseparticles.setYSpeed( -15, -15);
			registry.chestcurseparticles.gravity = 0;
			registry.chestcurseparticles.lifespan = 1;
			registry.chestcurseparticles.particleDrag.y = 1;
			
			registry.chestenergyparticles = new FlxEmitter(0, 0);
			registry.chestenergyparticles.makeParticles(ChestPartEnergy, 5, 0, false, 0);
			registry.chestenergyparticles.setRotation(0, 0);
			registry.chestenergyparticles.setSize(1, 1);
			registry.chestenergyparticles.setXSpeed(0, 0);
			registry.chestenergyparticles.setYSpeed( -15, -15);
			registry.chestenergyparticles.gravity = 0;
			registry.chestenergyparticles.lifespan = 1;
			registry.chestenergyparticles.particleDrag.y = 1;
			
			registry.chestgoldparticles = new FlxEmitter(0, 0);
			registry.chestgoldparticles.makeParticles(ChestPartGold, 5, 0, false, 0);
			registry.chestgoldparticles.setRotation(0, 0);
			registry.chestgoldparticles.setSize(1, 1);
			registry.chestgoldparticles.setXSpeed(0, 0);
			registry.chestgoldparticles.setYSpeed( -15, -15);
			registry.chestgoldparticles.gravity = 0;
			registry.chestgoldparticles.lifespan = 1;
			registry.chestgoldparticles.particleDrag.y = 1;
			
			registry.tileparticles1 = new FlxEmitter(0, 0);
			registry.tileparticles1.makeParticles(PartTile, 20, 16);
			registry.tileparticles1.setRotation( -20, 20);
			registry.tileparticles1.setSize(1, 1);
			registry.tileparticles1.setXSpeed(-20, 20);
			registry.tileparticles1.setYSpeed( -50, -100);
			registry.tileparticles1.gravity = 200;
			registry.tileparticles1.lifespan = 1;
			
			registry.tileparticles2 = new FlxEmitter(0, 0);
			registry.tileparticles2.makeParticles(PartGold, 20, 0);
			registry.tileparticles2.setRotation( -20, 20);
			registry.tileparticles2.setSize(8, 8);
			registry.tileparticles2.setXSpeed(-200, 200);
			registry.tileparticles2.setYSpeed( -200, 200);
			registry.tileparticles2.gravity = 200;
			registry.tileparticles2.lifespan = 0;
			registry.tileparticles2.particleDrag.x = 5;
			registry.tileparticles2.particleDrag.y = 5;
			
			registry.flameparticles = new FlxEmitter(0, 0);
			registry.flameparticles.makeParticles(PartFlame, 30, 0);
			registry.flameparticles.setRotation(0, 0);
			registry.flameparticles.setSize(1, 1);
			registry.flameparticles.setXSpeed(-20, 20);
			registry.flameparticles.setYSpeed(-50, -100);
			registry.flameparticles.lifespan = 1;
			
			registry.smokeparticles = new FlxEmitter(0, 0);
			registry.smokeparticles.makeParticles(PartSmoke, 10, 0);
			registry.smokeparticles.setRotation(0, 0);
			registry.smokeparticles.setSize(1, 1);
			registry.smokeparticles.setXSpeed(-20, 20);
			registry.smokeparticles.setYSpeed( -20, -50);
			
			registry.jetpack = new FlxEmitter(0, 0, 0);
			registry.jetpack.makeParticles(PartJet, 20, 16);
			registry.jetpack.setRotation( -10, 10);
			registry.jetpack.setSize(1, 1);
			registry.jetpack.setXSpeed( -10, 10);
			registry.jetpack.setYSpeed(50, 100);
			registry.jetpack.lifespan = 0.25;
			
			darkness = new FlxSprite(0, 0);
			darkness.makeGraphic(FlxG.width, FlxG.height , 0xFF000000);;
			darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			darkness.blend = "multiply";
			
			hud = new FlxSprite(0, 0, ImgHud);
			registry.hudcamera = new FlxCamera(0, 0, hud.width, hud.height);
			
			time_min = 0;
			time_sec = 0;
			
			powerlight = new FlxSprite(73, 73, ImgPwrlight);
			
			registry.objects = new FlxGroup();
			registry.lights = new FlxGroup();
			registry.mushrooms = new FlxGroup();
			registry.bullets = new FlxGroup();
			registry.bombs = new FlxGroup();
			registry.healthbar = new FlxGroup();
			registry.emitters = new FlxGroup();
			registry.explosions = new FlxGroup();
			registry.tilemap = new FlxTilemap();
			registry.collisionmap = new FlxTilemap();
			
			add(registry.diggers);
		}
		
		override public function draw():void
		{
			darkness.fill(darkfill);
			super.draw();
			if (tilemapswitch == true)
			{
				//darkness.stamp(lightcaster);
			}
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("ENTER"))
			{
				resetGame();
			}
			//If the registry.tilemap is created (generation stage is complete)...
			if (tilemapswitch == true)
			{
				//Time display
				time_sec += FlxG.elapsed;
				timedisplay1.text = Math.floor(time_min / 10).toString();
				timedisplay2.text = Math.floor(time_min % 10).toString();
				timedisplay3.text = Math.floor(time_sec / 10).toString();
				timedisplay4.text = Math.floor(time_sec % 10).toString();
				
				if (Math.floor(time_sec) >= 60)
				{
					time_min += 1;
					time_sec = 0;
				}
				
				//Score display
				scoredisplay1.text = Math.floor(registry.player.score % 10).toString();
				scoredisplay2.text = Math.floor((registry.player.score % 100) / 10).toString();
				scoredisplay3.text = Math.floor((registry.player.score % 1000) / 100).toString();
				scoredisplay4.text = Math.floor((registry.player.score % 10000) / 1000).toString();
				scoredisplay5.text = Math.floor((registry.player.score % 100000) / 10000).toString();
				scoredisplay6.text = Math.floor((registry.player.score % 1000000) / 100000).toString();
				
				//Bombs display
				bombsdisplay.text = registry.player.bombs.toString();
				
				//Ammo display
				ammodisplay.text = registry.player.ammo.toString();
				
				
				if (craterswitch == false && registry.tilemap.getTile(Math.round(registry.player.x/8),Math.floor(registry.player.y/8)) != 0)
				{
					registry.flameparticles.on = false;
					registry.smokeparticles.on = false;
					
					//Seven by seven circular crater
					
					//First x slice
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 3, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 3, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 3, 0);
					//Second x slice
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) - 2, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 2, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 2, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 2, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) - 2, 0);
					//Third x slice
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) - 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8) - 1, 0);
					//Fourth x slice (Player's slice)
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8), 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8), 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8), 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8), 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8), 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8), 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8), 0);
					//Fifth x slice
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) + 1, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8) + 1, 0);
					//Sixth x slice
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) + 2, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 2, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) + 2, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 2, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) + 2, 0);
					//Seventh x slice
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 3, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) + 3, 0);
					registry.collisionmap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 3, 0);
					
					//First x slice
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 3, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 3, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 3, 0);
					//Second x slice
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) - 2, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 2, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 2, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 2, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) - 2, 0);
					//Third x slice
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) - 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8) - 1, 0);
					//Fourth x slice (Player's slice)
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8), 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8), 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8), 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8), 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8), 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8), 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8), 0);
					//Fifth x slice
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) + 1, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8) + 1, 0);
					//Sixth x slice
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) + 2, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 2, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) + 2, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 2, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) + 2, 0);
					//Seventh x slice
					registry.tilemap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 3, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) + 3, 0);
					registry.tilemap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 3, 0);
					
					//First x slice
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 3) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 4, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 4, 0);
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 3) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 4, 0);
					//Second x slice
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) - 3, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 3, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 3, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 3, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) - 3, 0);
					//Third x slice
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8) - 1) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 2, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) - 2, 0);
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8) - 1) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8) - 2, 0);
					//Fourth x slice (Player's slice)
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8)) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) - 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) - 1, 0);
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8)) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8) - 1, 0);
					//Fifth x slice
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8) + 1) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 3, Math.floor(registry.player.y / 8), 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8), 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8), 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8), 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8), 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8), 0);
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8) + 1) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 3, Math.floor(registry.player.y / 8), 0);
					//Sixth x slice
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 2, Math.floor(registry.player.y / 8) + 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) + 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 1, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 2, Math.floor(registry.player.y / 8) + 1, 0);
					//Seventh x slice
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 3) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) - 1, Math.floor(registry.player.y / 8) + 2, 0);
					registry.scenerymap.setTile(Math.round(registry.player.x / 8), Math.floor(registry.player.y / 8) + 2, 0);
					if (registry.collisionmap.getTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 3) == 0) registry.scenerymap.setTile(Math.round(registry.player.x / 8) + 1, Math.floor(registry.player.y / 8) + 2, 0);
					
					registry.player.curse = null;
					
					registry.camera.shake(0.01);
					registry.camera.flash(0x33FFFFFF, 1);
					registry.explosions.add(new Explosion(registry, registry.player.x, registry.player.y));
					registry.player.controllable = true;
					registry.tileparticles1.setSize(48, 48);
					registry.tileparticles1.x = (registry.player.x) - 24;
					registry.tileparticles1.y = registry.player.y - 24;
					registry.tileparticles1.setYSpeed(-100, -200);
					registry.tileparticles1.setXSpeed(-50, 50);
					registry.tileparticles1.start();
					
					craterswitch = true;
				}
				if (registry.flameparticles.on == true)
				{
					registry.flameparticles.at(registry.player);
				}
				if (registry.smokeparticles.on == true)
				{
					registry.smokeparticles.at(registry.player);
				}
				if (emitterswitch == true)
				{
					registry.tileparticles1.setSize(1, 1);
					registry.tileparticles1.setYSpeed( -50, -100);
					registry.tileparticles1.setXSpeed( -20, 20);
					emitterswitch = false;
				}
				if (registry.tileparticles1.width > 1)
				{
					emitterswitch = true;
				}
				
				//Power light
				if (registry.player.energy > 0)
				{
					powerlight.visible = true;
				}
				
				if (registry.player.energy > 0 && registry.player.energy <= 1000)
				{
					powerlight.flicker( -1);
				}
				
				if (registry.player.energy > 1000)
				{
					powerlight.flicker(0);
				}
				
				if (registry.player.energy <= 0)
				{
					powerlight.visible = false;
				}
				
				if (registry.bgmap.getTile((registry.player.x+4)/8,(registry.player.y + 4)/8) == 1 && registry.player.y <= 400 && registry.player.y >= 360) darkfill = 0xFFA5A5A5;
				if (registry.player.y <= 500 && registry.player.y > 400) darkfill = 0xFF878787;
				if (registry.player.y <= 700 && registry.player.y > 500) darkfill = 0xFF6B6B6B;
				if (registry.player.y <= 1000 && registry.player.y > 700) darkfill = 0xFF545454;
				if (registry.player.y <= 1500 && registry.player.y > 1000) darkfill = 0xFF3D3D3D;
				if (registry.player.y <= 2000 && registry.player.y > 1500) darkfill = 0xFF212121;
				if (registry.player.y > 2000) darkfill = 0xFF000000;
				if (registry.bgmap.getTile(registry.player.x / 8, registry.player.y / 8) == 0) darkfill = 0xFFFFFFFF;
				if (craterswitch == true)
				{
					FlxG.collide(registry.player, registry.tilemap);
				}
				FlxG.collide(registry.objects, registry.tilemap);
				
				
			}
			
			if (registry.diggers.length <= 0 && tilemapswitch == false)
			{
				initializemap();
			}
			
			super.update();
		}
		
		public function initializemap():void
		{
			FlxG.mouse.show(ImgCursor);
			
			clouds = new FlxGroup();
			add(clouds);
			
			var heightmap:BitmapData = new BitmapData(registry.map.width, 1, false);
			heightmap.perlinNoise(registry.map.width, 1, 8, 0, false, true, 7, true);
			
			var skygradient:FlxSprite = new FlxSprite(0, 0);
			skygradient.loadGraphic(ImgSkyGradient, false, false, 400, 400);
			skygradient.scrollFactor.x = 0;
			skygradient.scrollFactor.y = 0.125;
			add(skygradient);
			
			var bg:BitmapData = new BitmapData(registry.map.width, registry.map.height, false, 0x000000);
			
			for (var h:int = 0; h < heightmap.width; h++)
			{
				registry.map.fillRect(new Rectangle(h, 0, 1, heightmap.getPixel(h, 0)/100000 - 40), 0xFFFFFFFF);
				bg.fillRect(new Rectangle(h, 0, 1, heightmap.getPixel(h, 0)/100000 - 40), 0xFFFFFF);
			}
			
			registry.bgmap = new FlxTilemap();
			registry.bgmap.loadMap(FlxTilemap.bitmapToCSV(bg), tilesetbg, 8, 8);
			add(registry.bgmap);
			add(registry.emitters);
			registry.tilemap.loadMap(FlxTilemap.bitmapToCSV(registry.map), tileset, 8, 8, FlxTilemap.AUTO);
			add(registry.tilemap);
			registry.collisionmap.loadMap(FlxTilemap.bitmapToCSV(registry.map), tilesetcollision, 8, 8, FlxTilemap.OFF, 0, 2, 1);
			add(registry.collisionmap);
			registry.scenerymap = new FlxTilemap();
			registry.scenerymap.loadMap(FlxTilemap.bitmapToCSV(new BitmapData(registry.map.width, registry.map.height, false, 0xFFFFFF)), tilesetscenery, 8, 8, FlxTilemap.OFF, 0, 1, 1);
			add(registry.scenerymap);
			
			for (var c:int = 0; c < Math.random() * 20 + 10; c++)
			{
				clouds.add(new Cloud(registry));
			}
			
			var tilerandom:int = Math.round(Math.random() * 2 + 1);
			if (tilerandom == 1)
			{
				FlxG.bgColor = 0xFF649BE5;
				skygradient.color = 0xFF649BE5;
				registry.surfacetop = 3;
				registry.surfacemiddle = 4;
				registry.surfacebottom = 5;
				
				registry.surfacescenery = 1;
			}
			if (tilerandom == 2)
			{
				clouds.setAll("color", 0xFFB05D84);
				FlxG.bgColor = 0xFFB0294E;
				skygradient.color = 0xFFB0294E;
				registry.surfacetop = 6;
				registry.surfacemiddle = 7;
				registry.surfacebottom = 8;
				
				registry.surfacescenery = 6;
			}
			if (tilerandom == 3)
			{
				clouds.setAll("color", 0xFFAAAAAA);
				FlxG.bgColor = 0xFF875369;
				skygradient.color = 0xFF875369;
				registry.surfacetop = 9;
				registry.surfacemiddle = 10;
				registry.surfacebottom = 11;
				
				registry.surfacescenery = 11;
			}
			
			registry.surfaceprops = new FlxGroup();
			for (var b:int = 0; b < bg.width; b++)
			{
				for (var e:int = 0; e < bg.height; e++)
				{
					if (bg.getPixel(b, e) == 0x0000000 && registry.map.getPixel(b, e) == 0x000000 && bg.getPixel(b, e-1) == 0xFFFFFF)
					{
						registry.collisionmap.setTile(b, e, registry.surfacetop);
						registry.scenerymap.setTile(b, e-1, Math.random() * 5 + registry.surfacescenery);
						if (Math.random() * 100 < 10)
						{
							if (registry.surfacetop == 6)
							{
								registry.surfaceprops.add(new Tree(b*8, e*8-16, registry));
							}
							if (registry.surfacetop == 9)
							{
								registry.surfaceprops.add(new Boulder(b * 8, e * 8 - 8, registry));
							}
						}
						if (bg.getPixel(b, e + 1) == 0x00000000)
						{
							registry.collisionmap.setTile(b, e + 1, registry.surfacemiddle);
							if (bg.getPixel(b, e + 2) == 0x00000000)
							{
								registry.collisionmap.setTile(b, e + 2, registry.surfacebottom);
								break;
							}
							break;
						}
						break;
					}
				}
			}
			
			add(registry.surfaceprops);
			
			for (var g:int = 0; g < registry.goldmap.height * registry.goldmap.width; g++)
			{
				var X_:int = g % registry.goldmap.width;
				var Y_:int = g / registry.goldmap.width;
				if (registry.goldmap.getPixel(X_, Y_) == 16777215 && registry.collisionmap.getTileByIndex(g) == 1)
				{
					registry.collisionmap.setTileByIndex(g, 2);
				}
			}
			for (var m:int = 0; m < registry.mushrooms.length; m++)
			{
				if (registry.collisionmap.getTile(registry.mushrooms.members[m].x / 8, registry.mushrooms.members[m].y / 8 + 1) != 1)
				{
					registry.mushrooms.members[m].destroy();
				}
				else if (registry.collisionmap.getTile(registry.mushrooms.members[m].x / 8, registry.mushrooms.members[m].y / 8) == 1)
				{
					registry.mushrooms.members[m].destroy();
				}
			}
			
			
			
			add(registry.explosions);
			
			add(registry.chestammoparticles);
			add(registry.chestbombparticles);
			add(registry.chestcurseparticles);
			add(registry.chestenergyparticles);
			add(registry.chestgoldparticles);
			
			add(registry.tileparticles1);
			add(registry.tileparticles2);
			
			add(registry.mushrooms);
			
			
			
			
			add(registry.bullets);
			
			add(registry.bombs);
			
			registry.flameparticles.start(false, 1, 0.1);
			add(registry.flameparticles);
			registry.smokeparticles.start(false, 3, 1);
			add(registry.smokeparticles);
			
			registry.camera = new FlxCamera(0, 0, 400, 400, 1);
			registry.camera.setBounds(0, 0, registry.tilemap.width, registry.tilemap.height, true);
			FlxG.addCamera(registry.camera);
			
			FlxG.worldBounds.x = registry.camera.x - 50;
			FlxG.worldBounds.y = registry.camera.y - 50;
			FlxG.worldBounds.height = registry.camera + 50;
			FlxG.worldBounds.width = registry.camera + 50;
			
			add(registry.jetpack);
			
			
			add(registry.objects);
			
			registry.player = new Player(registry, Math.random()*registry.tilemap.width, 0);
			add(registry.player);
			
			skygradient.x = registry.player.x - registry.player.getScreenXY(null, registry.camera).x;
			
			registry.player.curse = "grounded";
			//registry.player.controllable = false;
			
			
			registry.camera.follow(registry.player);
			
			registry.smokeparticles.at(registry.player);
			
			registry.flameparticles.at(registry.player);
			
			var light:Light = new Light(registry, darkness);
			
			add(light);
			add(registry.lights);
			
			add(darkness);
			
			//lightcaster = new LightCast(registry);
			//add(lightcaster);
			
			//var lightthing:LightObject = new LightObject(registry, lightcaster);
			//add(lightthing);
			
			add(hud);
			FlxG.addCamera(registry.hudcamera);
			
			add(powerlight);
			
			add(registry.healthbar);
			
			registry.healthbar.add(new Battery(registry, 1000, 0));
			registry.healthbar.add(new Battery(registry, 2000, 1000));
			registry.healthbar.add(new Battery(registry, 3000, 2000));
			registry.healthbar.add(new Battery(registry, 4000, 3000));
			registry.healthbar.add(new Battery(registry, 5000, 4000));
			registry.healthbar.add(new Battery(registry, 6000, 5000));
			registry.healthbar.add(new Battery(registry, 7000, 6000));
			registry.healthbar.add(new Battery(registry, 8000, 7000));
			registry.healthbar.add(new Battery(registry, 9000, 8000));
			registry.healthbar.add(new Battery(registry, 10000, 9000));
			
			timedisplay1 = new FlxText(17, 30, 11, "0", true);
			timedisplay1.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(timedisplay1);
			timedisplay2 = new FlxText(29, 30, 11, "0", true);
			timedisplay2.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(timedisplay2);
			timedisplay3 = new FlxText(53, 30, 11, "0", true);
			timedisplay3.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(timedisplay3);
			timedisplay4 = new FlxText(65, 30, 11, "0", true);
			timedisplay4.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(timedisplay4);
			
			scoredisplay1 = new FlxText(68, 10, 11, "0", true);
			scoredisplay1.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(scoredisplay1);
			scoredisplay2 = new FlxText(56, 10, 11, "0", true);
			scoredisplay2.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(scoredisplay2);
			scoredisplay3 = new FlxText(44, 10, 11, "0", true);
			scoredisplay3.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(scoredisplay3);
			scoredisplay4 = new FlxText(32, 10, 11, "0", true);
			scoredisplay4.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(scoredisplay4);
			scoredisplay5 = new FlxText(20, 10, 11, "0", true);
			scoredisplay5.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(scoredisplay5);
			scoredisplay6 = new FlxText(8, 10, 11, "0", true);
			scoredisplay6.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(scoredisplay6);
			
			bombsdisplay = new FlxText(21, 70, 11, "0", true);
			bombsdisplay.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(bombsdisplay);
			
			ammodisplay = new FlxText(53, 70, 11, "0", true);
			ammodisplay.setFormat("Tiny", 16, 0xFF30D52F, "center");
			add(ammodisplay);
			
			tilemapswitch = true;
			
			
		}
		
		public function scoreWipe():void
		{
			scoresave.data.highscores = null;
		}
		
		public function onEnd():void
		{
			if (registry.player.score > 0)
			{
				(scoresave.data.highscores as Array).push(new Score("TestName", registry.player.score, (time_min * 60) + time_sec));
				(scoresave.data.highscores as Array).sortOn("points", Array.NUMERIC);
				(scoresave.data.highscores as Array).reverse();
				for (var i:int = 0; i < (scoresave.data.highscores as Array).length; i++)
				{
					if ((scoresave.data.highscores as Array)[i] == registry.player.score)
					{
						trace("You are placed at " + i + " on the highscores table!");
					}
				}
			}
			else if (registry.player.score == 0)
			{
				trace("You came back with no gold, loser.");
			}
			FlxG.switchState(new MenuState());
		}
		public function resetGame():void
		{
			FlxG.resetGame();
		}
	}

}