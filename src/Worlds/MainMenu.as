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
	import entities.MapEntity;
	import entities.ui.BasicButton;
	import entities.ui.LargeBanner;
	import entities.ui.OptionsMenu;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class MainMenu extends World 
	{
		private var banner:LargeBanner;
		private var startButton:BasicButton;
		private var howtoButton:BasicButton;
		private var gobackButton:BasicButton;
		private var howtoText:OptionsMenu;
		
		public function MainMenu() 
		{
			super();
			FP.screen.color = 0xFFFFFF;
			
			//Draw a lot of stuff.
			banner = new LargeBanner("Amusing Music\n2");
			banner.x = FP.halfWidth - banner.halfWidth; banner.y = 10;
			
			//Start button is used twice, but we only have one instance of it.
			startButton = new BasicButton("Start Game", 30);
			startButton.x = FP.halfWidth - startButton.halfWidth;
			startButton.y = 220;
			
			howtoButton = new BasicButton("How to Play", 25);
			howtoButton.x = FP.halfWidth - howtoButton.halfWidth;
			howtoButton.y = startButton.y + startButton.height + 20;
			
			gobackButton = new BasicButton("Go Back", 30);
			gobackButton.x = C.HOW_TO_LEFTBUTTON_X;
			gobackButton.y = C.HOW_TO_LEFTBUTTON_Y;
			
			howtoText = new OptionsMenu("howto");
			
			initMenu();
		}
		
		/**
		 * Add the banner and "Main" menu buttons
		 */
		private function initMenu():void 
		{
			removeAll();
			
			startButton.x = FP.halfWidth - startButton.halfWidth; startButton.y = 220; //start button gets moved around
			
			add(banner);
			add(startButton);
			add(howtoButton);
		}
		
		/**
		 * Add the "How to Play" menu and buttons.
		 */
		private function initHowTo():void
		{
			removeAll();
			
			startButton.x = C.HOW_TO_RIGHTBUTTON_X;
			startButton.y = C.HOW_TO_RIGHTBUTTON_Y; //start button gets moved around
			
			add(howtoText);
			add(gobackButton);
			add(startButton);
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.mousePressed)
			{
				if (checkButtonPressed(startButton))
					FP.world = new GameWorld(1);
				else if (gobackButton.world && checkButtonPressed(gobackButton))
					initMenu();
				else if (howtoButton.world && checkButtonPressed(howtoButton))
					initHowTo();
			}
		}
		
		/**
		 * Checks if the mouse was over a certain area (but DOESN'T check if it was clicked)
		 * @param	button The button to check.
		 * @return True if the mouse was over that button, false otherwise.
		 */
		private function checkButtonPressed(button:Entity):Boolean
		{
			if (mouseX > button.x && mouseY > button.y && mouseX < button.x + button.width && mouseY < button.y + button.height)
				return true;
			else
				return false;
		}
		
	}

}