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
	public class BasicButton extends Entity 
	{
		
		public function BasicButton(buttonLabel:String, fontSize:int = 30, x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			var myImage:Image = new Image(C.BASIC_MENU_BUTTON);
			var nText:Text = new Text(buttonLabel, 0, 0, { font:"Broadway", color:0xFFFFFF, size:fontSize, align:"center" } );
			nText.x = (myImage.width / 2) - (nText.width / 2);
			nText.y = (myImage.height / 2) - (nText.height / 2);
			
			graphic = new Graphiclist(myImage, nText);
			graphic.scrollX = 0;
			graphic.scrollY = 0; //ui element; fix position on the screen
			
			setHitbox(myImage.width, myImage.height);
			
			super(x, y, graphic, mask);
		}
		
	}

}