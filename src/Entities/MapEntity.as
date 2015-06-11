package entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class MapEntity extends Entity 
	{
		private var xmlData:XML
		private var tilemap_1:Tilemap;
		
		public var playerStart:Point;
		
		public function MapEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			
			xmlData = FP.getXML(C.LEVEL_ONE_DATA);
			playerStart = new Point(xmlData.entities.playerStart.@x, xmlData.entities.playerStart.@y);
		}
		
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
		
		public function getPlatforms():Vector.<MovingPlatform>
		{
			var platforms:Vector.<MovingPlatform> = new Vector.<MovingPlatform>();
			
			var list:XMLList;
			var element:XML;
			
			list = xmlData.entities.movingPlatform;
			for each (element in list)
			{
				platforms.push(new MovingPlatform(element.@ID, element.@yScale, element.@x, element.@y));
			}
			
			return platforms;
		}
		
	}

}