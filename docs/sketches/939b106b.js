/*
	939b106b.js 
	https://github.com/thijskruithof/sketches

    Copyright (C) 2020 Thijs Kruithof

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

const gMaps = [
	{ 
		title: "Testing grid", 
		tileSize: 256, 
		numTilesPerAxisLod0: 16, 
		numLods: 5, 
		tileFilename: tile => { 
			return "sketches/939b106b/grid/" + (
				(tile.lod == gMap.numLods-1) ? 
				(tile.lod.toString()+".jpg") : 
				(tile.lod.toString() + "_" + toBin(tile.cellIndex.y, (gMap.numLods-1)-tile.lod) + "_" + toBin(tile.cellIndex.x, (gMap.numLods-1)-tile.lod) + ".jpg")
				); 
		} 
	},
	{ 
		title: "Mars", 
		tileSize: 512, 
		numTilesPerAxisLod0: 32, 
		numLods: 6, 
		tileFilename: tile => { 
			return "sketches/939b106b/mars/" + tile.lod.toString() + "/" +
				((tile.lod == gMap.numLods-1) ? "0/0.webp" : (tile.cellIndex.y.toString() + "/" + tile.cellIndex.x.toString() + ".webp")); 
		} 

	},
];


function toBin(num, size=4) 
{ 
	if (size < 1) 
		size = 1; 
	var s = "000000000000000000" + num.toString(2); 
	return s.substr(s.length-size); 
}

class Rect
{
	constructor (min, max)
	{
		this.min = min.clone();
		this.max = max.clone();
	}

	clone()
	{
		return new Rect(this.min, this.max);
	}

	get center()
	{
		return this.min.clone().mix(this.max, 0.5);
	}

	get size()
	{
		return this.max.clone().subtract(this.min);
	}

	overlaps(otherRect)
	{
		return !(this.max.x < otherRect.min.x ||
			this.max.y < otherRect.min.y ||
			this.min.x > otherRect.max.x ||
			this.min.y > otherRect.max.y);
	}
}

class View 
{
	constructor(screenRect)
	{
		// Screen dimensions
		this.screenRect = screenRect.clone();

		// World dimensions
		this.worldCenter = new Victor(0, 0);	//< Which position (in world coords) is shown in the center of the screen
		this.worldScale = 1.0; 					//< Size in pixels on screen of 1 world unit.
	}

	clone()
	{
		var newView = new View(this.screenRect);
		newView.worldCenter = this.worldCenter.clone();
		newView.worldScale = this.worldScale;
		return newView;
	}

	fitToContent(worldRect)
	{	
		// Center
		this.worldCenter = worldRect.center;

		// Scale
		var worldSize = worldRect.size;
		var screenSize = this.screenRect.size;
		var scale = new Victor(worldSize.x / screenSize.x, worldSize.y / screenSize.y);
		this.worldScale = Math.max(scale.x, scale.y);
	}

	worldToScreenPos(pos)
	{	
		return pos.clone().subtract(this.worldCenter).divide(new Victor(this.worldScale, this.worldScale)).add(this.screenRect.center);
	}

	worldToScreenRect(rect)
	{
		return new Rect(this.worldToScreenPos(rect.min), this.worldToScreenPos(rect.max));
	}

	screenToWorldPos(pos)
	{
		return pos.clone().subtract(this.screenRect.center).multiply(new Victor(this.worldScale, this.worldScale)).add(this.worldCenter);
	}

	screenToWorldRect(rect)
	{
		return new Rect(this.screenToWorldPos(rect.min), this.screenToWorldPos(rect.max));
	}

	get worldRect()
	{
		return this.screenToWorldRect(this.screenRect);
	}
}


const ETileState = { unloaded:0, loading:1, loaded:2 };


class Tile
{
	constructor(parent, lod, worldRect, cellIndex, childIndex)
	{
		this.parent = parent;
		this.children = []; 
		this.lod = lod; //< 0 for highest detail
		this.worldRect = worldRect.clone();
		this.cellIndex = cellIndex.clone();
		this.childIndex = childIndex.clone();

		this.state = ETileState.unloaded;
		this.image = null;
		this.imagePath = gMap.tileFilename(this);
		this.isVisible = false;
	}
}


class TileGrid
{
	constructor(lod, numTilesPerAxis)
	{
		this.lod = lod;
		this.numTilesPerAxis = numTilesPerAxis;
		this.tiles = [];
		for (var x=0; x<numTilesPerAxis*numTilesPerAxis; ++x)
			this.tiles.push(null);
	}

	addTile(tile)
	{
		this.tiles[tile.cellIndex.y*this.numTilesPerAxis+tile.cellIndex.x] = tile;
	}

	getTilesInWorldRect(worldRect)
	{
		var tileSize = pow(2, this.lod);
		var tl = new Victor(Math.floor(worldRect.min.x/tileSize), Math.floor(worldRect.min.y/tileSize));
		var br = new Victor(Math.floor(worldRect.max.x/tileSize), Math.floor(worldRect.max.y/tileSize));

		// Clamp window to valid range
		tl.x = Math.min(this.numTilesPerAxis-1, Math.max(0, tl.x));
		tl.y = Math.min(this.numTilesPerAxis-1, Math.max(0, tl.y));
		br.x = Math.min(this.numTilesPerAxis-1, Math.max(0, br.x));
		br.y = Math.min(this.numTilesPerAxis-1, Math.max(0, br.y));		

		var result = [];
		for (var y=tl.y; y<=br.y; ++y)
			for (var x=tl.x; x<=br.x; ++x)
				result.push(this.tiles[y*this.numTilesPerAxis+x]);

		return result;
	}
}


var gMap;
var gView;

// Tiles
var gRootTile;
var gTileGrids;

// View adjustment
var gIsPanning = false;
var gPanInitialMouseWorldPos;
var gPanInitialMouseView;
var gIsZooming = false;
var gZoomAmount;

// Streaming state
var gNumTilesBeingLoaded = 0;

// Debug info
var gDebugInfo = {
	desiredLod: 0,
	numTilesVisible: 0,
	numTilesLoaded: 0,
	numTilesLoading: 0
};

var gDebugSettings = {
	loadOneByOne: false
};



function visitTileParents(tile, visitor)
{
	while (tile != null)
	{
		visitor(tile);
		tile = tile.parent;
	}
}


function visitTileChildren(tile, visitor)
{
	if (tile == null)
		return;
	
	visitor(tile);
	for (var i=0; i<tile.children.length; ++i)
		visitTileChildren(tile.children[i], visitor);
}



function createTileChildrenRecursive(tile)
{
	if (tile.lod == 0)
		return;

	var childTileSize = tile.worldRect.size.multiply(new Victor(0.5, 0.5));

	for (var y=0; y<2; ++y)
	{
		for (var x=0; x<2; ++x)
		{
			var rectMin = tile.worldRect.min.clone().add(childTileSize.clone().multiply(new Victor(x,y)));
			var rect = new Rect(rectMin, rectMin.clone().add(childTileSize));
			var newTile = new Tile(tile, tile.lod-1, rect, new Victor(tile.cellIndex.x*2+x, tile.cellIndex.y*2+y), new Victor(x, y));
			tile.children.push(newTile);

			gTileGrids[tile.lod-1].addTile(newTile);

			createTileChildrenRecursive(newTile);
		}
	}
}



function updateTileLoading()
{
	if (gDebugSettings.loadOneByOne && gNumTilesBeingLoaded > 0)
		return;

	var tilesToLoad = getTilesToLoad()
	if (tilesToLoad.length == 0)
		return;

	// Simply only load the first one from the list
	var tile = tilesToLoad[0]

	if (tile != null)
	{
		gNumTilesBeingLoaded++;
		tile.state = ETileState.loading;

		loadImage(tile.imagePath, img => {
			tile.image = img;
			tile.state = ETileState.loaded;
			gNumTilesBeingLoaded--;
		}, evt => {
			tile.state = ETileState.unloaded;
			gNumTilesBeingLoaded--;
		});		
	}
}



function updateTileUnloading()
{
	// For now immediately unload all tiles that are not visible.
	visitTileChildren(gRootTile, tile => { 
		if (!tile.isVisible && tile.state == ETileState.loaded)
			tile.state = ETileState.unloaded;
	});
}


/**
 * Determine which tiles to load.
 * This returns the tiles that are on screen, for lods 4 to desired visible lod.
 */
function getTilesToLoad()
{
	var desiredLod = calcDesiredLod();
	var tilesPerLod = [];
	for (var i=0; i<gMap.numLods; ++i)
		tilesPerLod.push([]);	

	visitTileChildren(gRootTile, tile => { 
		if (tile.lod >= desiredLod && tile.isVisible && tile.state == ETileState.unloaded)
			tilesPerLod[tile.lod].push(tile);
	});

	// Gather all tiles, LOD N first
	var result = tilesPerLod[tilesPerLod.length-1];
	for (var j=tilesPerLod.length-2; j>=0; --j)
		for (var i=0; i<tilesPerLod[j].length; ++i)
			result.push(tilesPerLod[j][i]);
	return result;	
}



function setup() 
{
	var cnv = createCanvas(window.innerWidth, window.innerHeight);
	cnv.position(0, 0);	
	cnv.style('position', 'absolute');

	gMap = gMaps[1];

	// Construct our view
	gView = new View(new Rect(new Victor(0, 0), new Victor(window.innerWidth, window.innerHeight)));

	// For now just start with fitting some stuff in our view
	gView.fitToContent(new Rect(new Victor(8,8), new Victor(9,9)));

	// Create our empty grids
	gTileGrids = [];
	for (var lod=0; lod<gMap.numLods; lod++)
		gTileGrids.push(new TileGrid(lod, Math.pow(2,(gMap.numLods-1)-lod)));

	// Create our tree of tiles
	gRootTile = new Tile(null, gMap.numLods-1, new Rect(new Victor(0,0), new Victor(gMap.numTilesPerAxisLod0,gMap.numTilesPerAxisLod0)), new Victor(0,0), new Victor(0,0));
	gTileGrids[gMap.numLods-1].addTile(gRootTile);
	createTileChildrenRecursive(gRootTile);

	// Disable any touch controls
	cnv.style('touch-action', 'none');

	// Set up debug ui
	var pane = new Tweakpane();
	pane.element.parentElement.style.top = "67px";

	var folderStatus = pane.addFolder({ title: 'Status' });	
	folderStatus.addMonitor(gDebugInfo, 'desiredLod', {label: "LOD"});
	folderStatus.addMonitor(gDebugInfo, 'numTilesVisible', {label: "Tiles visible"});
	folderStatus.addMonitor(gDebugInfo, 'numTilesLoaded', {label: "Tiles loaded"});
	folderStatus.addMonitor(gDebugInfo, 'numTilesLoading', {label: "Tiles loading"});
	

	var folderStreaming = pane.addFolder({ title: 'Streaming' });
	folderStreaming.addInput(gDebugSettings, 'loadOneByOne');
}


function calcDesiredLod()
{
	var cTileImageSize = gMap.tileSize;

	var worldScreenSize = gView.worldRect.size;

	var numTilePixelsOnScreen = worldScreenSize.clone().multiply(new Victor(cTileImageSize, cTileImageSize));
	var numTilePixelsPerPixel = numTilePixelsOnScreen.clone().divide(new Victor(gRenderWidth, gRenderHeight));

	var lod = Math.max(1.0, Math.min(numTilePixelsPerPixel.x, numTilePixelsPerPixel.y));
	lod = Math.min(gMap.numLods-1, Math.round(Math.log2(lod)));

	return lod;
}


function getVisibleTiles(desiredLod)
{
	var worldScreenRect = gView.worldRect;

	var desiredTileGrid = gTileGrids[desiredLod];
	var desiredTilesOnScreen = desiredTileGrid.getTilesInWorldRect(worldScreenRect);

	var tiles = [];
	for (var i=0; i<desiredTilesOnScreen.length; ++i)
	{
		var tile = desiredTilesOnScreen[i];

		var tileImageRect = new Rect(new Victor(0,0), new Victor(gMap.tileSize, gMap.tileSize));

		// Find a parent that is loaded
		while (tile.lod < gMap.numLods-1 && tile.state != ETileState.loaded)
		{		
			// Recalculate our image rect
			var newImageRectSize = tileImageRect.size.clone().divide(new Victor(2,2));
			var newImageRectOffset = tileImageRect.min.clone().divide(new Victor(2,2)).add(tile.childIndex.clone().multiply(new Victor(gMap.tileSize/2, gMap.tileSize/2)));
			tileImageRect = new Rect(newImageRectOffset, newImageRectOffset.clone().add(newImageRectSize));

			tile = tile.parent;			
		}

		tiles.push({ screenTile: desiredTilesOnScreen[i], sourceTile: tile, sourceTileRect: tileImageRect });
	}

	return tiles;
}



function draw() 
{
	preDraw();

	// Adjust our view's screenspace to our canvas (in case it resized)
	gView.screenRect = new Rect(new Victor(0,0), new Victor(gRenderWidth, gRenderHeight));

	// Apply view adjustment
	if (gIsPanning)
	{
		var currentMouseWorldPos = gPanInitialMouseView.screenToWorldPos(getMousePos());
		var deltaMouseWorldPos = currentMouseWorldPos.clone().subtract(gPanInitialMouseWorldPos);

		gView.worldCenter.copy(gPanInitialMouseView.worldCenter).subtract(deltaMouseWorldPos);
	}
	if (gIsZooming)
	{
		gView.worldScale *= pow(2, -gZoomAmount);
	}

	background(255, 255, 255);

	strokeWeight(1);	
	stroke(0,0,0);

	visitTileChildren(gRootTile, tile => {tile.isVisible = false;});

	var desiredLod = calcDesiredLod();
	var visibleTiles = getVisibleTiles(desiredLod);

	for (var i=0; i<visibleTiles.length; ++i)
	{	
		var visibleTile = visibleTiles[i];

		// Mark this tile as being visible, uncluding all its parents
		visitTileParents(visibleTile.screenTile, tile => {tile.isVisible = true;});

		if (visibleTile.sourceTile.state != ETileState.loaded)
			continue;

		var screenRect = gView.worldToScreenRect(visibleTile.screenTile.worldRect);
		var sourceRect = visibleTile.sourceTileRect;

		image(visibleTile.sourceTile.image, 
			screenRect.min.x, screenRect.min.y, screenRect.max.x-screenRect.min.x, screenRect.max.y-screenRect.min.y,
			sourceRect.min.x, sourceRect.min.y, sourceRect.max.x-sourceRect.min.x, sourceRect.max.y-sourceRect.min.y
		);
	}

	updateTileLoading();	
	updateTileUnloading();

	// Gather debug info
	var numTilesLoaded = 0;
	visitTileChildren(gRootTile, tile => { if (tile.state == ETileState.loaded) numTilesLoaded++;});
	
	gDebugInfo.desiredLod = desiredLod;
	gDebugInfo.numTilesVisible = visibleTiles.length;
	gDebugInfo.numTilesLoaded = numTilesLoaded;
	gDebugInfo.numTilesLoading = gNumTilesBeingLoaded;

	drawUI();

	postDraw();
}


function getMousePos()
{
	return new Victor(mouseX, mouseY);
}

function isMouseOverZoomButton(zoomIn)
{
	var buttonX = 100;
	var buttonY = zoomIn ? (gRenderHeight-200) : (gRenderHeight-100);	

	var dist = getMousePos().subtract(new Victor(buttonX, buttonY)).length();
	return dist <= 75;
}


function drawUI()
{
	strokeWeight(1);
	stroke(0,0,0);
	fill(255,255, !gIsPanning && isMouseOverZoomButton(false) ? 0 : 255);
	circle(100, gRenderHeight-100, 75);
	fill(255,255, !gIsPanning && isMouseOverZoomButton(true) ? 0 : 255);
	circle(100, gRenderHeight-200, 75);

	fill(0,0,0);
	noStroke();
	textAlign(CENTER, CENTER);
	textStyle(NORMAL);
	textSize(50);
	text('+', 100, gRenderHeight-200+4);
	text('-', 100, gRenderHeight-100);
}

function mousePressed()
{
	if (!gIsPanning && !gIsZooming)
	{
		if (isMouseOverZoomButton(true))
		{
			gIsZooming = true;
			gZoomAmount = 0.02;
		}
		else if (isMouseOverZoomButton(false))
		{
			gIsZooming = true;
			gZoomAmount = -0.02;
		}
		else 
		{
			gPanInitialMouseView = gView.clone();
			gPanInitialMouseWorldPos = gView.screenToWorldPos(getMousePos());
			gIsPanning = true;
		}
	}
}

function mouseReleased()
{
	gIsPanning = false;
	gIsZooming = false;
}
