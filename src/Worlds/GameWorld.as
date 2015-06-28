package worlds 
{
	import entities.collectables.Star;
	import entities.MapEntity;
	import entities.MovingPlatform;
	import entities.player.Player;
	import entities.sound.SoundManager;
	import entities.ui.BasicButton;
	import entities.ui.OptionsMenu;
	import entities.ui.ScoreCounter;
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
	public class GameWorld extends World 
	{
		private var map:MapEntity;
		private var player:Player;
		private var platformList:Vector.<MovingPlatform>;
		private var starList:Vector.<Star>;
		private var soundManager:SoundManager;
		private var starCounter:ScoreCounter;
		
		private var numStarsCollected:int;
		private var paused:Boolean;
		
		private var currentLevel:int;
		
		private var optionsMenu:OptionsMenu;
		private var resumeButton:BasicButton;
		private var mainmenuButton:BasicButton;
		
		public function GameWorld(currentLevel:int = 1 ) 
		{
			this.currentLevel = currentLevel;
			super();
			
			FP.screen.color = C.SKY_COLOR;
			
			map = new MapEntity(currentLevel);
			
			platformList = map.getPlatforms();
			for each(var platform:MovingPlatform in platformList)
				add(platform);
			
				
			starList = map.getStars();
			for each (var star:Star in starList)
				add(star);
			
			add(map);
				
			platformList.sort(MovingPlatform.sortFunction);
			
			player = new Player(map.playerStart.x, map.playerStart.y);
			add(player);
			
			soundManager = new SoundManager();
			soundManager.setPlatformFunction = movePlatform;
			
			paused = false;
			numStarsCollected = 0;
			
			starCounter = new ScoreCounter(numStarsCollected, starList.length, 410, 10);
			add(starCounter);
			
			optionsMenu = new OptionsMenu("volume");
			resumeButton = new BasicButton("Resume", 30, C.HOW_TO_RIGHTBUTTON_X, C.HOW_TO_RIGHTBUTTON_Y);
			mainmenuButton = new BasicButton("Quit", 30, C.HOW_TO_LEFTBUTTON_X, C.HOW_TO_LEFTBUTTON_Y);
		}
		
		override public function begin():void
		{
			super.begin();
			
			var myList:Vector.<Vector.<int>> = buildStarsForPlatform( -1);
			soundManager.init(0, myList);
		}
		
		override public function update():void
		{
			if (!paused)
			{
				super.update();
				
				checkCollectStar();
				checkPlayerHitLava();
				
				updateCamera();
				checkWonLevel();
				checkHitPause();
			}
			else
			{
				optionsMenu.update();
				
				if (Input.mousePressed)
				{
					if (checkButtonPressed(resumeButton))
					{
						removePauseMenu();
						paused = false;
					}
					else if (checkButtonPressed(mainmenuButton))
					{
						this.removeAll();
						
						FP.world = new MainMenu();
					}
				}
			}
		}
		
		private function checkButtonPressed(button:BasicButton):Boolean 
		{
			if (Input.mouseX > button.x && Input.mouseY > button.y && Input.mouseX < button.right && Input.mouseY < button.bottom)
				return true;
			else
				return false;
		}
		
		private function checkHitPause():void 
		{
			if (Input.pressed(Key.ESCAPE) || Input.pressed(Key.P))
			{
				drawPauseMenu();
				paused = true;
			}
		}
		
		private function drawPauseMenu():void 
		{
			add(optionsMenu);
			add(resumeButton);
			add(mainmenuButton);
			
			soundManager.pause();
		}
		
		private function removePauseMenu():void
		{
			remove(optionsMenu);
			remove(resumeButton);
			remove(mainmenuButton);
			
			soundManager.restart();
		}
		
		private function checkWonLevel():void 
		{
			if (numStarsCollected == starList.length)
			{
				removeAll();
				soundManager.stop();
				
				if (currentLevel == C.LIST_OF_LEVELS.length)
					FP.world = new GameOverMenu(1, GameOverMenu.GAME_WON);
				else
					FP.world = new GameOverMenu(++currentLevel, GameOverMenu.LEVEL_WON);
			}
		}
		
		private function checkCollectStar():void 
		{
			var starHit:Star = player.collide("star", player.x, player.y) as Star;
			
			if (!starHit)
				return;
				
			var MPlist:Vector.<Vector.<int>> = buildStarsForPlatform(starHit.myID);
			soundManager.setQueuedSound(starHit.mySound, MPlist);
			
			remove(starHit);
			numStarsCollected++;
			starCounter.updateCount(numStarsCollected);
		}
		
		private function buildStarsForPlatform(starID:int):Vector.<Vector.<int>> 
		{
			var listOfMPs:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
			var soundPiece1List:Vector.<int> = new Vector.<int>();
			var soundPiece2List:Vector.<int> = new Vector.<int>();
			var soundPiece3List:Vector.<int> = new Vector.<int>();
			var soundPiece4List:Vector.<int> = new Vector.<int>();
			
			for each (var platform:MovingPlatform in platformList)
			{
				if (platform.starIDToAttachTo <= starID)
				{
					switch (platform.soundPieceToAttachTo)
					{
						case 0: soundPiece1List.push(platform.myID); break;
						case 1: soundPiece2List.push(platform.myID); break;
						case 2: soundPiece3List.push(platform.myID); break;
						case 3: soundPiece4List.push(platform.myID); break;
					}
				}
			}
			
			listOfMPs.push(soundPiece1List, soundPiece2List, soundPiece3List, soundPiece4List);
			
			return listOfMPs;
		}
		
		private function checkPlayerHitLava():void 
		{
			var playerRow:int = (player.y / C.BASE_TILE_SIZE) + 1;
			var playerCol1:int = (player.x / C.BASE_TILE_SIZE);
			var playerCol2:int = ((player.x + player.width) / C.BASE_TILE_SIZE);
			
			var tile1:int = map.tilemap_1.getTile(playerCol1, playerRow);
			var tile2:int = map.tilemap_1.getTile(playerCol2, playerRow);
			
			if (tile1 == 2 || tile2 == 2)
			{
				this.removeAll();
				soundManager.stop();
				
				FP.world = new GameOverMenu(this.currentLevel, GameOverMenu.GAME_LOST);
			}
		}
		
		private function updateCamera():void 
		{
			var min:int = C.BASE_TILE_SIZE; //keep ONE tile off screen at all times
			var max:int = map.width - C.BASE_TILE_SIZE; //ditto
			
			var xCoord:Number = (player.x + (player.width / 2)) - FP.halfWidth; //center on the player
			xCoord = FP.clamp(xCoord, min, max - FP.width); //clamp to keep from going off the edge
			camera.x = xCoord;
		}
		
		private function movePlatform(platformID:int):void
		{
			var high:int = platformList.length - 1;
			var low:int = 0;
			var mid:int;
			
			do {
				if (low > high)
				{
					mid = -1;
					break;
				}
				
				mid = (low + high) / 2;
				
				if (platformID > platformList[mid].myID)
					low = mid + 1;
				else if (platformID < platformList[mid].myID)
					high = mid - 1;
					
			} while (platformList[mid].myID != platformID);
			
			if (mid != -1)
				platformList[mid].moveUp();
		}
	}

}