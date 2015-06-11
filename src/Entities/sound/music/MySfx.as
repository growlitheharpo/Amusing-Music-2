package entities.sound.music 
{
	import entities.sound.MusicTag;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class MySfx extends Sfx 
	{
		protected var myMusicTagList:Vector.<MusicTag>
		protected var hasFunctionBeenSet:Boolean = false;
		
		public var setPlatformFunction:Function;
		
		public function MySfx(source:*, complete:Function=null, type:String=null) 
		{
			super(source, complete, type);
			myMusicTagList = new Vector.<MusicTag>();
		}
		
		public function turnOnMusicTags():void
		{
			if (!hasFunctionBeenSet)
			{
				for (var i:int = 0; i < myMusicTagList.length; i++) 
				{
					myMusicTagList[i].resetMyBar = setPlatformFunction;
				}
				
				hasFunctionBeenSet = true;
			}
			
			for (i = 0; i < myMusicTagList.length; i++)
			{
				myMusicTagList[i].startTimer();
			}
		}
		
		public function turnOffMusicTags():void
		{
			for (var i:int = 0; i < myMusicTagList.length; i++) 
			{
				myMusicTagList[i].stopTimer();
				myMusicTagList[i] = null;
			}
		}
	}

}