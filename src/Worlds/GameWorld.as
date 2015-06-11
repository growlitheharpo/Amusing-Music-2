package worlds 
{
	import entities.MapEntity;
	import entities.MovingPlatform;
	import entities.player.Player;
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
			platformList = map.getPlatforms();
			
			add(map);
			
			player = new Player(128, 128);
			add(player);
			
			for each(var platform:MovingPlatform in platformList)
				add(platform);
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed(Key.P))
				platformList[0].moveUp();
		}
		
	}

}