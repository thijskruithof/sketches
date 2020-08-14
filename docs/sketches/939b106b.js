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
		numTilesXLod0: 16, 
		numTilesYLod0: 16,
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
		numTilesXLod0: 64, 
		numTilesYLod0: 32,
		numLods: 7, 
		tileFilename: tile => { 
			return "sketches/939b106b/mars/" + tile.lod.toString() + "/" +
				((tile.lod == gMap.numLods-1) ? "0/0.jpg" : (tile.cellIndex.y.toString() + "/" + tile.cellIndex.x.toString() + ".jpg")); 
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
		newView.worldScale = this.worldScale;
		newView.worldCenter = this.worldCenter.clone();
		return newView;
	}

	fitToContent(worldRect)
	{	
		// Scale
		var worldSize = worldRect.size;
		var screenSize = this.screenRect.size;
		var scale = new Victor(worldSize.x / screenSize.x, worldSize.y / screenSize.y);
		this.worldScale = Math.max(scale.x, scale.y);
		
		// Center
		this.worldCenter = worldRect.center;

		this.applyViewLimits();
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

	applyViewLimits()
	{
		// Limit scale
		var minScale = 1.0/gMap.tileSize;
		var maxScale = Math.min(gMap.numTilesXLod0 / this.screenRect.size.x, gMap.numTilesYLod0 / this.screenRect.size.y);
		this.worldScale = Math.min(Math.max(this.worldScale, minScale), maxScale);

		// Limit panning
		// Min world center: when 0,0 in world is placed at 0,0 on screen
		var minWorldCenter = this.screenRect.center.clone().multiply(new Victor(this.worldScale, this.worldScale));
		// Max world center: when N,N in world is placed at W,H on screen
		var maxWorldCenter = new Victor(gMap.numTilesXLod0, gMap.numTilesYLod0).subtract(minWorldCenter);

		this.worldCenter = new Victor(
			Math.max(minWorldCenter.x, Math.min(maxWorldCenter.x, this.worldCenter.x)),
			Math.max(minWorldCenter.y, Math.min(maxWorldCenter.y, this.worldCenter.y)),
		);
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
		this.valid = (worldRect.min.x < gMap.numTilesXLod0) && (worldRect.min.y < gMap.numTilesYLod0);
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
		{
			for (var x=tl.x; x<=br.x; ++x)
			{
				var tile = this.tiles[y*this.numTilesPerAxis+x];
				if (tile.valid == true)
					result.push(tile);
			}
		}

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
var gZoomInitialMouseScreenPos;
var gZoomInitialMouseWorldPos;
var gZoomInitialMouseView;


// Streaming state
var gNumTilesBeingLoaded = 0;

// UI
var gOptionsButtonOn;
var gOptionsButtonOff;
var gOptionsButtonAngle = 0;
var gTweakPane;

// Debug info
var gDebugInfo = {
	desiredLod: 0,
	numTilesVisible: 0,
	numTilesLoaded: 0,
	numTilesLoading: 0
};

var gDebugSettings = {
	mapIndex: 1,
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
	if (tile == null || tile.valid == false)
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


function selectMap(map)
{
	// Unload all images (if any)	
	if (gRootTile != null)
		visitTileChildren(gRootTile, tile => {tile.state = ETileState.unloaded;});

	// Switch to new map
	gMap = map;

	// Reset our view
	gView.fitToContent(new Rect(new Victor(8,8), new Victor(9,9)));

	// Create our empty grids
	gTileGrids = [];
	for (var lod=0; lod<gMap.numLods; lod++)
		gTileGrids.push(new TileGrid(lod, Math.pow(2,(gMap.numLods-1)-lod)));

	// Create our tree of tiles
	var maxTilesPerAxisLod0 = Math.max(gMap.numTilesXLod0, gMap.numTilesYLod0);
	gRootTile = new Tile(null, gMap.numLods-1, new Rect(new Victor(0,0), new Victor(maxTilesPerAxisLod0, maxTilesPerAxisLod0)), new Victor(0,0), new Victor(0,0));
	gTileGrids[gMap.numLods-1].addTile(gRootTile);
	createTileChildrenRecursive(gRootTile);
}


function setup() 
{
	var cnv = createCanvas(window.innerWidth, window.innerHeight);
	cnv.position(0, 0);	
	cnv.style('position', 'absolute');

	// Construct our view
	gView = new View(new Rect(new Victor(0, 0), new Victor(window.innerWidth, window.innerHeight)));

	// Init our map
	selectMap(gMaps[gDebugSettings.mapIndex]);

	// Disable any touch controls
	cnv.style('touch-action', 'none');

	// Set up debug ui
	gTweakPane = new Tweakpane();
	gTweakPane.element.parentElement.style.top = "116px";
	gTweakPane.hidden = true;

	var folderStatus = gTweakPane.addFolder({ title: 'Status' });	
	folderStatus.addMonitor(gDebugInfo, 'desiredLod', {label: "LOD"});
	folderStatus.addMonitor(gDebugInfo, 'numTilesVisible', {label: "Tiles visible"});
	folderStatus.addMonitor(gDebugInfo, 'numTilesLoaded', {label: "Tiles loaded"});
	folderStatus.addMonitor(gDebugInfo, 'numTilesLoading', {label: "Tiles loading"});

	var folderMap = gTweakPane.addFolder({ title: 'Map' });
	var mapOptions = {};
	for (var i=0; i<gMaps.length; ++i)
		mapOptions[gMaps[i].title] = i;
	folderMap.addInput(gDebugSettings, 'mapIndex', { options: mapOptions, label: "Map"	}).on('change', (value) => {
		selectMap(gMaps[value]);
	});

	var folderStreaming = gTweakPane.addFolder({ title: 'Streaming' });
	folderStreaming.addInput(gDebugSettings, 'loadOneByOne', {label: "Load one by one"});

	gOptionsButtonOn = loadImage("sketches/939b106b/options_on.png");
	gOptionsButtonOff = loadImage("sketches/939b106b/options_off.png");
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

		var newWorldCenter = gPanInitialMouseView.worldCenter.clone().subtract(deltaMouseWorldPos);

		gView.worldCenter = newWorldCenter;
	}
	if (gIsZooming)
	{	
		var factor = pow(2, -gZoomAmount);

		// Adjust scale
		gView.worldScale *= factor;

		// Force limits before adjusting center, to assure we're not applying more or less scale than possible
		gView.applyViewLimits();

		// Adjust world center (to take scaling pivot into account)
		var screenScalePivotOffset = gZoomInitialMouseScreenPos.clone().subtract(gZoomInitialMouseView.screenRect.center).multiply(new Victor(gView.worldScale, gView.worldScale));
		var scalePivotOffset = gZoomInitialMouseWorldPos.clone().subtract(gZoomInitialMouseView.worldCenter).subtract(screenScalePivotOffset);

		gView.worldCenter = gZoomInitialMouseView.worldCenter.clone().add(scalePivotOffset);
		gIsZooming = false;
	}

	gView.applyViewLimits();	

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


var drawUImouseWasPressed = false;

function drawUI()
{
	var buttonPos = new Victor(gRenderWidth - 30, 86);
	var on = (getMousePos().distance(buttonPos) <= 32.0);

	var desiredAngle = gTweakPane.hidden ? 0 : PI;
	gOptionsButtonAngle = gOptionsButtonAngle + (desiredAngle - gOptionsButtonAngle)*0.2;

	translate(buttonPos.x, buttonPos.y);
	rotate(gOptionsButtonAngle);
	imageMode(CENTER);
	image(on ? gOptionsButtonOn : gOptionsButtonOff, 0,0);
	imageMode(CORNER);

	if (!drawUImouseWasPressed && mouseIsPressed && on)
		gTweakPane.hidden = !gTweakPane.hidden;

	drawUImouseWasPressed = mouseIsPressed;
}

function mousePressed()
{
	if (!gIsPanning)
	{
		gPanInitialMouseView = gView.clone();
		gPanInitialMouseWorldPos = gView.screenToWorldPos(getMousePos());
		gIsPanning = true;
	}
}

function mouseReleased()
{
	gIsPanning = false;
}

function mouseWheel(event) 
{
	if (!gIsPanning)
	{
		gIsZooming = true;

		var maxZoomAmount = 1.0;
		gZoomAmount = Math.max(-maxZoomAmount, Math.min(maxZoomAmount, -event.delta / 200.0));

		gZoomInitialMouseView = gView.clone();
		gZoomInitialMouseScreenPos = getMousePos();
		gZoomInitialMouseWorldPos = gView.screenToWorldPos(gZoomInitialMouseScreenPos);
	}

	return false;
  }