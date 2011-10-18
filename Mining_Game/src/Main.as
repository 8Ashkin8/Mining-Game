package
{
	
	import flash.events.Event;
	import org.flixel.*;
	
	[SWF(width="400", height="400", backgroundColor="#FFFFFF")]
	
	[Frame(factoryClass="Preloader")]
	
	public class Main extends FlxGame
	{
		public function Main()
		{
			super(400, 400, MenuState, 1, 60, 30);
		}
		
		override public function onFocusLost(FlashEvent:Event = null):void
		{
			
		}
	}
	
}

