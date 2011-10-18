package code.system
{
	import code.objects.Treasure;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Digger extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/system/digger.png')] private var ImgDiggerS:Class;
		[Embed(source = '../../assets/graphics/system/diggerlarge.png')] private var ImgDiggerL:Class;
		[Embed(source = '../../assets/graphics/system/diggerextralarge.png')] private var ImgDiggerXL:Class;
		[Embed(source = '../../assets/graphics/system/golddigger.png')] private var ImgGoldDigger:Class;
		
		public var curiteration:int = 0;
		public var totiteration:int;
		public var random:int;
		public var treasure:Treasure;
		public var items:Boolean;
		public var stopped:Boolean = false;
		
		public var registry:Registry;
		
		public function Digger(X:int, Y:int, iterations:int, size:int = 1, placeitems:Boolean = true) 
		{
			super(X, Y);
			if (size == 0)
			{
				loadGraphic(ImgGoldDigger);
			}
			if (size == 1)
			{
				loadGraphic(ImgDiggerS);
			}
			if (size == 2)
			{
				loadGraphic(ImgDiggerL);
			}
			if (size == 3)
			{
				loadGraphic(ImgDiggerXL);
			}
			
			items = placeitems;
			totiteration = iterations;
			
			
		}
		
		override public function update():void
		{
			dig();
		}
		
		public function dig():void
		{
			
		}
		
		override public function destroy():void
		{
			registry.diggers.remove(this, true);
			super.destroy();
		}
	}

}