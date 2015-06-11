package entities.sound.music 
{
	import entities.sound.MusicTag;
	/**
	 * ...
	 * @author James Keats
	 */
	public class Song2Sfx extends MySfx 
	{
		
		public function Song2Sfx(myPlatformIDs:Vector.<Vector.<int>>, complete:Function=null, type:String=null) 
		{
			super(C.SONG_2, complete, type);
			
			var platform1:MusicTag = new MusicTag(800, 1.2, myPlatformIDs[0]);
			var platform2:MusicTag = new MusicTag(800, 1.0, myPlatformIDs[1], 400);
			
			this.myMusicTagList.push(platform1, platform2);
		}
		
	}

}