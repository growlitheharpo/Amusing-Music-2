package worlds 
{
	import entities.ui.BasicButton;
	import entities.ui.LargeBanner;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class GameOverMenu extends World 
	{
		public static const GAME_LOST:String = "lose";
		public static const LEVEL_WON:String = "levelDone";
		public static const GAME_WON:String = "gameDone";
		
		private var destinationLevel:int;
		private var largeBanner:LargeBanner;
		private var returnToGame:BasicButton;
		private var returnToMainMenu:BasicButton;
		
		public function GameOverMenu(destinationLevel:int, type:String = GAME_LOST) 
		{
			super();
			this.destinationLevel = destinationLevel;
			
			FP.screen.color = 0xFFFFFF;
			
			returnToMainMenu = new BasicButton("Main Menu", 30);
			
			switch (type)
			{
				case GAME_LOST:
						largeBanner = new LargeBanner("You Died!");
						returnToGame = new BasicButton("Try Again", 30);
						break;
				case LEVEL_WON: 
						largeBanner = new LargeBanner("Level " + int(destinationLevelTo - 1).toString + " Complete!");
						returnToGame = new BasicButton("Next Level", 30);
						break;
				case GAME_WON;
						largeBanner = new LargeBanner("You Win!");
						returnToGame = new BasicButton("Play Again", 30);
						break;
			}
			
			initMenu();
		}
		
		private function initMenu():void 
		{
			removeAll();
			
			add(largeBanner);
			add(returnToGame);
			add(returnToMainMenu);
			
			largeBanner.x = FP.halfWidth - largeBanner.halfWidth;
			largeBanner.y = 50;
			
			returnToGame.x = FP.halfWidth - returnToGame.halfWidth;
			returnToGame.y = 220;
			returnToMainMenu.x = FP.halfWidth - returnToMainMenu.halfWidth;
			returnToMainMenu.y = returnToGame.y + returnToGame.height + 20;
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.mousePressed)
			{
				if (mouseX > returnToGame.x && mouseX < returnToGame.x + returnToGame.width && mouseY > returnToGame.y && mouseY < returnToGame.y + returnToGame.height)
					FP.world = new GameWorld(destinationLevel);
				else if (mouseX > returnToMainMenu.x && mouseX < returnToMainMenu.x + returnToMainMenu.width && mouseY > returnToMainMenu.y && mouseY < returnToMainMenu.y + returnToMainMenu.height)
					FP.world = new MainMenu();
			}
		}
		
	}

}