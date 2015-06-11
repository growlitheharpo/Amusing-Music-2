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
		
		public function GameWorld() 
		{
			super();
			
			map = new MapEntity();
			add(map);
			
			platformList = map.getPlatforms();
			for each(var platform:MovingPlatform in platformList)
				add(platform);
			
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
		
	}

}