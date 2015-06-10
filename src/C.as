package 
{
	/**
	 * ...
	 * @author James Keats
	 */
	public class C 
	{
		[Embed(source="../assets/sound/musicfiles/1.mp3")]//[Embed(source = "../assets/sound/musicfiles/1.wav", mimeType = "application/octet-stream")]
		public static const SONG_1:Class;
		
		/*
		[Embed(source = "../assets/sound/musicfiles/2.wav", mimeType = "application/octet-stream")]
		public static const SONG_2:Class;
		*/
		
		[Embed(source = "../assets/image/MOVING_PLATFORM_BASE.png")]
		public static const MOVING_PLATFORM_BASE_IMG:Class;
		
		public static const BASE_TILE_SIZE:int = 64;
	}

}