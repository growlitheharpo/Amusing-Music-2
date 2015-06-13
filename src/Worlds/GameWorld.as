package worlds 
{
	import entities.MapEntity;
	import entities.MovingPlatform;
	import entities.player.Player;
	import entities.sound.SoundManager;
	import net.flashpunk.FP;
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
		private var platformList:Vector.<MovingPlatform>
		private var soundManager:SoundManager;
		
		private var currentLevel:int;
		
		public function GameWorld(currentLevel:int = 1 ) 
		{
			super();
			
			FP.screen.color = 0x8ABDDB;
			
			map = new MapEntity(currentLevel);
			
			platformList = map.getPlatforms();
			for each(var platform:MovingPlatform in platformList)
				add(platform);
				
			add(map);
				
			platformList.sort(MovingPlatform.sortFunction);
			
			player = new Player(map.playerStart.x, map.playerStart.y);
			add(player);
			
			soundManager = new SoundManager(0);
			soundManager.setPlatformFunction = movePlatform;
			soundManager.init(new <Vector.<int>>[ new <int>[1, 2, 3]]);
		}
		
		override public function update():void
		{
			super.update();
			
			updateCamera();
			checkPlayerHitLava();
		}
		
		private function checkPlayerHitLava():void 
		{
			var playerRow:int = (player.y / C.BASE_TILE_SIZE) + 1;
			var playerCol1:int = (player.x / C.BASE_TILE_SIZE);
			var playerCol2:int = ((player.x + player.width) / C.BASE_TILE_SIZE);
			
			var tile1:int = map.tilemap_1.getTile(playerCol1, playerRow);
			var tile2:int = map.tilemap_1.getTile(playerCol2, playerRow);
			
			if (tile1 == 2 || tile2 == 2)
				trace("DEAD!");
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