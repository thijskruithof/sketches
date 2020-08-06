
function toBin(num, size=4) { if (size < 1) size = 1; var s = "000000000000000000" + num.toString(2); return s.substr(s.length-size); }

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

	worldToScreenPos(worldPos)
	{	
		return worldPos.clone().subtract(this.worldCenter).divide(new Victor(this.worldScale, this.worldScale)).add(this.screenRect.center);
	}

	worldToScreenRect(worldRect)
	{
		return new Rect(this.worldToScreenPos(worldRect.min), this.worldToScreenPos(worldRect.max));
	}

	screenToWorldPos(screenPos)
	{
		return screenPos.clone().subtract(this.screenRect.center).multiply(new Victor(this.worldScale, this.worldScale)).add(this.worldCenter);
	}

	screenToWorldRect(screenRect)
	{
		return new Rect(this.screenToWorldPos(screenRect.min), this.screenToWorldPos(screenRect.max));
	}
}



class Tile
{
	constructor(parent, lod, worldRect, cellY, cellX)
	{
		this.parent = parent;
		this.children = []; 
		this.lod = lod; //< 0 for highest detail
		this.worldRect = worldRect.clone();
		this.cellY = cellY;
		this.cellX = cellX;

		this.isLoaded = false;		
		this.image = null;
		this.imagePath = "sketches/939b106b/" + 
			((lod == 4) ? (lod.toString()+".jpg") : (lod.toString() + "_" + toBin(cellY, 4-lod) + "_" + toBin(cellX, 4-lod) + ".jpg"));
	}
}



var gView;
var gRootTile;

// View adjustment
var gIsPanning = false;
var gPanInitialMouseWorldPos;
var gPanInitialMouseView;
var gIsZooming = false;
var gZoomAmount;


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
			var newTile = new Tile(tile, tile.lod-1, rect, tile.cellY*2+y, tile.cellX*2+x);
			tile.children.push(newTile);

			createTileChildrenRecursive(newTile);
		}
	}
}


var timeUntilNextLoad = 0;

function updateTileLoading()
{
	timeUntilNextLoad -= gRenderDeltaTime;
	if (timeUntilNextLoad > 0)
		return;
	
	timeUntilNextLoad += 0.1;

	var tilesToLoad = getTilesToLoad()
	if (tilesToLoad.length == 0)
		return;
	
	var tile = tilesToLoad[0]

//	var tile = findNotLoadedTileWithLowestLodRecursive(gRootTile,-1);
	if (tile != null)
	{
		loadImage(tile.imagePath, img => {
			tile.image = img;
			tile.isLoaded = true;
		});		
	}
}



function getTilesToLoad()
{
	var tilesPerLod = [[],[],[],[],[],[]]
	var worldScreenRect = gView.screenToWorldRect(gView.screenRect);

	getTilesToLoadRecursive(gRootTile, worldScreenRect, tilesPerLod);

	// Gather all tiles, LOD 4 first
	var result = tilesPerLod[tilesPerLod.length-1];
	for (var j=tilesPerLod.length-2; j>=0; --j)
		for (var i=0; i<tilesPerLod[j].length; ++i)
			result.push(tilesPerLod[j][i]);
	return result;	
}



function getTilesToLoadRecursive(tile, worldScreenRect, tilesToLoadPerLod)
{
	if (!tile.worldRect.overlaps(worldScreenRect))
		return;
	
	if (!tile.isLoaded)
		tilesToLoadPerLod[tile.lod].push(tile);

	for (var i=0; i<tile.children.length; ++i)
		getTilesToLoadRecursive(tile.children[i], worldScreenRect, tilesToLoadPerLod);
}



function findNotLoadedTileWithLowestLodRecursive(tile)
{
	var bestTile = null;

	for (var i=0; i<tile.children.length; ++i)
	{
		var childBestTile = findNotLoadedTileWithLowestLodRecursive(tile.children[i]);
		if (childBestTile != null)
		{
			if (bestTile == null || childBestTile.lod > bestTile.lod)
				bestTile = childBestTile;
		}
	}

	if (!tile.isLoaded && (bestTile == null || tile.lod > bestTile.lod))
		bestTile = tile;

	return bestTile;
}


function setup() 
{
	var cnv = createCanvas(window.innerWidth, window.innerHeight);
	cnv.position(0, 0);	
	cnv.style('position', 'absolute');

	// Construct our view
	gView = new View(new Rect(new Victor(0, 0), new Victor(window.innerWidth, window.innerHeight)));

	// For now just start with fitting some stuff in our view
	gView.fitToContent(new Rect(new Victor(8,8), new Victor(9,9)));

	// Create our tree of tiles
	gRootTile = new Tile(null, 4, new Rect(new Victor(0,0), new Victor(16,16)), 0, 0);
	createTileChildrenRecursive(gRootTile);

	// load image
	testImg = loadImage("sketches/939b106b/3_0_1.jpg");

	// Disable any touch controls
	cnv.style('touch-action', 'none');
}



function drawTilesRecursive(tile, desiredLod, worldScreenRect)
{
	if (!tile.worldRect.overlaps(worldScreenRect))
		return;

	if (tile.children.length > 0 && tile.lod > desiredLod)
	{
		var allChildrenLoaded = true;
		for (var i=0; i<tile.children.length; ++i)
			if (!tile.children[i].isLoaded)
		 		allChildrenLoaded = false;

		// If all our children have been loaded, we can safely draw
		// each of them individually
		if (allChildrenLoaded)
		{
			for (var i=0; i<tile.children.length; ++i)
				drawTilesRecursive(tile.children[i], desiredLod, worldScreenRect);
		
			return;
		}
	}

	if (!tile.isLoaded)
		return;

	var r = gView.worldToScreenRect(tile.worldRect);

	image(tile.image, r.min.x, r.min.y, r.max.x-r.min.x, r.max.y-r.min.y);

	// strokeWeight(1);
	// stroke(0,0,0);
	// if (tile.isLoaded)
	// 	fill(0,255,0);
	// else
	// 	fill(255,0,0);

	// rect(r.min.x, r.min.y, r.max.x-r.min.x, r.max.y-r.min.y);
	// line(r.min.x, r.min.y, r.max.x, r.max.y);
	// line(r.min.x, r.max.y, r.max.x, r.min.y);
}


function calcDesiredLod()
{
	var cTileImageSize = 256;

	var worldScreenRect = gView.screenToWorldRect(new Rect(new Victor(0,0), new Victor(gRenderWidth, gRenderHeight)));
	var worldScreenSize = worldScreenRect.size;

	var numTilePixelsOnScreen = worldScreenSize.clone().multiply(new Victor(cTileImageSize, cTileImageSize));
	var numTilePixelsPerPixel = numTilePixelsOnScreen.clone().divide(new Victor(gRenderWidth, gRenderHeight));

	var lod = Math.max(1.0, Math.min(numTilePixelsPerPixel.x, numTilePixelsPerPixel.y));
	lod = Math.min(4.0, Math.round(Math.log2(lod)));

	return lod;
}


function drawLod0State(tile)
{
	if (tile.children.length > 0)
	{
		for (var i=0; i<tile.children.length; ++i)
			drawLod0State(tile.children[i]);	
		return;
	}

	if (!tile.isLoaded)
		return;

	var r = gView.worldToScreenRect(tile.worldRect);

	stroke(0,0,0);
	fill(0,128,0);	
	rect(r.min.x, r.min.y, r.max.x-r.min.x, r.max.y-r.min.y);
}


function draw() 
{
	preDraw();

	updateTileLoading();

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

	var desiredLod = calcDesiredLod();
	var worldScreenRect = gView.screenToWorldRect(gView.screenRect);
	drawTilesRecursive(gRootTile, desiredLod, worldScreenRect);
	//drawLod0State(gRootTile);


	//image(testImg, 100, 100);

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
			gZoomAmount = 0.01;
		}
		else if (isMouseOverZoomButton(false))
		{
			gIsZooming = true;
			gZoomAmount = -0.01;
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

function getScreenRect()
{

}