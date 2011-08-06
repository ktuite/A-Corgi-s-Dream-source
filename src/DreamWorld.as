package
{
	import org.flixel.*;
	import flash.utils.Dictionary;
	
	public class DreamWorld extends FlxGroup
	{
		public var displaceDelta:FlxPoint;
		public var displaceGlobal:FlxPoint;
		public var cellsVisited:Dictionary;
		
		public function DreamWorld()
		{
			displaceDelta = new FlxPoint(0,0);
			displaceGlobal = new FlxPoint(0,0);
			
			cellsVisited = new Dictionary();
			
			add(new FlxText(30,200,100,"words")); 
			add(new FlxText(320,20,100,"hello"));
			add(new FlxText(120,100,100,"cat")); 
			add(new FlxText(99,400,100,"squirrel")); 
		}
		
		public function moveStuff():void 
		{
			displaceGlobal.x += displaceDelta.x;
			displaceGlobal.y += displaceDelta.y;
			
			for each (var member:FlxSprite in members)
			{
				member.x += displaceDelta.x;
				member.y += displaceDelta.y;
			}
		}
	}
}