/* *****************************************************************************
 * Amusing Music 2 is a portfolio piece demonstrating rhythm-based platforming.
 *   Copyright (C) 2015  James Keats (www.jameskeats.com)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 ****************************************************************************** */
package worlds 
{
	import entities.ui.BasicButton;
	import entities.ui.LargeBanner;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
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
		
		/**
		 * One class to handle the "Game Over: You Lose", "Game Over: You Win", and "Level Done" menus.
		 * @param	destinationLevel The level to load to when the player clicks continue/play again.
		 * Should probably be 1 if the player has won the game.
		 * @param	type A static const from this class for which menu type this is.
		 */
		public function GameOverMenu(destinationLevel:int, type:String = GAME_LOST) 
		{
			super();
			this.destinationLevel = destinationLevel;
			
			FP.screen.color = 0xFFFFFF;
			
			returnToMainMenu = new BasicButton("Main Menu", 28);
			
			switch (type)
			{
				case GAME_LOST:
						largeBanner = new LargeBanner("You Died!", 0, 50);
						returnToGame = new BasicButton("Try Again", 30);
						break;
				case LEVEL_WON: 
						largeBanner = new LargeBanner("Level " + int(destinationLevel - 1).toString() + "\nComplete!", 0, 10);
						returnToGame = new BasicButton("Continue", 30);
						break;
				case GAME_WON:
						largeBanner = new LargeBanner("You Win!", 0, 50);
						returnToGame = new BasicButton("Play Again", 30);
						var winSound:Sfx = new Sfx(C.WIN_SOUND, null, null); winSound.play(Main.VOLUME);
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