// ActionScript file
package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source="assets/corgi.png")] private var corgiPicture:Class;
		
		private var corgiSprite:FlxSprite;
		private var world:DreamWorld;
		
		private var displacement:FlxPoint;
		private var velocity:Number;
		private var velocityDelta:Number;
		private var moreDelta:Number;
		
		override public function create():void
		{
			add(new FlxText(0,0,100,"Corgi dream flyer?!")); //adds a 100px wide text field at position 0,0 (top left)
			FlxG.bgColor = 0xFFEEEE88;
			
			displacement = new FlxPoint(0,0);
			velocity = 0;
			velocityDelta = 0.05;
			moreDelta = 100;
			
			world = new DreamWorld();
			add(world);
			
			corgiSprite = new FlxSprite(300, 200, corgiPicture);
			add(corgiSprite);

		}
		
		public override function update():void{
			super.update();
				
			if (FlxG.keys.UP)
			{
				velocity += velocityDelta;
			}
			else if (FlxG.keys.DOWN)
			{
				velocity -= velocityDelta;
			}
			
			if (FlxG.keys.RIGHT){
				//corgiSprite.angle += 0.5;
				corgiSprite.angularVelocity += 0.5;
			}
			else if (FlxG.keys.LEFT){
				corgiSprite.angularVelocity -= 0.5;
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
			world.displaceDelta = displacement;
			
			world.moveStuff();
				
		}
	}
}