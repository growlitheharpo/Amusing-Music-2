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
		
		public function pause():void
		{
			keepPlaying = false;
			currentSong.stop();
			currentSong.turnOffMusicTags();
		}
		
		public function restart():void
		{
			keepPlaying = true;
			playSound();
		}
	}

}