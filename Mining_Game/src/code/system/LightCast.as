package code.system{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.flixel.FlxSprite;
	
	/**
	 * A demo of the ShadowCasting algorithm
	 * 
	 * ported from python code here:
	 * 
	 * http://roguebasin.roguelikedevelopment.org/index.php?title=PythonShadowcastingImplementation
	 * 
	 * Bear in mind the algorithm is as yet unoptimised and I will be tailoring it to a specific task
	 * when I do. This is just showing off the python code in AS3.
	 * 
	 * @author Aaron Steed, robotacid.com
	 */
	
	[SWF(width = "500", height = "500", frameRate="30", backgroundColor = "#000000")]
	public class LightCast extends Sprite {
		
		public var registry:Registry;
		public var grid:Array;
		public var SCALE:Number = 8;
		public var INV_SCALE:Number = 1.0 / 8;
		public var grid_width:int;
		public var grid_height:int;
		public var map_bitmap:Bitmap;
		public var report:Array;
		public var bitmapholder:BitmapData;
		
		public function LightCast(_registry:Registry):void
		{
			registry = _registry;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			grid_height = registry.collisionmap.heightInTiles;
			grid_width = registry.collisionmap.widthInTiles;
			// entry point
			//grid = createEmptyMap(0, grid_width, grid_height);
			grid = registry.collisionmap.getData(true);
			report = createEmptyMap(0, 1 + 15 * 2, 1 + 15 * 2);
			//report = registry.collisionmap.getData(true);
			map_bitmap = new Bitmap(new BitmapData(grid_width, grid_height, true, 0xFF000000));
			
			var r:int, c:int;
			for (c = 0; c < grid_width; c++)
			{
				for (r = 0; r < grid_height; r++)
				{
					if (grid[c + (r * grid_height)] == 1)
					{
						grid[c + (r * grid_height)] = 1;
						map_bitmap.bitmapData.setPixel32(c, r, 0xFFFF0000);
					}
					else
					{
						grid[c + (r * grid_height)] = 0;
					}
				}
			}
			light = createEmptyMap(0, grid_width, grid_height);
			addEventListener(Event.ENTER_FRAME, loop);
			bitmapholder = new BitmapData(grid_width * SCALE, grid_height * SCALE);
		}
		public function loop(e:Event = null):void
		{
			grid = registry.collisionmap.getData(true);
			var c:int, r:int;
			for (c = 0; c < grid_width; c++)
			{
				for (r = 0; r < grid_height; r++)
				{
					if (grid[c + (r * grid_height)] != 0)
					{
						grid[c + (r * grid_height)] = 1;
						map_bitmap.bitmapData.setPixel32(c, r, 0xFFFF0000);
					}
					else
					{
						grid[c + (r * grid_height)] = 0;
						map_bitmap.bitmapData.setPixel32(c, r, 0xFF000000);
					}
				}
			}
			graphics.clear();
			//drawGrid();
			do_fov((registry.player.getScreenXY(null, registry.camera).x * INV_SCALE) >> 0, (registry.player.getScreenXY(null, registry.camera).y * INV_SCALE) >> 0, 25);
			drawLight();
		}
		public function drawGrid():void{
			graphics.clear();
			var r:int, c:int;
			for (c = 0; c < grid_width; c++)
			{
				for (r = 0; r < grid_height; r++)
				{
					if(grid[c + (r * grid_height)] == 1) graphics.beginFill(0x00FFFFFF);
					graphics.drawRect(c * SCALE, r * SCALE, SCALE, SCALE);
					if(grid[c + (r * grid_height)] == 1) graphics.endFill();
				}
			}
		}
		public function drawLight():void{
			var r:int, c:int;
			for (c = 0; c < grid_width; c++)
			{
				for (r = 0; r < grid_height; r++)
				{
					// the FOV calculates what walls can be seen - useful for roguelikes in showing
					// what walls are visible to the player - but seeing as all my walls will be black
					// I don't need this, hence I'm deliberately ignoring lit walls
					if (light[r][c] == flag && grid[c + (r * grid_height)] != 1)
					{
						graphics.beginFill(0x000000, 0);
						graphics.drawRect(c * SCALE, r * SCALE, SCALE, SCALE);
						graphics.endFill();
					}
					if (light[r][c] != flag)
					{
						graphics.beginFill(0xFF000000);
						graphics.drawRect(c * SCALE, r * SCALE, SCALE, SCALE);
						graphics.endFill();
					}
				}
			}
			// the shadow cast ignores the player's square - so we light that one ourselves
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(((registry.player.getScreenXY(null, registry.camera).x * INV_SCALE) >> 0) * SCALE, ((registry.player.getScreenXY(null, registry.camera).y * INV_SCALE) >> 0) * SCALE, SCALE, SCALE);
			graphics.endFill();
		}
		
		public function createEmptyMap(base:*, width:int, height:int):Array {
			var r:int, c:int, a:Array = [];
			for(r = 0; r < height; r++) {
				a.push([]);
				for(c = 0; c < width; c++) {
					a[r].push(base);
				}
			}
			return a;
		}
		
		// PORTED PYTHON CODE STARTS HERE! =======================================================>
		
		// Multipliers for transforming coordinates to other octants:
		public var mult:Array = [
			[1,  0,  0, -1, -1,  0,  0,  1],
			[0,  1, -1,  0,  0, -1,  1,  0],
			[0,  1,  1,  0,  0, -1, -1,  0],
			[1,  0,  0,  1, -1,  0,  0, -1]
		];
		
		public var flag:int = 0;
		
        public var light:Array = [];
		
		public function blocked(x:int, y:int):Boolean{
			return x < 0 || y < 0 || x >= grid_width || y >= grid_height || map_bitmap.bitmapData.getPixel32(x, y) == 0xFFFF0000;
		}
		public function lit(x:int, y:int):Boolean{
			return light[y][x] == flag;
		}
		public function set_lit(x:int, y:int):void{
			if(x > -1 && y > -1 && x < grid_width && y < grid_height) light[y][x] = flag;
		}
		
		public function cast_light(cx:Number, cy:Number, row:Number, start:Number, end:Number, radius:Number, xx:Number, xy:Number, yx:Number, yy:Number, id:Number):void{
		
			// "Recursive lightcasting function"
			
			var new_start:Number;

			if(start < end) return;

			var radius_squared:Number = radius * radius;

			for(var j:int = row; j < radius + 1; j++){
				var dx:Number = -j - 1;
				var dy:Number = -j;
				var block:Boolean = false;
				while(dx <= 0){
					dx++;
					// Translate the dx, dy coordinates into map coordinates:

					var X:Number = cx + dx * xx + dy * xy;
					var Y:Number = cy + dx * yx + dy * yy;

					// l_slope and r_slope store the slopes of the left and right
					// extremities of the square we're considering:

					var l_slope:Number = (dx - 0.5) / (dy + 0.5);
					var r_slope:Number = (dx + 0.5) / (dy - 0.5);

					if(start < r_slope) continue;

					else if(end > l_slope) break;

					else{
					// Our light beam is touching this square; light it:
						if(dx*dx + dy*dy < radius_squared) set_lit(X, Y)
						if(block){
							// we're scanning a row of blocked squares:
							if(blocked(X, Y)){
								new_start = r_slope;
								continue;
							} else{
								block = false;
								start = new_start;
							}
						} else {
							if(blocked(X, Y) && j < radius){
								// This is a blocking square, start a child scan:
								block = true;
								cast_light(cx, cy, j+1, start, l_slope, radius, xx, xy, yx, yy, id+1)
								new_start = r_slope;
							}
						}
					}
				}
				// Row is scanned; do next row unless last square was blocked:
				if (block) break;
			}
		}
		
		public function do_fov(x:Number, y:Number, radius:Number):void{
			// "Calculate lit squares from the given location and radius"
			flag++;
			for(var i:int = 0; i < 8; i++){
				cast_light(x, y, 1, 1.0, 0.0, radius, mult[0][i], mult[1][i], mult[2][i], mult[3][i], 0);
			}
		}
	}
	
}