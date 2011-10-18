package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = 'assets/font/tiny.ttf', fontFamily = 'Tiny', embedAsCFF = 'false')] public var FntTiny:String;
		
		[Embed(source = 'assets/graphics/menu/menucredits.png')] public var ImgCredits:Class;
		[Embed(source = 'assets/graphics/menu/menuoptions.png')] public var ImgOptions:Class;
		[Embed(source = 'assets/graphics/menu/menuplayer.png')] public var ImgPlayer:Class;
		[Embed(source = 'assets/graphics/menu/menuscore.png')] public var ImgScore:Class;
		[Embed(source = 'assets/graphics/menu/meteortail.png')] public var ImgTail:Class;
		[Embed(source = 'assets/graphics/backgrounds/starbackground.png')] public var ImgBG:Class;
		[Embed(source = 'assets/graphics/particles/debris.png')] public var ImgDebris:Class;
		[Embed(source = 'assets/graphics/menu/brightlogo.png')] public var ImgLogo:Class;
		[Embed(source = 'assets/graphics/HUD/drillcursor.png')] public var ImgCursor:Class;
		
		public var background:FlxSprite;
		
		public var logo:FlxSprite;
		
		public var score:FlxSprite;
		public var player:FlxSprite;
		public var options:FlxSprite;
		public var credits:FlxSprite;
		
		public var scoretail:FlxSprite;
		public var playertail:FlxSprite;
		public var optionstail:FlxSprite;
		public var creditstail:FlxSprite;
		
		public var scoretext:FlxText;
		public var playertext:FlxText;
		public var optionstext:FlxText;
		public var creditstext:FlxText;
		
		public var shakepoint:FlxPoint;
		
		public var scorefall :Boolean;
		public var playerfall:Boolean;
		public var optionsfall:Boolean;
		public var creditsfall:Boolean;
		
		public var random:Number;
		
		public var debris:FlxEmitter;
		
		override public function create():void
		{
			FlxG.bgColor = 0xFF000027;
			FlxG.mouse.show(ImgCursor);
			background = new FlxSprite(0, 0, ImgBG);
			
			logo = new FlxSprite(0, 10, ImgLogo);
			logo.x = FlxG.width / 2 - logo.width / 2;
			
			score = new FlxSprite((1 * ((FlxG.width - 20) / 4)) - (FlxG.width / 10), FlxG.height / 2, ImgScore);
			score.origin.x = score.width / 2;
			score.origin.y = score.height / 2;
			score.acceleration.y = 5;
			score.maxVelocity.y = 10;
			
			player = new FlxSprite((2 * ((FlxG.width - 20) / 4)) - (FlxG.width / 10), FlxG.height / 2, ImgPlayer);
			player.origin.x = player.width / 2;
			player.origin.y = player.height / 2;
			player.acceleration.y = 5;
			player.maxVelocity.y = 10;
			
			options = new FlxSprite((3 * ((FlxG.width - 20) / 4)) - (FlxG.width / 10), FlxG.height / 2, ImgOptions);
			options.origin.x = options.width / 2;
			options.origin.y = options.height / 2;
			options.acceleration.y = 5;
			options.maxVelocity.y = 10;
			
			credits = new FlxSprite((4 * ((FlxG.width - 20) / 4)) - (FlxG.width / 10), FlxG.height / 2, ImgCredits);
			credits.origin.x = credits.width / 2;
			credits.origin.y = credits.height / 2;
			credits.acceleration.y = 5;
			credits.maxVelocity.y = 10;
			
			
			scoretail = new FlxSprite(0, 0, ImgTail);
			scoretail.x = (score.x + score.width / 2) - (scoretail.width / 2);
			scoretail.y = (score.y + score.height / 2) - 115;
			
			playertail = new FlxSprite(0, 0, ImgTail);
			playertail.x = (player.x + player.width / 2) - (playertail.width / 2);
			playertail.y = (player.y + player.height / 2) - 115;
			
			optionstail = new FlxSprite(0, 0, ImgTail);
			optionstail.x = (options.x + options.width / 2) - (optionstail.width / 2);
			optionstail.y = (options.y + options.height / 2) - 115;
			
			creditstail = new FlxSprite(0, 0, ImgTail);
			creditstail.x = (credits.x + credits.width / 2) - (creditstail.width / 2);
			creditstail.y = (credits.y + credits.height / 2) - 115;
			
			scoretext = new FlxText(score.x + score.width / 2 - 100, score.y + 20, 200, "SCORES", true);
			scoretext.setFormat("Tiny", 16, 0xFFFFFF, "center");
			
			playertext = new FlxText(player.x + player.width / 2 - 100, player.y + 20, 200, "PLAY", true);
			playertext.setFormat("Tiny", 16, 0xFFFFFF, "center");
			
			optionstext = new FlxText(options.x + options.width / 2 - 100, options.y + 20, 200, "OPTIONS", true);
			optionstext.setFormat("Tiny", 16, 0xFFFFFF, "center");
			
			creditstext = new FlxText(credits.x + credits.width / 2 - 100, credits.y + 20, 200, "CREDITS", true);
			creditstext.setFormat("Tiny", 16, 0xFFFFFF, "center");
			
			debris = new FlxEmitter(0, FlxG.height + 60);
			debris.setSize(FlxG.width, 50);
			debris.setYSpeed(-200, -500);
			debris.setXSpeed( -50, 50);
			debris.lifespan = 0;
			debris.makeParticles(ImgDebris, 500, 16, true);
			debris.start(false, 0, 0.05);
			
			add(background);
			
			add(debris);
			
			add(logo);
			
			add(scoretail);
			add(score);
			add(scoretext);
			
			add(playertail);
			add(player);
			add(playertext);
			
			add(optionstail);
			add(options);
			add(optionstext);
			
			add(creditstail);
			add(credits);
			add(creditstext);
		}
		
		override public function update():void
		{
			if (score.y > FlxG.height + 500)
			{
				FlxG.fade(0xFF000000, 1, viewScore, false);
			}
			if (player.y > FlxG.height + 500)
			{
				FlxG.fade(0xFF000000, 1, startGame, false);
			}
			if (options.y > FlxG.height + 500)
			{
				FlxG.fade(0xFF000000, 1, viewOptions, false);
			}
			if (credits.y > FlxG.height + 500)
			{
				FlxG.fade(0xFF000000, 1, viewCredits, false);
			}
			
			//Shaking of menu items
			
			score.x = (1 * ((FlxG.width - 20) / 4)) - (FlxG.width / 10);
			shakepoint = shake(score);
			score.x += shakepoint.x;
			scoretail.x = (score.x + score.width / 2) - (scoretail.width / 2);
			scoretail.y = (score.y + score.height / 2) - 115;
			
			player.x = (2 * ((FlxG.width - 20) / 4)) - (FlxG.width / 10);
			shakepoint = shake(player);
			player.x += shakepoint.x;
			playertail.x = (player.x + player.width / 2) - (playertail.width / 2);
			playertail.y = (player.y + player.height / 2) - 115;
			
			options.x = (3 * ((FlxG.width - 20) / 4)) - (FlxG.width / 10);
			shakepoint = shake(options);
			options.x += shakepoint.x;
			optionstail.x = (options.x + options.width / 2) - (optionstail.width / 2);
			optionstail.y = (options.y + options.height / 2) - 115;
			
			credits.x = (4 * ((FlxG.width - 20) / 4)) - (FlxG.width / 10);
			shakepoint = shake(credits);
			credits.x += shakepoint.x;
			creditstail.x = (credits.x + credits.width / 2) - (creditstail.width / 2);
			creditstail.y = (credits.y + credits.height / 2) - 115;
			
			//Menu items moving up and down
			if (!scorefall)
			{
				random = Math.round(Math.random()*100);
				if ((score.y > FlxG.height - 100) || (score.y < 100))
				{
					random = Math.round(Math.random() * 500);
				}
				if (random == 1)
				{
					score.acceleration.y -= score.acceleration.y * 2;
				}
				if (score.y > FlxG.height - 100 && score.acceleration.y > 0)
				{
					score.acceleration.y -= score.acceleration.y * 2;
				}
				if (score.y < 200 && score.acceleration.y < 0)
				{
					score.acceleration.y -= score.acceleration.y * 2;
				}
			}
			
			if (!playerfall)
			{
				random = Math.round(Math.random()*100);
				if ((player.y > FlxG.height - 100) || (player.y < 100))
				{
					random = Math.round(Math.random() * 500);
				}
				if (random == 1)
				{
					player.acceleration.y -= player.acceleration.y * 2;
				}
				if (player.y > FlxG.height - 100 && player.acceleration.y > 0)
				{
					player.acceleration.y -= player.acceleration.y * 2;
				}
				if (player.y < 200 && player.acceleration.y < 0)
				{
					player.acceleration.y -= player.acceleration.y * 2;
				}
			}
			
			if (!optionsfall)
			{
				random = Math.round(Math.random()*100);
				if ((options.y > FlxG.height - 100) || (options.y < 100))
				{
					random = Math.round(Math.random() * 500);
				}
				if (random == 1)
				{
					options.acceleration.y -= options.acceleration.y * 2;
				}
				if (options.y > FlxG.height - 100 && options.acceleration.y > 0)
				{
					options.acceleration.y -= options.acceleration.y * 2;
				}
				if (options.y < 200 && options.acceleration.y < 0)
				{
					options.acceleration.y -= options.acceleration.y * 2;
				}
			}
			
			if (!creditsfall)
			{
				random = Math.round(Math.random()*100);
				if ((credits.y > FlxG.height - 100) || (credits.y < 100))
				{
					random = Math.round(Math.random() * 500);
				}
				if (random == 1)
				{
					credits.acceleration.y -= credits.acceleration.y * 2;
				}
				if (credits.y > FlxG.height - 100 && credits.acceleration.y > 0)
				{
					credits.acceleration.y -= credits.acceleration.y * 2;
				}
				if (credits.y < 200 && credits.acceleration.y < 0)
				{
					credits.acceleration.y -= credits.acceleration.y * 2;
				}
			}
			
			if (FlxG.mouse.justPressed() && !scorefall && !playerfall && !optionsfall && !creditsfall)
			{
				if (FlxG.mouse.y >= score.y && FlxG.mouse.y <= score.y + score.width && FlxG.mouse.x >= score.x && FlxG.mouse.x <= score.x + score.height)
				{
					objectFall(score);
				}
				if (FlxG.mouse.y >= player.y && FlxG.mouse.y <= player.y + player.width && FlxG.mouse.x >= player.x && FlxG.mouse.x <= player.x + player.height)
				{
					objectFall(player);
				}
				if (FlxG.mouse.y >= options.y && FlxG.mouse.y <= options.y + options.width && FlxG.mouse.x >= options.x && FlxG.mouse.x <= options.x + options.height)
				{
					objectFall(options);
				}
				if (FlxG.mouse.y >= credits.y && FlxG.mouse.y <= credits.y + credits.width && FlxG.mouse.x >= credits.x && FlxG.mouse.x <= credits.x + credits.height)
				{
					objectFall(credits);
				}
			}
			
			if (!scorefall) scoretext.y = score.y + 20;
			if (scorefall) scoretext.color = 0xE43A42;
			
			if (!playerfall) playertext.y = player.y + 20;
			if (playerfall) playertext.color = 0xE43A42;
			
			if (!optionsfall) optionstext.y = options.y + 20;
			if (optionsfall) optionstext.color = 0xE43A42;
			
			if (!creditsfall) creditstext.y = credits.y + 20;
			if (creditsfall) creditstext.color = 0xE43A42;
			
			super.update();
		}
		
		public function viewScore():void
		{
			FlxG.resetGame();
		}
		
		public function startGame():void
		{
			FlxG.switchState(new CaveGen());
		}
		
		public function viewOptions():void
		{
			FlxG.resetGame();
		}
		
		public function viewCredits():void
		{
			FlxG.resetGame();
		}
		
		public function objectFall(_object:FlxObject):void
		{
			switch (_object)
			{
				case score:
					scorefall = true;
					break;
				case player:
					playerfall = true;
					break;
				case options:
					optionsfall = true;
					break;
				case credits:
					creditsfall = true;
					break;
			}
			_object.maxVelocity.y = 800;
			_object.acceleration.y = 400;
			FlxG.flash(0xFFFFFFFF, 1);
		}
		
		public function shake(_object:FlxObject):FlxPoint
		{
			var _point:FlxPoint = new FlxPoint();
			_point.x = FlxG.random() * 0.1 * 32 - 0.1 * 32;
			_point.y = FlxG.random() * 0.1 * 32 - 0.1 * 32;
			return _point;
		}
	}

}