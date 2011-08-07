package
{
	import org.flixel.*;
	
	public class EndScreen extends FlxState
	{
		[Embed(source="assets/eddiethecorgi.jpg")] private var splashImage:Class;

		public function EndScreen(seconds:int=99999)
		{
			add(new FlxSprite(0,0,splashImage));
			add(new FlxText(40,20,400,"You napped for " +seconds+ " seconds and dreamed of ALL the things......\nBut now THE PUPPY HAS AWOKEN!")); 
			add(new FlxText(60,50,400,"Press SPACE to play again!")); 
			
			add(new FlxText(440,420,180,"This game was made by kathleen")); 
			add(new FlxText(460,440,180,"and inspired by Eddie the corgi")); 
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
			//FlxG.state = new PlayState();
			FlxG.switchState(new PlayState());
		}
	}
}