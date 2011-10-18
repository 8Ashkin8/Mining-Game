package code.system
{
	import code.objects.Player;
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import org.flixel.FlxTilemap;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGroup;
	import org.flixel.FlxCamera;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class Registry 
	{
		//Tilemaps
		public var tilemap:FlxTilemap
		public var collisionmap:FlxTilemap;
		public var bgmap:FlxTilemap;
		public var shadowmap:FlxTilemap;
		public var scenerymap:FlxTilemap;
		
		//Surface tile options
		public var surfacetop:int;
		public var surfacemiddle:int;
		public var surfacebottom:int;
		public var surfacescenery:int;
		public var surfaceprops:FlxGroup;
		
		//Bitmaps
		public var map:BitmapData;
		public var goldmap:BitmapData;
		public var lightmap:Shape;
		
		//Player
		public var player:Player;
		
		//Emitters
		public var jetpack:FlxEmitter;
		public var tileparticles1:FlxEmitter;
		public var tileparticles2:FlxEmitter;
		public var flameparticles:FlxEmitter;
		public var smokeparticles:FlxEmitter;
		public var chestgoldparticles:FlxEmitter;
		public var chestenergyparticles:FlxEmitter;
		public var chestbombparticles:FlxEmitter;
		public var chestammoparticles:FlxEmitter;
		public var chestcurseparticles:FlxEmitter;
		
		//Groups
		public var diggers:FlxGroup;
		public var objects:FlxGroup;
		public var lights:FlxGroup;
		public var mushrooms:FlxGroup;
		public var healthbar:FlxGroup;
		public var bullets:FlxGroup;
		public var bombs:FlxGroup;
		public var emitters:FlxGroup;
		public var explosions:FlxGroup;
		
		//Cameras
		public var camera:FlxCamera;
		public var hudcamera:FlxCamera;
		
		public function Registry() 
		{
			
		}
		
	}

}