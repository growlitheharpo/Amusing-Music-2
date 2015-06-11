package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.GameWorld;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class Main extends Engine 
	{
		[SWF(width = "1024", height = "576")]
		
		public static const FPS:int = 60;
		
		public function Main() 
		{
			super(1024, 576, FPS, false);
			
			FP.world = new GameWorld();
			FP.console.enable();
		}
		
	}
	
}