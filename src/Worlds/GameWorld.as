package worlds 
{
	import entities.MapEntity;
	import entities.MovingPlatform;
	import entities.player.Player;
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
		
		private var currentLevel:int;
		
		public function GameWorld(currentLevel:int = 1 ) 
		{
			super();
			
			map = new MapEntity(currentLevel);
			add(map);
			
			platformList = map.getPlatforms();
			for each(var platform:MovingPlatform in platformList)
				add(platform);
				
			platformList.sort(MovingPlatform.sortFunction);
			
			player = new Player(map.playerStart.x, map.playerStart.y);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed(Key.P))
			{
				trace(platformList[0]);
				platformList[0].moveUp();
			}
			if (Input.pressed(Key.K))
			{
				remove(platformList[0]);
			}
			
			updateCamera();
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
			var high:int = platformList.size() - 1;
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