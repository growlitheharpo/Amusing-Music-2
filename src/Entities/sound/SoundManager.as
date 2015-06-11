package entities.sound 
{
	import entities.sound.music.MySfx;
	import entities.sound.music.Song1Sfx;
	import entities.sound.music.Song2Sfx;
	/**
	 * ...
	 * @author James Keats
	 */
	public class SoundManager 
	{
		private const SOUND_LIST:Vector.<Class> = new <Class>[Song1Sfx, Song2Sfx];
		
		private var currentSong:MySfx;
		private var platformIDsForThisSound:Vector.<Vector.<int>>;
		
		private var keepPlaying:Boolean;
		private var queuedSound:int;
		private var playingSound:int;
		
		public var setPlatformFunction:Function;
		
		public function SoundManager(initialSound:int = 0)
		{
			this.queuedSound = initialSound;
		}
		
		public function init():void
		{
			keepPlaying = true;
			platformIDsForThisSound = new Vector.<Vector.<int>>();
			
			var row1:Vector.<int> = new <int>[0];
			platformIDsForThisSound.push(row1);
			
			playSound();
		}
		
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
				currentSong.play();
			}
		}
		
		private function loopSound():void
		{
			currentSong.turnOffMusicTags();
			playSound();
		}
		
		public function getQueuedSound():int
		{
			return queuedSound;
		}
		
		public function setQueuedSound(newSound:int, platformIDs:Vector.<Vector.<int>>):void
		{
			queuedSound = newSound;
			platformIDsForThisSound = platformIDs.concat();
		}
		
		public function stop():void
		{
			queuedSound = -1;
			keepPlaying = false;
			currentSong.stop();
			currentSong.turnOffMusicTags();
		}
	}

}