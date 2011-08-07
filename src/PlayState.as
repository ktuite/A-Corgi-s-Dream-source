// ActionScript file
package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source="assets/corgi.png")] private var corgiPicture:Class;
		[Embed(source="assets/star2.png")] private var particleImage:Class;
		
		[Embed(source="assets/weee.mp3")] private var weeeSound:Class;

		
		private var corgiSprite:FlxSprite;
		private var world:DreamWorld;
		
		private var displacement:FlxPoint;
		private var velocity:Number;
		private var velocityDelta:Number;
		private var moreDelta:Number;
		
		public var emitter:FlxEmitter;
		
		public var weeClip:FlxSound;
		
		public var collectedItems:Array;
		
		public var gameWon:Boolean;
		
		public var napTime:Number;
		
		public var scoreBoard:FlxText;
		
		override public function create():void
		{
			gameWon = false;
			napTime = 0;
			
			FlxG.bgColor = 0xFFEEEE88;
			//FlxG.bgColor = 0xFF000000;
			//FlxG.bgColor = 0xFFEEEEEE;
			
			velocity = 0;
			velocityDelta = 0.05;
			moreDelta = 100;
			
			world = new DreamWorld();
			add(world);
			
			corgiSprite = new FlxSprite(300, 200, corgiPicture);
			add(corgiSprite);
			
			displacement = world.displaceDelta;
			
			emitter = new FlxEmitter(320, 240, 30);
			emitter.makeParticles(particleImage);
			add(emitter);
			
			weeClip = FlxG.play(weeeSound, .5);
			weeClip.stop();
			
			collectedItems = new Array();
			for (var i:int = 0; i < world.goodItems.length; i++){
				collectedItems[i] = false;
			}
			
			scoreBoard = new FlxText(10, 10, 200, "Types of things dreamed of: 0/" + world.goodItems.length);
			scoreBoard.color = 0xFF000000;
			add(scoreBoard); 
		}
		
		public override function update():void{
			super.update();
				
			napTime += FlxG.elapsed;
			
			if (FlxG.keys.UP)
			{
				velocity += velocityDelta;
				weeClip.play();
			}
			else if (FlxG.keys.DOWN)
			{
				velocity -= velocityDelta;
			}
			
			if (FlxG.keys.RIGHT){
				corgiSprite.angularVelocity += 0.5;
			}
			else if (FlxG.keys.LEFT){
				corgiSprite.angularVelocity -= 0.5;
			}
			
			if (FlxG.keys.ENTER){
				FlxG.log(collectedItems);
			}
			
			if (corgiSprite.angularVelocity > moreDelta)
				corgiSprite.angularVelocity = moreDelta;
			else if (corgiSprite.angularVelocity < -1*moreDelta)
				corgiSprite.angularVelocity = -1*moreDelta;
			
			if (velocity > velocityDelta*moreDelta)
				velocity = velocityDelta*moreDelta;
			else if (velocity < -1*velocityDelta*moreDelta)
				velocity = -1*velocityDelta*moreDelta;
			
			displacement.x = velocity * Math.cos( (corgiSprite.angle+90) * Math.PI / 180 );
			displacement.y = velocity * Math.sin( (corgiSprite.angle+90) * Math.PI / 180 );
			
			world.moveStuff();
				
			FlxG.overlap(world, corgiSprite, dogCollision);
		}
		
		private function dogCollision(target:DreamObject, dog:FlxSprite):void
		{
			target.angularVelocity = 20;
			if (target.alive){
				emitter.at(target);
				emitter.start();
				FlxG.play(target.sound);
				collectedItems[target.type] = true;
				
				var items:int = 0;
				for each (var v:Boolean in collectedItems){
					if (v)
						items++;
				}
				
				scoreBoard.text = "Types of things dreamed of: " + items + "/" + world.goodItems.length;
				
				if (items == collectedItems.length){
					gameWon = true;
					FlxG.log("GAME WON!!! YOU COLLECTED ONE OF EACH TYPE AND YOUR DOGGY WOKE UP!");
					FlxG.fade(0xFF000000, 1, onFadeComplete);
				}
			}
			target.alive = false;
			
		}
		
		public function onFadeComplete():void
		{
			// end the game
			FlxG.switchState(new EndScreen(napTime));
		}
	}
}