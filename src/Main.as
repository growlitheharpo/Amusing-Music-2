/* *****************************************************************************
 * Amusing Music 2 is a portfolio piece demonstrating rhythm-based platforming.
 *   Copyright (C) 2015  James Keats (www.jameskeats.com)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 ****************************************************************************** */
package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.MainMenu;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class Main extends Engine 
	{
		[SWF(width = "640", height = "360")]
		
		public static const FPS:int = 60;
		
		public static var VOLUME:Number = 1;
		
		public function Main() 
		{
			super(640, 360, FPS, false);
			
			FP.world = new MainMenu();
		//	FP.console.enable(); //enables memory debugging and more
		}
		
	}
	
}