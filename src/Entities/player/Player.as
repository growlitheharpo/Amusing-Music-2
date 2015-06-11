package entities.player 
{
	import entities.MovingPlatform;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class Player extends Entity 
	{
		private const SOLID_TYPES:Array = ["solid", "solidMP"];
		public static const SIZE:int = 25;
		
		private var ySpeed:Number = 0;
		private var xSpeed:Number;
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			var myImage:Image = new Image(C.PLAYER_IMG);
			
			graphic = myImage;
			setHitbox(myImage.width, myImage.height);
			name = "player";
			
			super(x, y, graphic, mask);
		}
		
		override public function update():void
		{
			super.update();
			
			movePlayer();
		}
		
		private function movePlayer():void 
		{
			xSpeed = 3 * (Main.FPS * FP.elapsed);
			
			if (Input.check(Key.RIGHT) || Input.check(Key.D))
				moveBy(xSpeed, 0, SOLID_TYPES);
				
			if (Input.check(Key.LEFT) || Input.check(Key.A))
				moveBy( -xSpeed, 0, SOLID_TYPES);
				
			runGravity();
		}
		
		private function runGravity():void 
		{
			if (collide("solid", x, y - 1)) //check if we hit our head
				ySpeed = 0;
				
			var hitGround:Boolean = Boolean(collideTypes(SOLID_TYPES, x, y + 1)); //check underneath
			
			if (hitGround)
			{	
				var hitObject:MovingPlatform = collide("solidMP", x, y + 1) as MovingPlatform;
				if (hitObject != null && !hitObject.goingDown)
				{
					if (!collide("solid", x, (hitObject.y - this.height))) //moving up won't hit anything
						this.y = hitObject.y - this.height;
					else
					{
						if ((this.x + this.halfWidth) < (hitObject.x + hitObject.halfWidth)) //further to the left
							this.x = hitObject.x - this.width - 1;
						else if ((this.x + this.halfWidth) > (hitObject.x + hitObject.halfWidth)) //further to the left
							this.x = hitObject.x + hitObject.width + 1;
						else
						{
							if (FP.random > 0.5)
								this.x = hitObject.x - this.width - 1;
							else
								this.x = hitObject.x + hitObject.width + 1;
						}
					}
				}
				
				ySpeed = 0;
				if (Input.pressed(Key.SPACE) || Input.pressed(Key.UP) || Input.pressed(Key.W))
					ySpeed = -10;
			}
			else
			{
				ySpeed += C.GRAVITY;
			}
			
			var realSpeed:Number = ySpeed * (Main.FPS * FP.elapsed);
			
			moveBy(0, ySpeed, SOLID_TYPES);
		}
		
	}

}