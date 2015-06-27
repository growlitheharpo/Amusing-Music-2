package worlds 
{
	import entities.MapEntity;
	import entities.ui.BasicButton;
	import entities.ui.LargeBanner;
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
		private var howtoText:Entity;
		
		public function MainMenu() 
		{
			super();
			FP.screen.color = 0xFFFFFF;
			
			banner = new LargeBanner("Amusing Music\n2.0");
			banner.x = FP.halfWidth - banner.halfWidth; banner.y = 10;
			
			startButton = new BasicButton("Start Game", 30);
			startButton.x = FP.halfWidth - startButton.halfWidth;
			startButton.y = 220;
			
			howtoButton = new BasicButton("How to Play", 25);
			howtoButton.x = FP.halfWidth - howtoButton.halfWidth;
			howtoButton.y = startButton.y + startButton.height + 20;
			
			gobackButton = new BasicButton("Go Back", 30);
			gobackButton.x = FP.halfWidth - gobackButton.width - 40;
			gobackButton.y = FP.height - gobackButton.height - 20;
			
			howtoText = new Entity(10, 10, new Image(C.HOW_TO_IMG));
			
			initMenu();
		}
		
		private function initMenu():void 
		{
			removeAll();
			
			startButton.x = FP.halfWidth - startButton.halfWidth; startButton.y = 220; //start button gets moved around
			
			add(banner);
			add(startButton);
			add(howtoButton);
		}
		
		private function initHowTo():void
		{
			removeAll();
			
			startButton.x = FP.halfWidth + 40; startButton.y = FP.height - startButton.height - 20; //start button gets moved around
			
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
		
		private function checkButtonPressed(button:Entity):Boolean
		{
			if (mouseX > button.x && mouseY > button.y && mouseX < button.x + button.width && mouseY < button.y + button.height)
				return true;
			else
				return false;
		}
		
	}

}