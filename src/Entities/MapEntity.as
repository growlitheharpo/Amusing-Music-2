/* *****************************************************************************
 * Amusing Music 2 is a portfolio piece demonstrating rhythm-based platforming.
 *   Copyright (C) 2015  James Keats (www.jameskeats.com)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 ****************************************************************************** */
package entities 
{
	import entities.collectables.Star;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Grid;
	
	/**
	 * Loads the data for a level from the appropriate XML.
	 * @author James Keats
	 */
	public class MapEntity extends Entity 
	{
		private var xmlData:XML
		public var tilemap_1:Tilemap;
		
		public var playerStart:Point;
		
		/**
		 * Create a new map.
		 * @param	currentLevel The level (starts at 1) to load.
		 */
		public function MapEntity(currentLevel:int) 
		{
			super(0, 0, null, null);
			
			if (currentLevel > C.LIST_OF_LEVELS.length || currentLevel <= 0)
				xmlData = null;
			else
				xmlData = FP.getXML(C.LIST_OF_LEVELS[currentLevel - 1]);
			
			playerStart = new Point(xmlData.entities.playerStart.@x, xmlData.entities.playerStart.@y);
		}
		
		/**
		 * Loads the collision grid and the tilemap when added to world.
		 */
		override public function added():void
		{
			var mapGrid:Grid = new Grid(xmlData.@width, xmlData.@height, C.BASE_TILE_SIZE, C.BASE_TILE_SIZE, 0, 0);
			mapGrid.loadFromString(xmlData.solid, "", "\n");
			mask = mapGrid;
			type = "solid";
			
			tilemap_1 = new Tilemap(C.BASE_WORLD_TILES, xmlData.@width, xmlData.@height, C.BASE_TILE_SIZE, C.BASE_TILE_SIZE);
			tilemap_1.loadFromString(xmlData.visualTiles, ",", "\n");
			
			graphic = tilemap_1;
		}
		
		/**
		 * Fills a vector with new MovingPlatforms with properties loaded from XML.
		 * @return The vector
		 */
		public function getPlatforms():Vector.<MovingPlatform>
		{
			var platforms:Vector.<MovingPlatform> = new Vector.<MovingPlatform>();
			
			var list:XMLList;
			var tPlatform:XML;
			
			list = xmlData.entities.movingPlatform;
			for each (tPlatform in list)
			{
				platforms.push(new MovingPlatform(tPlatform.@ID, tPlatform.@yScale, tPlatform.@starIDActivator, tPlatform.@soundPiece, tPlatform.@x, tPlatform.@y));
			}
			
			return platforms;
		}
		
		/**
		 * Fills a vector with new Stars with properties loaded from XML.
		 * @return The vector
		 */
		public function getStars():Vector.<Star>
		{
			var stars:Vector.<Star> = new Vector.<Star>();
			
			var list:XMLList;
			var tStar:XML;
			
			list = xmlData.entities.star;
			for each (tStar in list)
			{
				stars.push(new Star(tStar.@starID, tStar.@soundToPlay, tStar.@x, tStar.@y));
			}
			
			return stars;
		}
		
	}

}