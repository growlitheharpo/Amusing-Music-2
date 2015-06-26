package entities.collectables 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class Star extends Entity 
	{
		public var myID:int;
		public var mySound:int;
		
		public function Star(myID:int, mySound:int, x:Number=0, y:Number=0)//, graphic:Graphic=null, mask:Mask=null) 
		{
			this.myID = myID;
			this.mySound = mySound;
			
			var mySprite:Spritemap = new Spritemap(C.ROTATING_STAR_SHEET, 40, 42);
			var arrayOfFrames:Array = new Array(); for (var i:int = 0; i < 30; i++) { arrayOfFrames.push(i); }
			mySprite.add("rotate", arrayOfFrames, 30, true);
			
			mySprite.play("rotate");
			graphic = mySprite;
			
			setHitbox(mySprite.width, mySprite.height);
			this.type = "star";
			
			super(x, y, graphic, mask);
			
		}
		
	}

}