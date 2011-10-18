package code.objects 
{
	import code.system.Registry;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Ashkin
	 */
	public class OrbitDrill extends FlxSprite
	{
		[Embed(source = '../../assets/graphics/objects/orbitdrill.png')] public var ImgDrill:Class;
		
		public var registry:Registry;
		
		public function OrbitDrill(X:int, Y:int, _registry:Registry) 
		{
			registry = _registry;
			
			super(X, Y);
			
			loadGraphic(ImgDrill, true, false, 24, 24);
			
		}
		
	}

}