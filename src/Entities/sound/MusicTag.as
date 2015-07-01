/* *****************************************************************************
 * Amusing Music 2 is a portfolio piece demonstrating rhythm-based platforming.
 *   Copyright (C) 2015  James Keats (www.jameskeats.com)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 ****************************************************************************** */
package entities.sound 
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
	 * Yeah, good luck. Prof. Manley and I spent a good hour
	 * working out this system and it's still a little inexplicable.
	 * I did write a blog post about a previous version, if that helps:
		 * http://www.jameskeats.com/blogs/post/Sound-Toy-Dev-Blog/
	 */
	public class MusicTag extends MovieClip 
	{
		private var timeToNext:Number;
		private var levelToWatchFor:Number;
		private var initialWaitTime:Number;
		
		private var myPlatforms:Vector.<int>;
		private var playing:Boolean;
		
		public var resetMyBar:Function;
		
		/**
		 * Set up the MusicTag for a sound piece
		 * @param	timeToNext Time between "listens" for a sound level.
		 * @param	levelToWatchFor The sound level to listen for.
		 * @param	myColumns Vector of MovingPlatform IDs that are moved when we hear the right level.
		 * @param	initialWaitTime If we don't start on beat 1, time to wait for the beat we start on (default 0).
		 */
		public function MusicTag(timeToNext:Number, levelToWatchFor:Number, myColumns:Vector.<int>, initialWaitTime:Number = 0)
		{
			super();
			
			this.timeToNext = timeToNext;
			this.levelToWatchFor = levelToWatchFor * Main.VOLUME;
			
			if (this.myPlatforms) this.myPlatforms.length = 0;
			this.myPlatforms = clone(myColumns);
			
			this.initialWaitTime = initialWaitTime;
		}
		
		/**
		 * Create a copy of a vector instead of a pointer to it.
		 * @param	source The vector to copy.
		 * @return A copy instead of a pointer to that vector.
		 */
		private function clone(source:Object):*
		{
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			
			return (myBA.readObject());
		}
		
		/**
		 * Stops the MusicTag from continuing.
		 */
		public function stopTimer():void
		{
			playing = false;
			myPlatforms.length = 0;
			myPlatforms = null;
		}
		
		/**
		 * Force start the MusicTag.
		 * @param	e
		 */
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
		
		/**
		 * An "initial" wait so that we don't start on beat 1.
		 */
		private function setupInitialWaitTimer():void
		{
			var waitTimer:Timer = new Timer(initialWaitTime, 1);
			initialWaitTime = 0;
			
			waitTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startToListenForSound);
			waitTimer.start();
		}
		
		/**
		 * Sets up the repeated timer between listens.
		 */
		private function setupRegularTimer():void
		{
			var timer:Timer = new Timer(timeToNext, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, startToListenForSound);
			timer.start();
		}
		
		/**
		 * Cleanup the timer and add the EventListener to read the SoundMixer spectrum every frame.
		 * @param	e
		 */
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
		
		/**
		 * Essentially an "update" function that isn't called every frame.
		 * "Listens" to the SoundMixer spectrum while running to see if we hit
		 * the sound level we were told to listen for. If yes, move the attached platforms
		 * and restart the normal timer.
		 * @param	e
		 */
		private function listenForSound(e:Event):void 
		{
			if (!playing) //if we're told to stop, remove the event listener and stop right here.
			{
				this.removeEventListener(Event.ENTER_FRAME, listenForSound);
				return;
			}
			
			/* Somehow, by summing the first 32 values in the computeSpectrum array, and then
			 * dividing by 64, and then taking the absolute value of the first three digits * 10,
			 * you get a value that tends to be around 1 when a loud sound/beat has occurred.
			 * ...yep. 
			 * FIXME: Proof there's no god in this world. */
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
			
			//If we hit the size we were looking for, move the platforms.
			if (thisSize >= levelToWatchFor)
			{
				this.removeEventListener(Event.ENTER_FRAME, listenForSound);
				
				if (myPlatforms)
				{
					for (var j:int = 0; j < myPlatforms.length; j++) 
					{
						if (playing) resetMyBar(myPlatforms[j]);
					}
				}
				
				if (playing) //just in case
					setupRegularTimer();
			}
		}
		
	}

}