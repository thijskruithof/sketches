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
		albedoImagePath: tile => { 
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
		albedoImagePath: tile => { 
			return "sketches/939b106b/mars/" + tile.lod.toString() + "/" +
				((tile.lod == gMap.numLods-1) ? "0/0.jpg" : (tile.cellIndex.y.toString() + "/" + tile.cellIndex.x.toString() + ".jpg")); 
		},
		elevationImagePath: tile => { 
			return "sketches/939b106b/mars/" + tile.lod.toString() + "/" +
				((tile.lod == gMap.numLods-1) ? "0/0_e.jpg" : (tile.cellIndex.y.toString() + "/" + tile.cellIndex.x.toString() + "_e.jpg")); 
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

	getFractionX(x)
	{
		return (x - this.min.x) / (this.max.x-this.min.x);
	}

	getFractionY(y)
	{
		return (y - this.min.y) / (this.max.y-this.min.y);
	}

	splitXAtFraction(fractionX)
	{
		if (fractionX <= 0.0 || fractionX >= 1.0)
			return null;

		var splitX = this.min.x + fractionX * (this.max.x - this.min.x);

		var rightRect = new Rect(new Victor(splitX, this.min.y), this.max);
		this.max.x = splitX;
		return rightRect;
	}

	splitYAtFraction(fractionY)
	{
		if (fractionY <= 0.0 || fractionY >= 1.0)
			return null;

		var splitY = this.min.y + fractionY * (this.max.y - this.min.y);

		var bottomRect = new Rect(new Victor(this.min.x, splitY), this.max);
		this.max.y = splitY;
		return bottomRect;
	}
}

class FrustumPlane2D
{
	constructor (frustumPlaneA, frustumPlaneB, frustumPlaneC, frustumPlaneD)
	{
		// Normalize our plane's coeffs
		var planeMag = Math.sqrt(
			frustumPlaneA*frustumPlaneA+
			frustumPlaneB*frustumPlaneB+
			frustumPlaneC*frustumPlaneC);

		frustumPlaneA /= planeMag;
		frustumPlaneB /= planeMag;
		frustumPlaneC /= planeMag;
		frustumPlaneD /= planeMag;

		// Calculate the edge between the frustum plane and the XY plane

		// Intersection ray's dir is normal(cross(normal, xyplane.normal)),
		// Which equals to:
		//  normalize(cross(normal, [0,0,1]))
		//  normalize(normal.y, -normal.x, 0)
		//
		// And because normal equals to [a,b,c]:
		//  normalize(b, -a)
		this.dir = new Victor(frustumPlaneB, -frustumPlaneA);
		this.dir.normalize();

		// Then we have to calculate a position on on both planes.
		//
		// Our own plane says:
		// 	N*(V - pos) = 0
		// And our XY plane says:
		//  posz = 0
		//
		// So we can solve this by combining the two:
		//   Nx(Vx - posx) + Ny(Vy - posy) - Nz*posz = 0
		//
		// And then let's assume Vx = 0:
		//   -Nx*posx + Ny(Vy - posy) - Nz*posz = 0
		//  Ny(Vy - posy) = Nx*posx + Nz*posz
		//  Vy = (Nx*posx + Nz*posz)/Ny + posy
		//  Vx = 0
		//
		// Note: this only works if Ny != 0. So we'll have to find a solution for when Ny ~= 0
		//
		// We can find that by solving for Vy = 0 (instead of Vx = 0):
		//  Nx(Vx - posx) - Ny*posy - Nz*posz = 0
		//  Nx(Vx - posx) = Ny*posy + Nz*posz
		//  Vx = (Ny*posy + Nz*posz)/Nx + posx
		//  Vy = 0
		//
		// And for both we subsitute normal with [a,b,c] and pos with [-d*a,-d*b,-d*c]:
		//
		// (1) Vy = (Nx*posx + Nz*posz)/Ny + posy
		//     Vy = (a*-d*a + c*-d*c)/b + -d*b
		//     Vy = -d*((a*a + c*c)/b + b)
		//
		// (2) Vx = (Ny*posy + Nz*posz)/Nx + posx
		//     Vx = (b*-d*b + c*-d*c)/a + -d*a
		//     Vx = -d*((b*v + c*c)/a + a)
		//
		if (Math.abs(frustumPlaneB) > Math.abs(frustumPlaneA))
			this.pos = new Victor(0.0, -frustumPlaneD*((frustumPlaneA*frustumPlaneA + frustumPlaneC*frustumPlaneC)/frustumPlaneB + frustumPlaneB));
		else
			this.pos = new Victor(-frustumPlaneD*((frustumPlaneB*frustumPlaneB + frustumPlaneC*frustumPlaneC)/frustumPlaneA + frustumPlaneA), 0.0);
	}

	// Calculate intersection with another 2d frustum plane
	// Returns the intersection position (Victor)
	intersect(otherPlane)
	{
		// Solve for: 
		//  a(t) = b(t)
		// Where:
		//  a(u) = adir*u + apos
		//  b(v) = bdir*v + bpos
		//
		// Option 1:
		// Solve for x:
		//  adirx*u + aposx = bdirx*v + bposx
		//  u = (bdirx/adirx)*v + (bposx - aposx)/adirx
		//
		// Solve for y:
		//  adiry*u + aposy = bdiry*v + bposy
		//  adiry*((bdirx/adirx)*v + (bposx - aposx)/adirx) + aposy = bdiry*v + bposy
		//  adiry*(bdirx/adirx)*v + (adiry/adirx)*(bposx - aposx) + aposy = bdiry*v + bposy

		//  (adiry*(bdirx/adirx) - bdiry)*v = (bposy - aposy) - (adiry/adirx)*(bposx - aposx) 
		//  v = ((bposy - aposy) - (adiry/adirx)*(bposx - aposx)) / (adiry*(bdirx/adirx) - bdiry)		
		//
		// Option 2: Same as option 1, but then solved for y first and then for x,
		// which effectively gives the same solution as option 1, but then all x and y swapped.

		var v;

		if (Math.abs(this.dir.x) > Math.abs(this.dir.y))
			v = ((otherPlane.pos.y - this.pos.y) - (this.dir.y/this.dir.x)*(otherPlane.pos.x - this.pos.x)) /
				(this.dir.y*(otherPlane.dir.x/this.dir.x) - otherPlane.dir.y);
		else
			v = ((otherPlane.pos.x - this.pos.x) - (this.dir.x/this.dir.y)*(otherPlane.pos.y - this.pos.y)) /
				(this.dir.x*(otherPlane.dir.y/this.dir.y) - otherPlane.dir.x);

		return otherPlane.dir.clone().multiply(new Victor(v,v)).add(otherPlane.pos);
	}
}


class Frustum2D
{
	constructor(mvpMatrix)
	{
		// Based on http://www.cs.otago.ac.nz/postgrads/alexis/planeExtraction.pdf

		var planeLeft = new FrustumPlane2D( 
	 		mvpMatrix[3] + mvpMatrix[0],
	 		mvpMatrix[7] + mvpMatrix[4],
	 		mvpMatrix[11] + mvpMatrix[8],
	 		mvpMatrix[15] + mvpMatrix[12]
	 	);

		var planeRight = new FrustumPlane2D( 
	 		mvpMatrix[3]  - mvpMatrix[0],
	 		mvpMatrix[7]  - mvpMatrix[4],
	 		mvpMatrix[11] - mvpMatrix[8],
	 		mvpMatrix[15] - mvpMatrix[12]
	 	);

	 	var planeTop = new FrustumPlane2D( 
	 		mvpMatrix[3]  - mvpMatrix[1],
	 		mvpMatrix[7]  - mvpMatrix[5],
	 		mvpMatrix[11] - mvpMatrix[9],
	 		mvpMatrix[15] - mvpMatrix[13]
	 	);
	 	
	 	var planeBottom = new FrustumPlane2D( 
	 		mvpMatrix[3]  + mvpMatrix[1],
	 		mvpMatrix[7]  + mvpMatrix[5],
	 		mvpMatrix[11] + mvpMatrix[9],
	 		mvpMatrix[15] + mvpMatrix[13]
	 	);

	 	// Calculate corners of 2D frustum (in 2D)
	 	this.tl = planeLeft.intersect(planeTop);
	 	this.bl = planeLeft.intersect(planeBottom);
	 	this.tr = planeRight.intersect(planeTop);
	 	this.br = planeRight.intersect(planeBottom);		
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
		this.worldScale = 1.0; 					//< Size in world units of 1 pixel on screen
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

	worldToScreenScale(scale)
	{
		return scale / this.worldScale;
	}

	worldToScreenRect(rect)
	{
		return new Rect(this.worldToScreenPos(rect.min), this.worldToScreenPos(rect.max));
	}

	screenToWorldPos(pos)
	{
		return pos.clone().subtract(this.screenRect.center).multiply(new Victor(this.worldScale, this.worldScale)).add(this.worldCenter);
	}

	screenToWorldScale(scale)
	{
		return scale * this.worldScale;
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


const ETileLoadingState = { unloaded:0, loading:1, loaded:2 };


class TileImage
{
	constructor(filePath)
	{
		this.loadingState = ETileLoadingState.unloaded;
		this.image = null;
		this.imagePath = filePath;
	}

	startLoading()
	{
		this.loadingState = ETileLoadingState.loading;

		gNumTileImagesBeingLoaded++;

		loadImage(this.imagePath, 
			(function(tileImage) 
			{ 
				return img =>
					{
						tileImage.image = img;
						tileImage.loadingState = ETileLoadingState.loaded;
						gNumTileImagesBeingLoaded--;
					};
			})(this), 
			(function(tileImage)
			{
				return evt => {
					tileImage.loadingState = ETileLoadingState.unloaded;
					gNumTileImagesBeingLoaded--;
				};					
			})(this)
		);
	}
}


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

		this.valid = (worldRect.min.x < gMap.numTilesXLod0) && (worldRect.min.y < gMap.numTilesYLod0);
		this.isVisible = false;

		this.albedoImage = new TileImage(gMap.albedoImagePath(this));
		this.elevationImage = new TileImage(gMap.elevationImagePath(this));
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

		var numCellsY = (br.y - tl.y)+1;
		var numCellsX = (br.x - tl.x)+1;

		// Gather all tiles
		var result = [];
		for (var y=tl.y; y<=br.y; ++y)
		{
			for (var x=tl.x; x<=br.x; ++x)
			{
				var t = this.tiles[y*this.numTilesPerAxis+x];
				result.push({ tile: t, index: [y-tl.y,x-tl.x] });
			}
		}

		// Construct neighbour cell indices
		for (var i=0; i<result.length; ++i)
		{
			var index = result[i].index;
			result[i].neighbours = [];

			for (var y=-1; y<=1; ++y)
			{
				for (var x=-1; x<=1; ++x)
				{
					var neighbourindex = -1;
					if (index[0]+y >= 0 && index[0]+y < numCellsY &&
						index[1]+x >= 0 && index[1]+x < numCellsX)
					{
						neighbourindex = i + y*numCellsX + x;
					}
					
					result[i].neighbours.push(neighbourindex);
				}
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
var gDesiredZoomAmount = 0;
var gCurrentZoomAmount = 0;
var gZoomInitialMouseScreenPos;
var gZoomInitialMouseWorldPos;
var gZoomInitialMouseView;

// Rendering
var gTilesOffscreenGraphics;
var gTileShader;
var gMapShader;
const gFOVy = (Math.PI/180.0)*60.0;

// Streaming state
var gNumTileImagesBeingLoaded = 0;

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
	loadOneByOne: false,
	showTileMiniMap: false,
	reliefDepth: 0.33,
	cameraPitchAngle: 0.54
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
	if (gDebugSettings.loadOneByOne && gNumTileImagesBeingLoaded > 0)
		return;

	var tilesToLoad = getTilesToLoad()

	for (var i=0; i<tilesToLoad.length; ++i)
	{
		var tile = tilesToLoad[i];

		// Do we have to load the albedo?
		if (tile.albedoImage.loadingState == ETileLoadingState.unloaded)
			tile.albedoImage.startLoading();

		// Do we have to load the elevation?
		if (tile.elevationImage.loadingState == ETileLoadingState.unloaded)
			tile.elevationImage.startLoading();

		if (gDebugSettings.loadOneByOne)
		 	break;
	}
}



function updateTileUnloading()
{
	// For now immediately unload all tiles that are not visible.
	visitTileChildren(gRootTile, tile => { 
		if (!tile.isVisible)
		{
			if (tile.albedoImage.loadingState == ETileLoadingState.loaded)
				tile.albedoImage.loadingState = ETileLoadingState.unloaded;

			if (tile.elevationImage.loadingState == ETileLoadingState.loaded)
				tile.elevationImage.loadingState = ETileLoadingState.unloaded;				
		}
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
		if (tile.lod >= desiredLod && tile.isVisible && (tile.albedoImage.loadingState == ETileLoadingState.unloaded || tile.elevationImage.loadingState == ETileLoadingState.unloaded))
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
		visitTileChildren(gRootTile, tile => { 
			tile.albedoImage.loadingState = ETileLoadingState.unloaded; 
			tile.elevationImage.loadingState = ETileLoadingState.unloaded;
		});

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


function preload()
{
	gOptionsButtonOn = loadImage("sketches/939b106b/options_on.png");
	gOptionsButtonOff = loadImage("sketches/939b106b/options_off.png");

	gTileShader = loadShader('sketches/939b106b/tile.vert', 'sketches/939b106b/tile.frag');
	gMapShader = loadShader('sketches/939b106b/map.vert', 'sketches/939b106b/map.frag');
}


function setup() 
{
	var cnv = createCanvas(window.innerWidth, window.innerHeight, WEBGL);
	cnv.position(0, 0);	
	cnv.style('position', 'absolute');

	gTilesOffscreenGraphics = createGraphics(window.innerWidth, window.innerHeight, WEBGL);

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
	folderStreaming.addInput(gDebugSettings, 'showTileMiniMap', {label: "Show mini map"});

	var folderRender = gTweakPane.addFolder({ title: 'Rendering' });
	folderRender.addInput(gDebugSettings, 'reliefDepth', {label: "Relief depth", min:0, max:0.50});	
	folderRender.addInput(gDebugSettings, 'cameraPitchAngle', {label: "Camera angle", min:0.0, max:5.0});	
	
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


function getVisibleTiles(desiredLod, view)
{
	var desiredTileGrid = gTileGrids[desiredLod];
	var desiredTilesOnScreen = desiredTileGrid.getTilesInWorldRect(view.worldRect);

	var tiles = [];
	for (var i=0; i<desiredTilesOnScreen.length; ++i)
	{
		// if (!desiredTilesOnScreen[i].tile.valid)
		// 	continue;

		var albedoTile = desiredTilesOnScreen[i].tile;
		var elevationTile = desiredTilesOnScreen[i].tile;

		var albedoTileImageRect = new Rect(new Victor(0,0), new Victor(gMap.tileSize, gMap.tileSize));
		var elevationTileImageRect = albedoTileImageRect.clone();

		// // Find a parent tile image that is loaded
		// while (albedoTile.lod < gMap.numLods-1 && albedoTile.albedoImage.loadingState != ETileLoadingState.loaded)
		// {		
		// 	// Recalculate our image rect
		// 	var newImageRectSize = albedoTileImageRect.size.clone().divide(new Victor(2,2));
		// 	var newImageRectOffset = albedoTileImageRect.min.clone().divide(new Victor(2,2)).add(albedoTile.childIndex.clone().multiply(new Victor(gMap.tileSize/2, gMap.tileSize/2)));
		// 	albedoTileImageRect = new Rect(newImageRectOffset, newImageRectOffset.clone().add(newImageRectSize));

		// 	albedoTile = albedoTile.parent;			
		// }

		// // Find a parent tile image that is loaded
		// while (elevationTile.lod < gMap.numLods-1 && elevationTile.elevationImage.loadingState != ETileLoadingState.loaded)
		// {		
		// 	// Recalculate our image rect
		// 	var newImageRectSize = elevationTileImageRect.size.clone().divide(new Victor(2,2));
		// 	var newImageRectOffset = elevationTileImageRect.min.clone().divide(new Victor(2,2)).add(elevationTile.childIndex.clone().multiply(new Victor(gMap.tileSize/2, gMap.tileSize/2)));
		// 	elevationTileImageRect = new Rect(newImageRectOffset, newImageRectOffset.clone().add(newImageRectSize));

		// 	elevationTile = elevationTile.parent;			
		// }

		tiles.push({ 
			screenTile: desiredTilesOnScreen[i].tile, 
			sourceAlbedoTile: albedoTile, 
			sourceAlbedoTileRect: albedoTileImageRect,
			sourceElevationTile: elevationTile,
			sourceElevationTileRect: elevationTileImageRect
		 });
	}

	// Link the neighbour tiles
	for (var i=0; i<tiles.length; ++i)
	{		
		var neighbourIndices = desiredTilesOnScreen[i].neighbours;
		tiles[i].neighbour00 = (neighbourIndices[0] >= 0) ? tiles[neighbourIndices[0]] : null;
		tiles[i].neighbour01 = (neighbourIndices[1] >= 0) ? tiles[neighbourIndices[1]] : null;
		tiles[i].neighbour02 = (neighbourIndices[2] >= 0) ? tiles[neighbourIndices[2]] : null;
		tiles[i].neighbour10 = (neighbourIndices[3] >= 0) ? tiles[neighbourIndices[3]] : null;
		// tiles[i].neighbour11 = (neighbourIndices[4] >= 0) ? tiles[neighbourIndices[4]] : null;
		tiles[i].neighbour12 = (neighbourIndices[5] >= 0) ? tiles[neighbourIndices[5]] : null;
		tiles[i].neighbour20 = (neighbourIndices[6] >= 0) ? tiles[neighbourIndices[6]] : null;
		tiles[i].neighbour21 = (neighbourIndices[7] >= 0) ? tiles[neighbourIndices[7]] : null;
		tiles[i].neighbour22 = (neighbourIndices[8] >= 0) ? tiles[neighbourIndices[8]] : null;				
	}

	return tiles;
}


function drawTile(visibleTile, viewCenterWorldPos, worldRect, uvRect, sourceAlbedoTileRect, sourceElevationTileRect)
{
	var right = worldRect.min.x >= viewCenterWorldPos.x;
	var top = worldRect.min.y < viewCenterWorldPos.y;

	var neighbour01 = right ? visibleTile.neighbour12 : visibleTile.neighbour10;
	var neighbour10 = top ? visibleTile.neighbour01 : visibleTile.neighbour21;
	var neighbour11 = right ? (top ? visibleTile.neighbour02 : visibleTile.neighbour22) : (top ? visibleTile.neighbour00 : visibleTile.neighbour20);

	gTileShader.setUniform('uReliefDepth', gDebugSettings.reliefDepth);

	gTileShader.setUniform('uAlbedoTexture00', visibleTile.sourceAlbedoTile.albedoImage.image);
	gTileShader.setUniform('uAlbedoTexture01', neighbour01 != null && neighbour01.screenTile.valid && neighbour01.sourceAlbedoTile.albedoImage.loadingState == ETileLoadingState.loaded ? neighbour01.sourceAlbedoTile.albedoImage.image : visibleTile.sourceAlbedoTile.albedoImage.image);
	gTileShader.setUniform('uAlbedoTexture10', neighbour10 != null && neighbour10.screenTile.valid && neighbour10.sourceAlbedoTile.albedoImage.loadingState == ETileLoadingState.loaded ? neighbour10.sourceAlbedoTile.albedoImage.image : visibleTile.sourceAlbedoTile.albedoImage.image);
	gTileShader.setUniform('uAlbedoTexture11', neighbour11 != null && neighbour11.screenTile.valid && neighbour11.sourceAlbedoTile.albedoImage.loadingState == ETileLoadingState.loaded ? neighbour11.sourceAlbedoTile.albedoImage.image : visibleTile.sourceAlbedoTile.albedoImage.image);
	gTileShader.setUniform('uElevationTexture00', visibleTile.sourceElevationTile.elevationImage.image);
	gTileShader.setUniform('uElevationTexture01', neighbour01 != null && neighbour01.screenTile.valid && neighbour01.sourceElevationTile.elevationImage.loadingState == ETileLoadingState.loaded ? neighbour01.sourceElevationTile.elevationImage.image : visibleTile.sourceElevationTile.elevationImage.image);
	gTileShader.setUniform('uElevationTexture10', neighbour10 != null && neighbour10.screenTile.valid && neighbour10.sourceElevationTile.elevationImage.loadingState == ETileLoadingState.loaded ? neighbour10.sourceElevationTile.elevationImage.image : visibleTile.sourceElevationTile.elevationImage.image);
	gTileShader.setUniform('uElevationTexture11', neighbour11 != null && neighbour11.screenTile.valid && neighbour11.sourceElevationTile.elevationImage.loadingState == ETileLoadingState.loaded ? neighbour11.sourceElevationTile.elevationImage.image : visibleTile.sourceElevationTile.elevationImage.image);

	gTileShader.setUniform('uUVTopLeft', [uvRect.min.x, uvRect.min.y]);
	gTileShader.setUniform('uUVBottomRight', [uvRect.max.x, uvRect.max.y]);
	gTileShader.setUniform('uAlbedoTextureTopLeft', [sourceAlbedoTileRect.min.x / gMap.tileSize, sourceAlbedoTileRect.min.y / gMap.tileSize]);
	gTileShader.setUniform('uAlbedoTextureSize', [sourceAlbedoTileRect.size.x / gMap.tileSize, sourceAlbedoTileRect.size.y / gMap.tileSize]);
	gTileShader.setUniform('uElevationTextureTopLeft', [sourceElevationTileRect.min.x / gMap.tileSize, sourceElevationTileRect.min.y / gMap.tileSize]);
	gTileShader.setUniform('uElevationTextureSize', [sourceElevationTileRect.size.x / gMap.tileSize, sourceElevationTileRect.size.y / gMap.tileSize]);

	// Draw our tile
	push();
	translate(worldRect.center.x, worldRect.center.y);
	plane(worldRect.size.x, worldRect.size.y);
	pop();
}


function draw() 
{
	preDraw();

	if (gRenderDimensionsChanged)
	{
		gTilesOffscreenGraphics.width = gRenderWidth;
		gTilesOffscreenGraphics.height = gRenderHeight;
	}

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
		gCurrentZoomAmount += (gDesiredZoomAmount - gCurrentZoomAmount)*0.2; 

		// Adjust scale
		gView.worldScale = gZoomInitialMouseView.worldScale * gCurrentZoomAmount;

		// Force limits before adjusting center, to assure we're not applying more or less scale than possible
		gView.applyViewLimits();

		// Adjust world center (to take scaling pivot into account)
		var screenScalePivotOffset = gZoomInitialMouseScreenPos.clone().subtract(gZoomInitialMouseView.screenRect.center).multiply(new Victor(gView.worldScale, gView.worldScale));
		var scalePivotOffset = gZoomInitialMouseWorldPos.clone().subtract(gZoomInitialMouseView.worldCenter).subtract(screenScalePivotOffset);

		gView.worldCenter = gZoomInitialMouseView.worldCenter.clone().add(scalePivotOffset);

		if (Math.abs(gCurrentZoomAmount - gDesiredZoomAmount) <= 0.01)		
			gIsZooming = false;
	}

	gView.applyViewLimits();	

	clear();

	visitTileChildren(gRootTile, tile => {tile.isVisible = false;});

	var desiredLod = calcDesiredLod();
	var visibleTiles = getVisibleTiles(desiredLod, gView);

	noStroke();
	shader(gTileShader);
	perspective(gFOVy, gRenderWidth/gRenderHeight, 0.01, 100.0);

	cameraZ = (0.5*gView.screenRect.size.y*gView.worldScale) / Math.tan(0.5*gFOVy);

	// Rotate camera in 2D (ZY space) around bottom of world
	var cameraPos = new Victor(cameraZ, gView.worldCenter.y);
	var cameraFwd = new Victor(-1.0, 0.0);
	var planeBottomCenterPos = new Victor(0.0, gView.worldCenter.y + gView.worldRect.size.y/2.0);
	var pitchAngle = gDebugSettings.cameraPitchAngle;
	var cameraOffset = cameraPos.clone().subtract(planeBottomCenterPos).rotate(pitchAngle);
	cameraFwd.rotate(pitchAngle);

	cameraPos = planeBottomCenterPos.clone().add(cameraOffset);
	var targetPos = cameraPos.clone().add(cameraFwd);

	camera(
		gView.worldCenter.x, cameraPos.y, cameraPos.x,
		gView.worldCenter.x, targetPos.y, targetPos.x,
		0,-cameraFwd.x,cameraFwd.y);

	var cam = this._renderer._curCamera;
	var mvp = cam.cameraMatrix.copy().mult(cam.projMatrix);
	var frustum = new Frustum2D(mvp.mat4);

	// Calculate the position in the world that we're actually looking at
	var amount = cameraPos.x / cameraFwd.x;
	var viewCenterWorldPos = cameraPos.clone().add(cameraFwd.multiply(new Victor(amount, amount)));
	viewCenterWorldPos = new Victor(gView.worldCenter.x, viewCenterWorldPos.y, viewCenterWorldPos.x);

	// Render all tiles within the quadrant
	for (var i=0; i<visibleTiles.length; ++i)
	{	
		var visibleTile = visibleTiles[i];

		if (!visibleTile.screenTile.valid)
			continue;

		// Mark this tile as being visible, uncluding all its parents
		visitTileParents(visibleTile.screenTile, tile => {tile.isVisible = true;});

		if (visibleTile.sourceAlbedoTile.albedoImage.loadingState != ETileLoadingState.loaded ||
			visibleTile.sourceElevationTile.elevationImage.loadingState != ETileLoadingState.loaded)
			continue;

		var uv_rect = new Rect(new Victor(0.0, 0.0), new Victor(1.0, 1.0));

		var screenTileInfo = [
			{ 
				worldRect: visibleTile.screenTile.worldRect.clone(), 
				uvRect: uv_rect.clone(),
				sourceAlbedoTileRect: visibleTile.sourceAlbedoTileRect.clone(),
				sourceElevationTileRect: visibleTile.sourceElevationTileRect.clone()
			}
		];

		// Split horizontally?
		if (screenTileInfo[0].worldRect.min.x < viewCenterWorldPos.x && screenTileInfo[0].worldRect.max.x > viewCenterWorldPos.x)
		{
			var splitFraction = screenTileInfo[0].worldRect.getFractionX(viewCenterWorldPos.x);
			var rightTileInfo = {
				worldRect: screenTileInfo[0].worldRect.splitXAtFraction(splitFraction),
				uvRect: screenTileInfo[0].uvRect.splitXAtFraction(splitFraction),
				sourceAlbedoTileRect: screenTileInfo[0].sourceAlbedoTileRect.splitXAtFraction(splitFraction),
				sourceElevationTileRect: screenTileInfo[0].sourceElevationTileRect.splitXAtFraction(splitFraction)
			};
			screenTileInfo.push(rightTileInfo);
		}

		// Split vertically?
		var numScreenTiles = screenTileInfo.length;
		for (var j=0; j<numScreenTiles; ++j)
		{
			if (screenTileInfo[j].worldRect.min.y < viewCenterWorldPos.y && screenTileInfo[j].worldRect.max.y > viewCenterWorldPos.y)
			{
				var splitFraction = screenTileInfo[j].worldRect.getFractionY(viewCenterWorldPos.y);
				var bottomTileInfo = {
					worldRect: screenTileInfo[j].worldRect.splitYAtFraction(splitFraction),
					uvRect: screenTileInfo[j].uvRect.splitYAtFraction(splitFraction),
					sourceAlbedoTileRect: screenTileInfo[j].sourceAlbedoTileRect.splitYAtFraction(splitFraction),
					sourceElevationTileRect: screenTileInfo[j].sourceElevationTileRect.splitYAtFraction(splitFraction)
				};
				screenTileInfo.push(bottomTileInfo);
			}
		}

		for (var j=0; j<screenTileInfo.length; ++j)
			drawTile(visibleTile, viewCenterWorldPos, screenTileInfo[j].worldRect, screenTileInfo[j].uvRect, screenTileInfo[j].sourceAlbedoTileRect, screenTileInfo[j].sourceElevationTileRect);
	}

	updateTileLoading();	
	updateTileUnloading();

	// Gather debug info
	var numTilesLoaded = 0;
	visitTileChildren(gRootTile, tile => { if (tile.albedoImage.loadingState == ETileLoadingState.loaded) numTilesLoaded++;});
	
	gDebugInfo.desiredLod = desiredLod;
	gDebugInfo.numTilesVisible = visibleTiles.length;
	gDebugInfo.numTilesLoaded = numTilesLoaded;
	gDebugInfo.numTilesLoading = gNumTileImagesBeingLoaded;

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
	// Draw mini map
	// if (gDebugSettings.showTileMiniMap)
	// 	drawTileMiniMap();

	// Draw toggle button
	var buttonPos = new Victor(gRenderWidth - 30, 86);
	var buttonSize = 30.0;
	var on = (getMousePos().distance(buttonPos) <= buttonSize);

	var desiredAngle = gTweakPane.hidden ? 0 : PI;
	gOptionsButtonAngle = gOptionsButtonAngle + (desiredAngle - gOptionsButtonAngle)*0.2;

	var worldButtonPos = gView.screenToWorldPos(buttonPos);
	var worldButtonSize = gView.screenToWorldScale(buttonSize);
	resetShader();
	push();
	translate(0.5*buttonPos.x - buttonSize*0.5,0.5*(-gRenderHeight+buttonPos.y)+buttonSize*1.5,0.0);
	rotateZ(gOptionsButtonAngle);
	texture(on ? gOptionsButtonOn : gOptionsButtonOff);
	plane(buttonSize, buttonSize);
	pop();

	if (!drawUImouseWasPressed && mouseIsPressed && on)
		gTweakPane.hidden = !gTweakPane.hidden;

	drawUImouseWasPressed = mouseIsPressed;
}

function drawTileMiniMap()
{
	const tileScreenSize = 6;
	const size = gRootTile.worldRect.size;
	const w = size.x*tileScreenSize;
	const h = size.y*tileScreenSize;

	var topLeft = new Victor(gRenderWidth - w - 8, gRenderHeight - h - 8);

	var tileScale = new Victor(tileScreenSize, tileScreenSize);

	// Back
	// strokeWeight(1.0);
	// stroke(255,255,255, 255);
	// //fill(0,0,0, 255);
	// rect(topLeft.x-1, topLeft.y-1, w+2, h+2);

	// Draw tiles
	noStroke();

	visitTileChildren(gRootTile, tile => {
		if (!tile.valid)
			return;
		if (tile.albedoImage.loadingState == ETileLoadingState.unloaded)
			return;

		var intensity = 255 - 255*tile.lod/gMap.numLods;

		if (tile.albedoImage.loadingState == ETileLoadingState.loading)
			fill(intensity, 0, 0, 255);
		else
			fill(0, intensity, 0, 255);

		var tl = topLeft.clone().add(tile.worldRect.min.clone().multiply(tileScale));
		var size = tile.worldRect.size.clone().multiply(tileScale);

		rect(tl.x, tl.y, size.x, size.y);
	});

	// Draw screen
	var viewWorldRect = gView.worldRect;
	var viewRectTL = topLeft.clone().add(viewWorldRect.min.clone().multiply(tileScale));
	var viewSize = viewWorldRect.size.clone().multiply(tileScale);
	noFill();
	stroke(0,0,0, 192);
	rect(viewRectTL.x, viewRectTL.y, viewSize.x, viewSize.y);
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
	if (!gIsPanning && !gIsZooming)
	{
		var maxZoomAmount = 0.75;
		var zoom_delta = Math.max(-maxZoomAmount, Math.min(maxZoomAmount, -event.delta / 200.0));

		gCurrentZoomAmount = 1;		
		gDesiredZoomAmount = pow(2, -zoom_delta);

		gZoomInitialMouseView = gView.clone();
		gZoomInitialMouseScreenPos = getMousePos();
		gZoomInitialMouseWorldPos = gView.screenToWorldPos(gZoomInitialMouseScreenPos);
		
		gIsZooming = true;		
	}

	return false;
  }