/* *****************************************************************************
 * Amusing Music 2 is a portfolio piece demonstrating rhythm-based platforming.
 *   Copyright (C) 2015  James Keats (www.jameskeats.com)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 ****************************************************************************** */
package entities.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class ScoreCounter extends Entity 
	{
		private var totalStars:int;
		private var scoreText:Text;
		
		public function ScoreCounter(starsCollected:int, totalStars:int, x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			this.totalStars = totalStars;
			
			var bgImg:Image = new Image(C.BASE_SCORE_COUNTER_IMG);
			scoreText = new Text((starsCollected.toString() + " stars collected out of " + totalStars.toString()), 0, 0, { font:"ScoreCounterFont", color:0x0066CC, size:15 } );
			scoreText.x = (bgImg.width / 2) - (scoreText.width / 2);
			
			graphic = new Graphiclist(bgImg, scoreText);
			graphic.scrollX = 0;
			graphic.scrollY = 0; //ui element; fix position on the screen
			
			super(x, y, graphic, mask);
		}
		
		/**
		 * Change the amount of stars collected displayed by the counter.
		 */
		public function updateCount(newAmount:int):void
		{
			scoreText.text = (newAmount.toString() + " stars collected out of " + totalStars.toString());
		}
	}

}