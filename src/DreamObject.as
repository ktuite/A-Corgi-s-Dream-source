package
{
	import org.flixel.*;
	
	public class DreamObject extends FlxSprite
	{
		public var sound:Class;
		public var type:int;
		
		public function DreamObject(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, EmbeddedSound:Class = null, Type:int = 0)
		{
			super(X,Y,SimpleGraphic);
			sound = EmbeddedSound;
			type = Type;
		}
	}
}