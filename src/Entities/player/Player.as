/* *****************************************************************************
 * Amusing Music 2 is a portfolio piece demonstrating rhythm-based platforming.
 *   Copyright (C) 2015  James Keats (www.jameskeats.com)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 ****************************************************************************** */
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
			
			//Movement is done directly by "player" rather than in World update.
			runGravity();
			movePlayer();
		}
		
		private function runGravity():void 
		{
			if (collide("solid", x, y - 1) || this.y < 0) //check if we hit our head
				ySpeed = 0;
				
			var hitGround:Boolean = Boolean(collideTypes(SOLID_TYPES, x, y + 1)); //check underneath
			
			if (hitGround)
			{	
				/* Check if we're on a moving platform */
				var hitObject:MovingPlatform = collide("solidMP", x, y + 1) as MovingPlatform;
				
				if (hitObject != null && !hitObject.goingDown) //we ARE on a platform D: !!!
				{
					if (!collide("solid", x, (hitObject.y - this.height))) //moving up won't hit anything
						this.y = hitObject.y - this.height;
					else
					{
						/* We are trying to move up on a platform, but there is something above us.
						 * Instead of crushing/killing the player, we push them off to the left or
						 * the right depending on which side they're already on.
						 * FIXME: This could still get us stuck in a wall with bad level design! */
						
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
					ySpeed = -C.PLAYER_JUMP_INC; //jump increase is positive, so we set our y speed to negative that on a jump.
			}
			else
			{
				ySpeed += C.GRAVITY;
			}
			
			var realSpeed:Number = ySpeed * (Main.FPS * FP.elapsed);
			
			moveBy(0, ySpeed, SOLID_TYPES);
		}
		
		private function movePlayer():void 
		{
			//In an ideal environment, this = C.PLAYER_LEFTRIGHT_SPEED
			//However, since the framerate isn't locked, this scales movement based on
			//the current fps.
			xSpeed = C.PLAYER_LEFTRIGHT_SPEED * (Main.FPS * FP.elapsed);
			
			if (Input.check(Key.RIGHT) || Input.check(Key.D))
				moveBy(xSpeed, 0, SOLID_TYPES);
				
			if (Input.check(Key.LEFT) || Input.check(Key.A))
				moveBy( -xSpeed, 0, SOLID_TYPES);
		}
		
	}

}