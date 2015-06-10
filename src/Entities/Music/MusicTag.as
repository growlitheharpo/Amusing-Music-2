package Entities.Music 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class MusicTag extends MovieClip 
	{
		private var timeToNext:Number;
		private var levelToWatchFor:Number;
		private var initialWaitTime:Number;
		
		private var myPlatforms:Vector.<int>;
		private var playing:Boolean;
		
		public var resetMyBar:Function;
		
		public function MusicTag(timeToNext:Number, levelToWatchFor:Number, myColumns:Vector.<int>, initialWaitTime:Number = 0)
		{
			super();
			
			this.timeToNext = timeToNext;
			this.levelToWatchFor = levelToWatchFor;
			
			if (this.myPlatforms) this.myPlatforms.length = 0;
			this.myPlatforms = clone(myColumns);
			
			this.initialWaitTime = initialWaitTime;
		}
		
		private function clone(source:Object):*
		{
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			
			return (myBA.readObject());
		}
		
		public function stopTimer():void
		{
			playing = false;
			myPlatforms.length = 0;
			myPlatforms = null;
		}
		
		public function startTimer(e:TimerEvent = null):void
		{
			if (e)
			{
				var myTimer:Timer = e.currentTarget as Timer;
				myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, startTimer);
				myTimer = null;
			}
			
			playing = true;
			
			if (initialWaitTime != 0)
				setupInitialWaitTimer();
			else
				this.addEventListener(Event.ENTER_FRAME, listenForSound);
		}
		
		private function setupInitialWaitTimer():void
		{
			var waitTimer:Timer = new Timer(initialWaitTime, 1);
			initialWaitTime = 0;
			
			waitTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startToListenForSound);
			waitTimer.start();
		}
		
		private function setupRegularTimer():void
		{
			var timer:Timer = new Timer(timeToNext, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, startToListenForSound);
			timer.start();
		}
		
		private function startToListenForSound(e:TimerEvent = null):void 
		{
			if (e)
			{
				var myTimer:Timer = e.currentTarget as Timer;
				myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, startTimer);
				myTimer = null;
			}
			
			if (playing) this.addEventListener(Event.ENTER_FRAME, listenForSound);
		}
		
		private function listenForSound(e:Event):void 
		{
			if (!playing)
			{
				this.removeEventListener(Event.ENTER_FRAME, listenForSound);
				return;
			}
			
			var byteArray:ByteArray = new ByteArray();
			SoundMixer.computeSpectrum(byteArray);
			var channelLength:int = 256;
			
			var thisSize:Number = 0;
			for (var i:int = 0; i < channelLength / 8; i++) 
			{
				thisSize += byteArray.readFloat();
			}
			
			thisSize /= channelLength / 4;
			thisSize = Math.abs(Math.round(thisSize * 100)) / 10;
			
			if (thisSize >= levelToWatchFor * 0.8)
			{
				this.removeEventListener(Event.ENTER_FRAME, listenForSound);
				
				if (myPlatforms)
				{
					for (var j:int = 0; j < myPlatforms.length; j++) 
					{
						if (playing) resetMyBar(myPlatforms[j]);
					}
				}
				
				if (playing)
					setupRegularTimer();
			}
		}
		
	}

}