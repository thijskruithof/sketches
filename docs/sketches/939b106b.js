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


/**
 * An edge of the frustum in 2D, in the world XY plane
 */
class FrustumEdge2D
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
		this.edgeDir = new Victor(frustumPlaneB, -frustumPlaneA);
		this.edgeDir.normalize();

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
			this.edgePos = new Victor(0.0, -frustumPlaneD*((frustumPlaneA*frustumPlaneA + frustumPlaneC*frustumPlaneC)/frustumPlaneB + frustumPlaneB));
		else
			this.edgePos = new Victor(-frustumPlaneD*((frustumPlaneB*frustumPlaneB + frustumPlaneC*frustumPlaneC)/frustumPlaneA + frustumPlaneA), 0.0);

		// Plane normal points to the inside of the 2D frustum area
		this.planeNormal = new Victor(-this.edgeDir.y, this.edgeDir.x);			
		this.planePos = this.edgePos.clone();
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

		if (Math.abs(this.edgeDir.x) > Math.abs(this.edgeDir.y))
			v = ((otherPlane.edgePos.y - this.edgePos.y) - (this.edgeDir.y/this.edgeDir.x)*(otherPlane.edgePos.x - this.edgePos.x)) /
				(this.edgeDir.y*(otherPlane.edgeDir.x/this.edgeDir.x) - otherPlane.edgeDir.y);
		else
			v = ((otherPlane.edgePos.x - this.edgePos.x) - (this.edgeDir.x/this.edgeDir.y)*(otherPlane.edgePos.y - this.edgePos.y)) /
				(this.edgeDir.x*(otherPlane.edgeDir.y/this.edgeDir.y) - otherPlane.edgeDir.x);

		return otherPlane.edgeDir.clone().multiply(new Victor(v,v)).add(otherPlane.edgePos);
	}

	isOnBackSide(pos)
	{
		return pos.clone().subtract(this.planePos).dot(this.planeNormal) < 0.0;
	}

	
	isCompletelyOnBackSide(rect)
	{
		// Check the rect's 4 corners
		return this.isOnBackSide(rect.min) &&
			this.isOnBackSide(rect.max) &&
			this.isOnBackSide(new Victor(rect.max.x, rect.min.y)) &&
			this.isOnBackSide(new Victor(rect.min.x, rect.max.y));
	}
}


class Frustum2D
{
	constructor(mvpMatrix)
	{
		// Based on http://www.cs.otago.ac.nz/postgrads/alexis/planeExtraction.pdf

		this.edgeLeft = new FrustumEdge2D( 
	 		mvpMatrix[3] + mvpMatrix[0],
	 		mvpMatrix[7] + mvpMatrix[4],
	 		mvpMatrix[11] + mvpMatrix[8],
	 		mvpMatrix[15] + mvpMatrix[12]
	 	);

		this.edgeRight = new FrustumEdge2D( 
	 		mvpMatrix[3]  - mvpMatrix[0],
	 		mvpMatrix[7]  - mvpMatrix[4],
	 		mvpMatrix[11] - mvpMatrix[8],
	 		mvpMatrix[15] - mvpMatrix[12]
	 	);

	 	this.edgeTop = new FrustumEdge2D( 
	 		mvpMatrix[3]  - mvpMatrix[1],
	 		mvpMatrix[7]  - mvpMatrix[5],
	 		mvpMatrix[11] - mvpMatrix[9],
	 		mvpMatrix[15] - mvpMatrix[13]
	 	);
	 	
	 	this.edgeBottom = new FrustumEdge2D( 
	 		mvpMatrix[3]  + mvpMatrix[1],
	 		mvpMatrix[7]  + mvpMatrix[5],
	 		mvpMatrix[11] + mvpMatrix[9],
	 		mvpMatrix[15] + mvpMatrix[13]
	 	);

	 	// Calculate corners of 2D frustum (in 2D)
	 	this.posTopLeft = this.edgeLeft.intersect(this.edgeTop);
	 	this.posBottomLeft = this.edgeLeft.intersect(this.edgeBottom);
	 	this.posTopRight = this.edgeRight.intersect(this.edgeTop);
		this.posBottomRight = this.edgeRight.intersect(this.edgeBottom);		
		 
		// Calculate axis-aligned bounds rect in world space
		// note: we assume here that our camera only contains pitch, so the frustum is always horizontal.
		this.worldBoundsRect = new Rect(
			new Victor(Math.min(this.posTopLeft.x,this.posBottomLeft.x), this.posTopLeft.y),
			new Victor(Math.max(this.posTopRight.x,this.posBottomRight.x), this.posBottomRight.y)
		);
	} 

	// Check if this 2D frustum overlaps with the given worldrect
	overlaps(worldRect)
	{		
		// note: we assume here that our camera only contains pitch, so the frustum is always horizontal.
		return worldRect.max.y >= this.posTopLeft.y &&
			worldRect.min.y <= this.posBottomRight.y &&
			!this.edgeLeft.isCompletelyOnBackSide(worldRect) &&
			!this.edgeRight.isCompletelyOnBackSide(worldRect);
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

		// 3x3 neighbours
		this.neighbours = [null,null,null,null,null,null,null,null,null];
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

	linkNeighbours()
	{
		for (var y=0; y<this.numTilesPerAxis; ++y)
		{
			for (var x=0; x<this.numTilesPerAxis; ++x)
			{
				var tile = this.tiles[y*this.numTilesPerAxis + x];

				for (var iy=-1; iy<=1; ++iy)
				{
					var iiy = y+iy;
					if (iiy < 0 || iiy >= this.numTilesPerAxis)
						continue;

					for (var ix=-1; ix<=1; ++ix)
					{
						var iix = x+ix;
						if (iix < 0 || iix >= this.numTilesPerAxis)
							continue;

						if (this.tiles[iiy*this.numTilesPerAxis + iix].valid)
							tile.neighbours[(iy+1)*3+(ix+1)] = this.tiles[iiy*this.numTilesPerAxis + iix];
					}
				}
			}
		}

	}

	getTilesInFrustum(frustum)
	{
		var worldBoundsRect = frustum.worldBoundsRect;

		var tileSize = pow(2, this.lod);
		var tl = new Victor(Math.floor(worldBoundsRect.min.x/tileSize), Math.floor(worldBoundsRect.min.y/tileSize));
		var br = new Victor(Math.floor(worldBoundsRect.max.x/tileSize), Math.floor(worldBoundsRect.max.y/tileSize));

		// Clamp window to valid range
		tl.x = Math.min(this.numTilesPerAxis-1, Math.max(0, tl.x));
		tl.y = Math.min(this.numTilesPerAxis-1, Math.max(0, tl.y));
		br.x = Math.min(this.numTilesPerAxis-1, Math.max(0, br.x));
		br.y = Math.min(this.numTilesPerAxis-1, Math.max(0, br.y));		

		var numCellsY = (br.y - tl.y)+1;
		var numCellsX = (br.x - tl.x)+1;

		// Gather all tiles that overlap our frustum
		var result = [];
		for (var y=tl.y; y<=br.y; ++y)
		{
			for (var x=tl.x; x<=br.x; ++x)
			{
				var t = this.tiles[y*this.numTilesPerAxis+x];

				if (frustum.overlaps(t.worldRect))
					result.push(t);
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
var gNullTileAlbedoImage;
var gNullTileElevationImage;
var gNullTileRect;

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
	reliefDepth: 0.48,
	cameraPitchAngle: 0.71
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

	// Create neighbours
	for (var lod=0; lod<gTileGrids.length; lod++)
		gTileGrids[lod].linkNeighbours();
}


function preload()
{
	gOptionsButtonOn = loadImage("sketches/939b106b/options_on.png");
	gOptionsButtonOff = loadImage("sketches/939b106b/options_off.png");
	
	gNullTileAlbedoImage = loadImage("sketches/939b106b/nulltile.jpg");
	gNullTileElevationImage = loadImage("sketches/939b106b/nulltile_e.jpg");
	gNullTileRect = new Rect(new Victor(0.0, 0.0), new Victor(1.0, 1.0));

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
	folderRender.addInput(gDebugSettings, 'cameraPitchAngle', {label: "Camera angle", min:0.0, max:0.95});		
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



function getVisibleTiles(desiredLod, frustum)
{
	var desiredTileGrid = gTileGrids[desiredLod];
	return desiredTileGrid.getTilesInFrustum(frustum);
}



function getTileAlbedoImageAndTileRect(tile)
{
	// Start with the full size image rect
	var imageRect = new Rect(new Victor(0,0), new Victor(1.0, 1.0));

	// If our tile's image is not loaded find the first parent tile that has its image loaded.
	while (tile != null && tile.albedoImage.loadingState != ETileLoadingState.loaded)
	{		
		// Recalculate our image rect
		var newImageRectSize = imageRect.size.clone().divide(new Victor(2,2));
		var newImageRectOffset = imageRect.min.clone().divide(new Victor(2,2)).add(tile.childIndex.clone().multiply(new Victor(0.5, 0.5)));
		imageRect = new Rect(newImageRectOffset, newImageRectOffset.clone().add(newImageRectSize));

		tile = tile.parent;			
	}	

	if (tile != null && tile.albedoImage.loadingState == ETileLoadingState.loaded)
		return { image: tile.albedoImage.image, tileRect: imageRect };
	else
		return { image: gNullTileAlbedoImage, tileRect: gNullTileRect };
}



function getTileElevationImageAndTileRect(tile)
{
	// Start with the full size image rect
	var imageRect = new Rect(new Victor(0,0), new Victor(1.0, 1.0));

	// If our tile's image is not loaded find the first parent tile that has its image loaded.
	while (tile != null && tile.elevationImage.loadingState != ETileLoadingState.loaded)
	{		
		// Recalculate our image rect
		var newImageRectSize = imageRect.size.clone().divide(new Victor(2,2));
		var newImageRectOffset = imageRect.min.clone().divide(new Victor(2,2)).add(tile.childIndex.clone().multiply(new Victor(0.5, 0.5)));
		imageRect = new Rect(newImageRectOffset, newImageRectOffset.clone().add(newImageRectSize));

		tile = tile.parent;			
	}	

	if (tile != null && tile.elevationImage.loadingState == ETileLoadingState.loaded)
		return { image: tile.elevationImage.image, tileRect: imageRect };
	else
		return { image: gNullTileAlbedoImage, tileRect: gNullTileRect };
}



function setTileUniforms(suffix, tile)
{
	var albedo = getTileAlbedoImageAndTileRect(tile);
	var elevation = getTileElevationImageAndTileRect(tile);

	gTileShader.setUniform('uAlbedoTexture'+suffix, albedo.image);
	gTileShader.setUniform('uAlbedoTexture'+suffix+'TopLeft', [albedo.tileRect.min.x, albedo.tileRect.min.y]);
	gTileShader.setUniform('uAlbedoTexture'+suffix+'Size', [albedo.tileRect.size.x, albedo.tileRect.size.y]);

	gTileShader.setUniform('uElevationTexture'+suffix, elevation.image);
	gTileShader.setUniform('uElevationTexture'+suffix+'TopLeft', [elevation.tileRect.min.x, elevation.tileRect.min.y]);
	gTileShader.setUniform('uElevationTexture'+suffix+'Size', [elevation.tileRect.size.x, elevation.tileRect.size.y]);
}



function drawTileQuad(tile, cameraWorldPos, worldRect, uvRect)
{
	var right = worldRect.min.x >= cameraWorldPos.x;
	var top = worldRect.min.y < cameraWorldPos.y;

	var neighbour01 = right ? 5 : 3; 
	var neighbour10 = top ? 1 : 7; 
	var neighbour11 = right ? (top ? 2 : 8) : (top ? 0 : 6);

	var n01 = tile.neighbours[neighbour01];
	var n10 = tile.neighbours[neighbour10];
	var n11 = tile.neighbours[neighbour11];

	setTileUniforms('00', tile);
	setTileUniforms('01', tile.neighbours[neighbour01]);
	setTileUniforms('10', tile.neighbours[neighbour10]);
	setTileUniforms('11', tile.neighbours[neighbour11]);

	gTileShader.setUniform('uReliefDepth', gDebugSettings.reliefDepth);
	gTileShader.setUniform('uUVTopLeft', [uvRect.min.x, uvRect.min.y]);
	gTileShader.setUniform('uUVBottomRight', [uvRect.max.x, uvRect.max.y]);

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
	noStroke();
	shader(gTileShader);

	push();
	perspective(gFOVy, gRenderWidth/gRenderHeight, 0.01, 100.0);

	var cameraZ = (0.5*gView.screenRect.size.y*gView.worldScale) / Math.tan(0.5*gFOVy);

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

	visitTileChildren(gRootTile, tile => {tile.isVisible = false;});

	var desiredLod = calcDesiredLod();

	// Determine which tiles are in our frustum
	var visibleTiles = gTileGrids[desiredLod].getTilesInFrustum(frustum);

	// Calculate the position in the world that we're actually looking at
	var cameraWorldPos = new Victor(gView.worldCenter.x, cameraPos.y);

	// Render all tiles within the quadrant
	for (var i=0; i<visibleTiles.length; ++i)
	{	
		var visibleTile = visibleTiles[i];

		if (!visibleTile.valid)
			continue;

		// Mark this tile as being visible, uncluding all its parents
		visitTileParents(visibleTile, tile => {tile.isVisible = true;});

		// Determine the quads to draw for the tile
		var uv_rect = new Rect(new Victor(0.0, 0.0), new Victor(1.0, 1.0));

		var screenTileInfo = [
			{ 
				worldRect: visibleTile.worldRect.clone(), 
				uvRect: uv_rect.clone()
			}
		];

		// Split our quad horizontally?
		if (screenTileInfo[0].worldRect.min.x < cameraWorldPos.x && screenTileInfo[0].worldRect.max.x > cameraWorldPos.x)
		{
			var splitFraction = screenTileInfo[0].worldRect.getFractionX(cameraWorldPos.x);
			var rightTileInfo = {
				worldRect: screenTileInfo[0].worldRect.splitXAtFraction(splitFraction),
				uvRect: screenTileInfo[0].uvRect.splitXAtFraction(splitFraction)
			};
			screenTileInfo.push(rightTileInfo);
		}

		// Split our quad(s) vertically?
		var numScreenTiles = screenTileInfo.length;
		for (var j=0; j<numScreenTiles; ++j)
		{
			if (screenTileInfo[j].worldRect.min.y < cameraWorldPos.y && screenTileInfo[j].worldRect.max.y > cameraWorldPos.y)
			{
				var splitFraction = screenTileInfo[j].worldRect.getFractionY(cameraWorldPos.y);
				var bottomTileInfo = {
					worldRect: screenTileInfo[j].worldRect.splitYAtFraction(splitFraction),
					uvRect: screenTileInfo[j].uvRect.splitYAtFraction(splitFraction)
				};
				screenTileInfo.push(bottomTileInfo);
			}
		}
		
		for (var j=0; j<screenTileInfo.length; ++j)
			drawTileQuad(visibleTile, cameraWorldPos, screenTileInfo[j].worldRect, screenTileInfo[j].uvRect);
	}

	pop();

	updateTileLoading();	
	updateTileUnloading();

	// Gather debug info
	var numTilesLoaded = 0;
	visitTileChildren(gRootTile, tile => { if (tile.albedoImage.loadingState == ETileLoadingState.loaded) numTilesLoaded++;});
	
	gDebugInfo.desiredLod = desiredLod;
	gDebugInfo.numTilesVisible = visibleTiles.length;
	gDebugInfo.numTilesLoaded = numTilesLoaded;
	gDebugInfo.numTilesLoading = gNumTileImagesBeingLoaded;

	drawUI(frustum);

	postDraw();
}


function getMousePos()
{
	return new Victor(mouseX, mouseY);
}


var drawUImouseWasPressed = false;

function drawUI(frustum)
{
	resetShader();

	// Draw mini map
	if (gDebugSettings.showTileMiniMap)
	 	drawTileMiniMap(frustum);

	// Draw toggle button
	var buttonPos = new Victor(gRenderWidth - 30, 86);
	var buttonSize = 30.0;
	var on = (getMousePos().distance(buttonPos) <= buttonSize);

	var desiredAngle = gTweakPane.hidden ? 0 : PI;
	gOptionsButtonAngle = gOptionsButtonAngle + (desiredAngle - gOptionsButtonAngle)*0.2;

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

function drawTileMiniMap(frustum)
{
	const tileScreenSize = 6;
	const size = gRootTile.worldRect.size;
	const w = size.x*tileScreenSize;
	const h = size.y*tileScreenSize;

	var topLeft = new Victor(gRenderWidth - w - 8, gRenderHeight - h - 8);

	var tileScale = new Victor(tileScreenSize, tileScreenSize);

	// Draw tiles
	push();
	noStroke();

	translate(topLeft.x - gRenderWidth/2,topLeft.y - gRenderHeight/2);

	visitTileChildren(gRootTile, tile => {
		if (!tile.valid)
			return;
		if (tile.albedoImage.loadingState == ETileLoadingState.unloaded)
			return;

		var intensity = 255 - 255*tile.lod/gMap.numLods;

		if (tile.albedoImage.loadingState == ETileLoadingState.loading)
			emissiveMaterial(intensity, 0, 0);
		else
			emissiveMaterial(0, intensity, 0);

		var center = tile.worldRect.center.clone().multiply(tileScale);
		var size = tile.worldRect.size.clone().multiply(tileScale);
		translate(center.x, center.y, 0.0);
		plane(size.x, size.y);
		translate(-center.x, -center.y, 0.0);
	});

	// Draw frustum
	var viewWorldRect = gView.worldRect;
	var viewRectTL = viewWorldRect.min.clone().multiply(tileScale);
	var viewSize = viewWorldRect.size.clone().multiply(tileScale);
	noFill();
	stroke(0,0,0, 192);
	quad(
		frustum.posTopLeft.x * tileScreenSize, frustum.posTopLeft.y * tileScreenSize,
		frustum.posTopRight.x * tileScreenSize, frustum.posTopRight.y * tileScreenSize,
		frustum.posBottomRight.x * tileScreenSize, frustum.posBottomRight.y * tileScreenSize,
		frustum.posBottomLeft.x * tileScreenSize, frustum.posBottomLeft.y * tileScreenSize);

	pop();
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