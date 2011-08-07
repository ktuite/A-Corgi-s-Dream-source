package
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import org.flixel.*;
	
	public class DreamWorld extends FlxGroup
	{
		[Embed(source="assets/bone.png")] private var bonePicture:Class;
		[Embed(source="assets/porkChop.png")] private var porkChop:Class;
		[Embed(source="assets/foodDish.png")] private var foodDish:Class;
		
		[Embed(source="assets/kibbles.mp3")] private var kibbleSound:Class;
		[Embed(source="assets/wuff.mp3")] private var wuffSound:Class;
		[Embed(source="assets/porkchop.mp3")] private var porkchopSound:Class;
		
		
		public var w:int = 640;
		public var h:int = 480;
		
		public var displaceDelta:FlxPoint;
		public var displaceGlobal:FlxPoint;
		public var cellsVisited:Dictionary;
		public var arraySize:int = 100;
		
		public var goodItems:Array;
		public var goodSounds:Array; 
		
		private var someText:FlxText;
		
		public function DreamWorld()
		{
			displaceDelta = new FlxPoint(0,0);
			displaceGlobal = new FlxPoint(0,0);
			
			//someText = new FlxText(500, 400, 200, "hi");
			//add(someText);
			
			cellsVisited = new Dictionary();
			cellsVisited[new Point(0,0).toString()] = 0;
			
			/*
			add(new FlxText(30,200,100,"words")); 
			add(new FlxText(320,20,100,"hello"));
			add(new FlxText(120,100,100,"cat")); 
			add(new FlxText(99,400,100,"squirrel")); 
			*/
			
			goodItems = new Array();
			goodItems.push(bonePicture);
			goodItems.push(porkChop);
			goodItems.push(foodDish);
			
			
			goodSounds = new Array();
			goodSounds.push(wuffSound);
			goodSounds.push(porkchopSound);
			goodSounds.push(kibbleSound);
		}
		
		public function moveStuff():void 
		{
			displaceGlobal.x += displaceDelta.x;
			displaceGlobal.y += displaceDelta.y;
			
			var thisCell:Point = new Point(int(displaceGlobal.x / w), int(displaceGlobal.y / h));
			checkForNewCells(thisCell);
			
			for each (var member:FlxSprite in members)
			{
				member.x += displaceDelta.x;
				member.y += displaceDelta.y;
			}
		}
		
		public function checkForNewCells(thisCell:Point):void{
			for (var i:int = -1; i <=1; i++){
				for (var j:int = -1; j <= 1; j++){
					var nextCell:Point = new Point( thisCell.x + i, thisCell.y + j );
					if (cellsVisited[nextCell.toString()] == undefined){
						cellsVisited[nextCell.toString()] = nextCell.toString();
						var xPos:int = -i * w + Math.random() * w;
						var yPos:int = -j * h + Math.random() * h;
						var itemId:int = int(goodItems.length * Math.random());
						add(new DreamObject(xPos,yPos, goodItems[itemId], goodSounds[itemId], itemId));
						FlxG.log("NEW cell visited:" + nextCell);
					}
				}
			} 
		}
	}
}