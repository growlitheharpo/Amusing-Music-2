package 
{
	/**
	 * ...
	 * @author James Keats
	 */
	public class C 
	{
		[Embed(source = "../lib/SoundAssets.swf", symbol = "SONG_1_WAV")]
		public static const SONG_1:Class;
		
		[Embed(source = "../lib/SoundAssets.swf", symbol = "SONG_2_WAV")]
		public static const SONG_2:Class;
		
		[Embed(source = "../lib/SoundAssets.swf", symbol = "SONG_3_WAV")]
		public static const SONG_3:Class;
		
		[Embed(source = "../lib/SoundAssets.swf", symbol = "SONG_4_WAV")]
		public static const SONG_4:Class;
		
		[Embed(source = "../lib/SoundAssets.swf", symbol = "SONG_5_WAV")]
		public static const SONG_5:Class;
		
		[Embed(source = "../lib/SoundAssets.swf", symbol = "SONG_6_WAV")]
		public static const SONG_6:Class;
		
		[Embed(source = "../assets/image/MOVING_PLATFORM_BASE.png")]
		public static const MOVING_PLATFORM_BASE_IMG:Class;
		
		[Embed(source = "../assets/image/PLAYER.png")]
		public static const PLAYER_IMG:Class;
		
		[Embed(source = "../assets/image/WORLD_TILES_V1.png")]
		public static const BASE_WORLD_TILES:Class;
		
		[Embed(source = "../assets/image/ROTATING_STAR_SHEET.png")]
		public static const ROTATING_STAR_SHEET:Class;
		
		[Embed(source = "../assets/image/BASIC_MENU_BUTTON.png")]
		public static const BASIC_MENU_BUTTON:Class;
		
		[Embed(source="../levels/TestLevel2.oel", mimeType="application/octet-stream")]
		public static const LEVEL_ONE_DATA:Class;
		
		[Embed(source = "../assets/image/HOW_TO_TEXT_IMG.png")]
		public static const HOW_TO_IMG:Class;
		
		[Embed(source = "../assets/fonts/BROADW.TTF", embedAsCFF = "false", fontFamily = 'Broadway')]
		public static const BROADWAY_FONT:Class;
		
		public static const BASE_TILE_SIZE:int = 40;
		
		public static const GRAVITY:Number = 0.75;
		
		public static const NUM_OF_LEVELS:int = 1;
	}

}