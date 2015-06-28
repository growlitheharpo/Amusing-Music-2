package entities 
{
	//import com.greensock.TweenLite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.tweens.misc.VarTween;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class MovingPlatform extends Entity 
	{
		
		private var waitTime:Number = 500;
		private var moveUpTime:Number;
		private var moveDownTime:Number = 0.3;
		
		private var topYPos:Number;
		private var bottomYPos:Number;
		
		private var myScale:int;
		public var myID:int;
		
		public var starIDToAttachTo:int;
		public var soundPieceToAttachTo:int;
		
		public var timerRunning:Boolean;
		public var goingDown:Boolean;
		
		public var myImage:Image;
		
		public function MovingPlatform(myID:int, myScale:int, starID:int, soundPiece:int, x:Number=0, y:Number=0)//, graphic:Graphic=null, mask:Mask=null) 
		{
			this.myID = myID;
			this.myScale = myScale;
			this.starIDToAttachTo = starID;
			this.soundPieceToAttachTo = soundPiece;
			
			myImage = new Image(C.MOVING_PLATFORM_BASE_IMG);
			myImage.scaleY = myScale;
			
			graphic = myImage;
			setHitbox(myImage.width, (myImage.height * myScale));
			type = "solidMP";
			
			super(x, y, graphic, mask);
		}
		
		override public function added():void
		{
			moveUpTime = FP.clamp((1 / myScale), 0.05, 0.35);
			topYPos = ((myImage.height * myScale) * -1) + C.BASE_TILE_SIZE + this.y;
			bottomYPos = 0 + this.y;
			
			goingDown = false;
			timerRunning = false;
			
			myImage.y = 0;
		}
		
		public function moveUp():void
		{
			goingDown = false;
			this.clearTweens();
			
			var tweenVar:VarTween = new VarTween();
			tweenVar.tween(this, "y", topYPos, moveUpTime);
			addTween(tweenVar, true);
			
			if (!timerRunning)
			{
				var wait:Timer = new Timer(waitTime, 1);
				wait.addEventListener(TimerEvent.TIMER_COMPLETE, fall);
				wait.start();
				timerRunning = true;
			}
		}
		
		private function fall(e:TimerEvent):void
		{
			var wait:Timer = e.currentTarget as Timer;
			wait.removeEventListener(TimerEvent.TIMER_COMPLETE, fall); wait = null;
			timerRunning = false;
			
			goingDown = true;
			
			var moveTween:VarTween = new VarTween();// goingDownSetter);
			moveTween.tween(this, "y", bottomYPos, moveDownTime);
			this.addTween(moveTween, true);
		}
		
		private function goingDownSetter():void
		{
			goingDown = false;
		}
		
		/* Returns -1 if the item should come before, 0 if the same, 1 if after */
		static public function sortFunction(platformA:MovingPlatform, platformB:MovingPlatform):Number
		{
			if (platformA.myID < platformB.myID)
				return -1;
			else if (platformA.myID == platformB.myID)
				return 0;
			else
				return 1;
		}
	}

}