package
{
	import flash.display.Sprite;
	
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="640", height="480", backgroundColor="#ffffff")] //Set the size and color of the Flash file
	
	public class GameJamGame extends FlxGame
	{
		public function GameJamGame()
		{
			super(640,480,SplashScreen,1);
			//super(640,480,EndScreen,1);
			FlxG.debug = true;
		}
	}
}