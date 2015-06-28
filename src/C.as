package 
{
	/**
	 * ...
	 * @author James Keats
	 */
	public class C 
	{
		/***********************
		 * SOUND DATA
		 * *********************/
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
		
		[Embed(source = "../assets/sound/musicfiles/Dubstep.mp3")]
		public static const WIN_SOUND:Class;
		
		
		
		/***********************
		 * IMAGE/SPRITE DATA
		 * *********************/
		[Embed(source = "../assets/image/BASIC_MENU_BUTTON.png")]
		public static const BASIC_MENU_BUTTON:Class;
		
		[Embed(source = "../assets/image/CONTROLS_MENU_BASE.png")]
		public static const CONTROLS_MENU_BASE:Class;
		
		[Embed(source = "../assets/image/CONTROLS_MENU_HOWTO_INSERT.png")]
		public static const CONTROLS_INSERT_HOWTOPLAY:Class;
		
		[Embed(source = "../assets/image/CONTROLS_MENU_VOLUME_INSERT.png")]
		public static const CONTROLS_INSERT_VOLUMECONTROL:Class;
		
		[Embed(source = "../assets/image/CONTROLS_MENU_VOLUME_BAR.png")]
		public static const CONTROLS_INSERT_VOLUMECONTROL_BAR:Class;
		
		[Embed(source = "../assets/image/MOVING_PLATFORM_BASE.png")]
		public static const MOVING_PLATFORM_BASE_IMG:Class;
		
		[Embed(source = "../assets/image/PLAYER.png")]
		public static const PLAYER_IMG:Class;
		
		[Embed(source = "../assets/image/ROTATING_STAR_SHEET.png")]
		public static const ROTATING_STAR_SHEET:Class;
		
		[Embed(source = "../assets/image/SCORE_COUNTER.png")]
		public static const BASE_SCORE_COUNTER_IMG:Class;
		
		[Embed(source = "../assets/image/WORLD_TILES_V1.png")]
		public static const BASE_WORLD_TILES:Class;
		
		
		
		/***********************
		 * FONT DATA
		 * *********************/
		[Embed(source = "../assets/fonts/BROADW.TTF", embedAsCFF = "false", fontFamily = 'Broadway')] //main menu font
		public static const BROADWAY_FONT:Class;
		
		[Embed(source = "../assets/fonts/comic.ttf", embedAsCFF = "false", fontFamily = 'ScoreCounterFont')] //it's comic sans #dealwithit
		public static const SCORE_COUNTER_FONT:Class;
		
		
		
		/***********************
		 * MISC. DATA
		 * *********************/
		public static const BASE_TILE_SIZE:int = 40;
		
		public static const GRAVITY:Number = 0.6;
		public static const PLAYER_JUMP_INC:Number = 7.25;
		public static const PLAYER_LEFTRIGHT_SPEED:Number = 2.7;
		
		public static const SKY_COLOR:uint = 0x8ABDDB;
		
		public static const HOW_TO_LEFTBUTTON_X:Number = 30;
		public static const HOW_TO_LEFTBUTTON_Y:Number = 275;
		public static const HOW_TO_RIGHTBUTTON_X:Number = 410;
		public static const HOW_TO_RIGHTBUTTON_Y:Number = 275;
		
		
		
		/***********************
		 * LEVEL DATA
		 * *********************/
		[Embed(source="../levels/Level1.oel", mimeType="application/octet-stream")]
		public static const LEVEL_ONE_DATA:Class;
		
		[Embed(source = "../levels/Level2.oel", mimeType = "application/octet-stream")]
		public static const LEVEL_TWO_DATA:Class;
		
		[Embed(source = "../levels/Level3.oel", mimeType = "application/octet-stream")]
		public static const LEVEL_THREE_DATA:Class;
		
		public static const LIST_OF_LEVELS:Vector.<Class> = new <Class>[LEVEL_ONE_DATA, LEVEL_TWO_DATA, LEVEL_THREE_DATA];
	}

}