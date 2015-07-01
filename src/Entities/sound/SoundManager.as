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
	import entities.sound.music.MySfx;
	import entities.sound.music.Song1Sfx;
	import entities.sound.music.Song2Sfx;
	import entities.sound.music.Song3Sfx;
	import entities.sound.music.Song4Sfx;
	import entities.sound.music.Song5Sfx;
	import entities.sound.music.Song6Sfx;
	/**
	 * ...
	 * @author James Keats
	 */
	public class SoundManager 
	{
		private const SOUND_LIST:Vector.<Class> = new <Class>[Song1Sfx, Song2Sfx, Song3Sfx, Song4Sfx, Song5Sfx, Song6Sfx];
		
		private var currentSong:MySfx;
		private var platformIDsForThisSound:Vector.<Vector.<int>>;
		
		private var keepPlaying:Boolean;
		private var queuedSound:int;
		private var playingSound:int;
		
		public var setPlatformFunction:Function;
		
		public function SoundManager()
		{
		}
		
		/**
		 * Setup the manager
		 * @param	initialSound The first sound (an index) to play.
		 * @param	initialPlatformList The platforms to attach to that sound.
		 */
		public function init(initialSound:int, initialPlatformList:Vector.<Vector.<int>> = null):void
		{
			queuedSound = initialSound;
			keepPlaying = true;
			
			if (initialPlatformList)
			{
				platformIDsForThisSound = initialPlatformList;
			}
			else
			{
				platformIDsForThisSound = new Vector.<Vector.<int>>();
				var row1:Vector.<int> = new <int>[0];
				platformIDsForThisSound.push(row1);
			}
			
			playSound();
		}
		
		/**
		 * Start actually playing the sound.
		 */
		private function playSound():void
		{
			if (keepPlaying)
			{
				currentSong = null;
				if (!currentSong)
				{
					currentSong = new SOUND_LIST[queuedSound](platformIDsForThisSound, loopSound);
					playingSound = queuedSound;
					currentSong.setPlatformFunction = setPlatformFunction;
				}
				
				currentSong.turnOnMusicTags();
				currentSong.play(Main.VOLUME);
			}
		}
		
		/**
		 * Destroys the music tags and sets up to repeat.
		 */
		private function loopSound():void
		{
			currentSong.turnOffMusicTags();
			playSound();
		}
		
		/**
		 * Get the currently queued sound...
		 * @return what do you think?
		 */
		public function getQueuedSound():int
		{
			return queuedSound;
		}
		
		/**
		 * Change the sound that's going to play next.
		 * @param	newSound The sound (index) to play next.
		 * @param	platformIDs The platforms to attach to that sound's pieces.
		 */
		public function setQueuedSound(newSound:int, platformIDs:Vector.<Vector.<int>>):void
		{
			queuedSound = newSound;
			platformIDsForThisSound = platformIDs.concat();
		}
		
		/**
		 * Stop the sound right now and destroy the ability to continue 
		 * until setQueuedSound is called again by erasing the queued sound.
		 */
		public function stop():void
		{
			queuedSound = -1;
			keepPlaying = false;
			currentSong.stop();
			currentSong.turnOffMusicTags();
		}
		
		/**
		 * Stop playing with the possibility of continuing.
		 */
		public function pause():void
		{
			keepPlaying = false;
			currentSong.stop();
			currentSong.turnOffMusicTags();
		}
		
		/**
		 * Restart the sound that was already queued.
		 */
		public function restart():void
		{
			keepPlaying = true;
			playSound();
		}
	}

}