package
{
	import org.flixel.*;
	
	public class SplashScreen extends FlxState
	{
		[Embed(source="assets/corgidream2.jpg")] private var splashImage:Class;

		public function SplashScreen()
		{
			add(new FlxSprite(0,0,splashImage));
		}
		
		override public function update():void
		{
			// checking if the player pressed SPACE...
			if (FlxG.keys.pressed("SPACE"))
			{
				
				FlxG.fade(0xFFEEEE88, 1, onFadeComplete);
				// ... if true then fade the screen to black and execute on_fade_completed function once the fade is completed
			}
			super.update();
		}
		
		public function onFadeComplete():void
		{
			// playing the game itself
			FlxG.switchState(new PlayState());
		}
	}
}