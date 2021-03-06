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
		this.worldBottomCenter = new Victor(0, 0);	//< Which position (in world coords) is shown in the center at the bottom of the screen
		this.worldScale = 1.0; 						//< Size in world units of 1 pixel on screen (at the bottom of the screen)
	}

	clone()
	{
		var newView = new View(this.screenRect);
		newView.worldScale = this.worldScale;
		newView.worldBottomCenter = this.worldBottomCenter.clone();
		newView.cameraPos = this.cameraPos.clone();
		newView.cameraPosZ = this.cameraPosZ;
		newView.cameraTargetPos = this.cameraTargetPos.clone();
		newView.cameraTargetPosZ = this.cameraTargetPosZ;
		newView.cameraUp = this.cameraUp.clone();
		newView.cameraUpZ = this.cameraUpZ;
		newView.viewProjMatrix = this.viewProjMatrix;
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
		this.worldBottomCenter = new Victor((worldRect.min.x + worldRect.max.x)*0.5, worldRect.max.y);

		this.applyViewLimits();
	}

	worldToScreenPos(pos)
	{	
		var M = this.viewProjMatrix;

		// Simple multiplication of (pos.x, pos.y, 0.0) with M,
		// including projection by dividing by w.
		var w = M[3] * pos.x + M[7] * pos.y + M[15];

		var ndcPos = new Victor(
			(M[0] * pos.x + M[4] * pos.y + M[12]) / w,
			(M[1] * pos.x + M[5] * pos.y + M[13]) / w,
		)

		return new Victor(
			(0.5 + ndcPos.x * 0.5) * this.screenRect.size.x,
			(0.5 - ndcPos.y * 0.5) * this.screenRect.size.y
		);
	}


	worldToScreenRect(rect)
	{
		return new Rect(this.worldToScreenPos(rect.min), this.worldToScreenPos(rect.max));
	}

	screenToWorldPos(pos)
	{
		var ndcPos = new Victor( 
			2.0*(pos.x / this.screenRect.size.x) - 1.0,		// -1..+1
			-2.0*(pos.y / this.screenRect.size.y) + 1.0		// +1..-1
		);

		// Manually solved inverse transformation:

		// If ndcPos = M * v  (M = MVP matrix and v is position in world space)
		// Then:
		// v = M^-1 * ndcPos
		//
		// Because we know that v.z = 0 we can directly solve this transformation.	

		var M = this.viewProjMatrix;

		var dk = ndcPos.x*M[3] - M[0];
		var k0 = (M[4] - ndcPos.x*M[7]) / dk;
		var k1 = (M[12] - ndcPos.x*M[15]) / dk;

		var ndiv = ndcPos.y*M[7] - M[5];
		var n0 = (M[1] - ndcPos.y*M[3]) / ndiv;
		var n1 = (M[13] - ndcPos.y*M[15]) / ndiv;

		var y = (n0*k1 + n1) / (1.0 - n0*k0);
		var x = k0*y + k1;

		return new Victor(x, y, 0.0);
	}

	screenToWorldRect(rect)
	{
		return new Rect(this.screenToWorldPos(rect.min), this.screenToWorldPos(rect.max));
	}

	applyViewLimits()
	{		
		// Limit scale
		var minScale = 1.0/gMap.tileSize;
		var maxScale = Math.min(
			gMap.numTilesXLod0 / this.screenRect.size.x, 
			Math.cos(gDebugSettings.cameraPitchAngle + 0.5*this.FOVy)*(Math.sin(0.5*this.FOVy)/Math.sin(this.FOVy))*(2.0*gMap.numTilesYLod0 / this.screenRect.size.y)
		);
		this.worldScale = Math.min(Math.max(this.worldScale, minScale), maxScale);

		this.updateCamera();

		// Calculate current world space positions of the screen
		var worldBottomLeft = this.screenToWorldPos(new Victor(0.0, this.screenRect.max.y));
		var worldBottomRight = this.screenToWorldPos(this.screenRect.max);
		var worldTopCenter = this.screenToWorldPos(new Victor(this.screenRect.center.x, 0.0));
		
		// Limit left and right
		if (worldBottomLeft.x < 0.0)
		{
			this.worldBottomCenter.x -= worldBottomLeft.x;
			worldBottomRight.x -= worldBottomLeft.x;
		}
		if (worldBottomRight.x > gMap.numTilesXLod0)
			this.worldBottomCenter.x -= worldBottomRight.x - gMap.numTilesXLod0;
		
		// Limit top and bottom
		if (worldTopCenter.y < 0.0)
		{
			this.worldBottomCenter.y -= worldTopCenter.y;
			worldBottomRight.y -= worldTopCenter.y;
		}
		if (worldBottomRight.y > gMap.numTilesYLod0)
			this.worldBottomCenter.y -= worldBottomRight.y - gMap.numTilesYLod0;

		this.updateCamera();
	}

	get FOVy()
	{
		return (Math.PI/180.0)*gDebugSettings.cameraFOV;
	}

	get near()
	{
		return 0.01;
	}

	get far()
	{
		return 100.0;
	}

	get aspect()
	{
		return this.screenRect.size.x / this.screenRect.size.y;
	}

	updateCamera()
	{
		// Calculate Z of the camera 
		var halfScreenWorldHeight = 0.5*this.screenRect.size.y*this.worldScale;
		var cameraZ = halfScreenWorldHeight / Math.tan(0.5*this.FOVy);

		// Rotate camera in 2D (ZY space) around bottom of world
		var cameraPosZY = new Victor(cameraZ, this.worldBottomCenter.y - halfScreenWorldHeight);
		var cameraFwdZY = new Victor(-1.0, 0.0);
		var planeBottomCenterPosZY = new Victor(0.0, this.worldBottomCenter.y);
		var pitchAngle = gDebugSettings.cameraPitchAngle;
		var cameraOffsetZY = cameraPosZY.clone().subtract(planeBottomCenterPosZY).rotate(pitchAngle);
		cameraFwdZY.rotate(pitchAngle);
	
		// Calculate new camera position
		cameraPosZY = planeBottomCenterPosZY.clone().add(cameraOffsetZY);

		// Store camera position
		this.cameraPos = new Victor(this.worldBottomCenter.x, cameraPosZY.y);
		this.cameraPosZ = cameraPosZY.x;

		// Calculate position that we're looking at
		var targetPosZY = cameraPosZY.clone().add(cameraFwdZY);
	
		// Store target position
		this.cameraTargetPos = new Victor(this.worldBottomCenter.x, targetPosZY.y);
		this.cameraTargetPosZ = targetPosZY.x;
		
		// Store up axis of the camera
		this.cameraUp = new Victor(0.0, -cameraFwdZY.x);
		this.cameraUpZ = cameraFwdZY.y;

		// Calculate projection matrix		
		var projMatrix = this._getProjectionMatrix();

		// Calculate view matrix
		var viewMatrix = this._getViewMatrix();

		// Calculate view * proj
		this.viewProjMatrix = this._multMatrix(viewMatrix, projMatrix);

		this.frustum = new Frustum2D(this.viewProjMatrix);
	}

	/**
	 * Get our projection matrix
	 * Based on p5js's implementation of perspective
	 */
	_getProjectionMatrix()
	{
		// Calculate projection matrix		
		var f = 1.0 / Math.tan(this.FOVy / 2);
		var nf = 1.0 / (this.near - this.far);

		return [
			f / this.aspect, 0, 0, 0,
			0, -f, 0, 0,
			0, 0, (this.far + this.near) * nf, -1,
			0, 0, 2 * this.far * this.near * nf, 0
		];	
	}

	/**
	 * Get our view matrix 
	 * Based on p5js's implementation of camera and Camera._getLocalAxes
	 */
	_getViewMatrix()
	{
		// calculate camera local Z vector
		var z0 = this.cameraPos.x - this.cameraTargetPos.x;
		var z1 = this.cameraPos.y - this.cameraTargetPos.y;
		var z2 = this.cameraPosZ - this.cameraTargetPosZ;

		// normalize camera local Z vector
		var eyeDist = Math.sqrt(z0 * z0 + z1 * z1 + z2 * z2);
		if (eyeDist !== 0) 
		{
			z0 /= eyeDist;
			z1 /= eyeDist;
			z2 /= eyeDist;
		}

		// calculate camera Y vector
		var y0 = this.cameraUp.x;
		var y1 = this.cameraUp.y;
		var y2 = this.cameraUpZ;

		// compute camera local X vector as up vector (local Y) cross local Z
		var x0 = y1 * z2 - y2 * z1;
		var x1 = -y0 * z2 + y2 * z0;
		var x2 = y0 * z1 - y1 * z0;

		// recompute y = z cross x
		y0 = z1 * x2 - z2 * x1;
		y1 = -z0 * x2 + z2 * x0;
		y2 = z0 * x1 - z1 * x0;

		// cross product gives area of parallelogram, which is < 1.0 for
		// non-perpendicular unit-length vectors; so normalize x, y here:
		var xmag = Math.sqrt(x0 * x0 + x1 * x1 + x2 * x2);
		if (xmag !== 0) 
		{
			x0 /= xmag;
			x1 /= xmag;
			x2 /= xmag;
		}

		var ymag = Math.sqrt(y0 * y0 + y1 * y1 + y2 * y2);
		if (ymag !== 0) 
		{
			y0 /= ymag;
			y1 /= ymag;
			y2 /= ymag;
		}

		var localAxes = {
			x: [x0, x1, x2],
			y: [y0, y1, y2],
			z: [z0, z1, z2]
		};

		// Calculate orientation matrix
		var mat4 = [
			localAxes.x[0], localAxes.y[0], localAxes.z[0], 0,
			localAxes.x[1], localAxes.y[1], localAxes.z[1], 0,
			localAxes.x[2], localAxes.y[2], localAxes.z[2], 0,
			0, 0, 0, 1
		];

		// Add inverse camera position
		var tx = -this.cameraPos.x;
		var ty = -this.cameraPos.y;
		var tz = -this.cameraPosZ;

		mat4[12] += mat4[0] * tx + mat4[4] * ty + mat4[8] * tz;
		mat4[13] += mat4[1] * tx + mat4[5] * ty + mat4[9] * tz;
		mat4[14] += mat4[2] * tx + mat4[6] * ty + mat4[10] * tz;
		mat4[15] += mat4[3] * tx + mat4[7] * ty + mat4[11] * tz;

		return mat4;
	}

	_multMatrix(matA, matB)
	{
		var result = [];

		for (var i=0; i<16; i+=4)
			for (var j=0; j<4; ++j)
				result.push( matA[i] * matB[j] + matA[i+1] * matB[j+4] + matA[i+2] * matB[j+8]  + matA[i+3] * matB[j+12] );

		return result;
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


class BorderCell
{
	constructor(worldRect)
	{
		this.worldRect = worldRect.clone();
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

		this.borderCellsLeft = [];
		this.borderCellsRight = [];
		var tileSize = pow(2, lod);
		for (var y=0; y<numTilesPerAxis; ++y)
		{
			for (var x=0; x<numTilesPerAxis; ++x)
			{
				this.borderCellsLeft[y*numTilesPerAxis+x] = new BorderCell(new Rect(new Victor(-(1+x)*tileSize, y*tileSize), new Victor(-x*tileSize, (y+1)*tileSize)));
				this.borderCellsRight[y*numTilesPerAxis+x] = new BorderCell(new Rect(new Victor((numTilesPerAxis+x)*tileSize, y*tileSize), new Victor((numTilesPerAxis+x+1)*tileSize, (y+1)*tileSize)));
			}
		}		
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

	getTilesAndBorderCellsInFrustum(frustum)
	{
		var worldBoundsRect = frustum.worldBoundsRect;

		var tileSize = pow(2, this.lod);
		var tl = new Victor(Math.floor(worldBoundsRect.min.x/tileSize), Math.floor(worldBoundsRect.min.y/tileSize));
		var br = new Victor(Math.floor(worldBoundsRect.max.x/tileSize), Math.floor(worldBoundsRect.max.y/tileSize));

		var numBorderCellsLeft = (tl.x < 0) ? (-tl.x) : 0;
		var numBorderCellsRight = (br.x >= this.numTilesPerAxis) ? (br.x - (this.numTilesPerAxis-1)) : 0;

		// Clamp window to valid range
		tl.x = Math.min(this.numTilesPerAxis-1, Math.max(0, tl.x));
		tl.y = Math.min(this.numTilesPerAxis-1, Math.max(0, tl.y));
		br.x = Math.min(this.numTilesPerAxis-1, Math.max(0, br.x));
		br.y = Math.min(this.numTilesPerAxis-1, Math.max(0, br.y));		

		var numCellsY = (br.y - tl.y)+1;
		var numCellsX = (br.x - tl.x)+1;

		// Gather all tiles that overlap our frustum
		var visibleTiles = [];
		for (var y=tl.y; y<=br.y; ++y)
		{
			for (var x=tl.x; x<=br.x; ++x)
			{
				var t = this.tiles[y*this.numTilesPerAxis+x];

				if (frustum.overlaps(t.worldRect))
					visibleTiles.push(t);
			}
		}

		// Gather all border cells, on the left and the right
		var borderCells = [];
		for (var x=0; x<numBorderCellsLeft; ++x)
		{
			for (var y=tl.y; y<=br.y; ++y)				
			{
				var c = this.borderCellsLeft[y*this.numTilesPerAxis+x];
				
				if (frustum.overlaps(c.worldRect))
					borderCells.push(c);
			}
		}
		for (var x=0; x<numBorderCellsRight; ++x)
		{
			for (var y=tl.y; y<=br.y; ++y)				
			{
				var c = this.borderCellsRight[y*this.numTilesPerAxis+x];
				
				if (frustum.overlaps(c.worldRect))
					borderCells.push(c);
			}
		}


		return { tiles: visibleTiles, borderCells: borderCells };
	}
}


class InteractionPoint
{
	constructor (screenPos)
	{
		this.screenPos = screenPos.clone();
		this.worldPos = gView.screenToWorldPos(screenPos);
		this.view = gView.clone();
	}

	clone()
	{
		var newPoint = new InteractionPoint(this.screenPos);
		newPoint.view = this.view.clone();
		return newPoint;
	}
}


class PanZoomInteraction
{
	constructor()
	{		
		this.isMousePanning = false;
		this.mousePanInitialPoint = null;

		this.isMouseZooming = false;
		this.mouseZoomCurrentAmount = 1.0;
		this.mouseZoomDesiredAmount = 1.0;
		this.mouseZoomInitialPoint = null;

		this.touchInfos = {}
		
		this.isTouchPanning = false;
		this.touchPanTouchInfo = null;

		this.isTouchZooming = false;
		this.touchZoomTouchInfoA = null;
		this.touchZoomTouchInfoB = null;
	}
	
	updateView()
	{
		// Panning with the mouse?
		if (this.isMousePanning)
		{
			// Calculate current mouse position in worldspace of the initial view
			var currentMouseWorldPos = this.mousePanInitialPoint.view.screenToWorldPos(this.mousePanCurrentPoint.screenPos);

			// Calculate delta with initial world position of the mouse
			var deltaMouseWorldPos = currentMouseWorldPos.clone().subtract(this.mousePanInitialPoint.worldPos);

			// Recalculate the world bottom center
			gView.worldBottomCenter = this.mousePanInitialPoint.view.worldBottomCenter.clone().subtract(deltaMouseWorldPos);
		}

		// Panning with touch?
		if (this.isTouchPanning)
		{
			// Calculate current touch position in worldspace of the initial view
			var currentTouchWorldPos = this.touchPanTouchInfo.initialPoint.view.screenToWorldPos(this.touchPanTouchInfo.currentPoint.screenPos);

			// Calculate delta with initial world position of the touch
			var deltaTouchWorldPos = currentTouchWorldPos.clone().subtract(this.touchPanTouchInfo.initialPoint.worldPos);

			// Recalculate the world bottom center
			gView.worldBottomCenter = this.touchPanTouchInfo.initialPoint.view.worldBottomCenter.clone().subtract(deltaTouchWorldPos);
		}		

		// Zooming with the mouse?
		if (this.isMouseZooming)
		{
			this.mouseZoomCurrentAmount += (this.mouseZoomDesiredAmount  - this.mouseZoomCurrentAmount)*0.2; 

			// Adjust scale
			gView.worldScale = this.mouseZoomInitialPoint.view.worldScale * this.mouseZoomCurrentAmount;

			// Apply limits and recalculate camera
			gView.applyViewLimits();
			gView.updateCamera();

			// Calculate new world position of the initial mouse's screen pos
			var newZoomPivotWorldPos = gView.screenToWorldPos(this.mouseZoomInitialPoint.screenPos);

			// Remove panning caused by scaling around the world center
			gView.worldBottomCenter.subtract(newZoomPivotWorldPos.clone().subtract(this.mouseZoomInitialPoint.worldPos));

			// Did we reach the desired zoom amount? Then stop zooming
			if (Math.abs(this.mouseZoomCurrentAmount - this.mouseZoomDesiredAmount ) <= 0.01)		
				this.isMouseZooming = false;			
		}

		// Zooming with touch? (Pinch zoom)
		if (this.isTouchZooming)
		{
			var initialWorldDelta = this.touchZoomTouchInfoB.initialPoint.worldPos.clone().subtract(this.touchZoomTouchInfoA.initialPoint.worldPos);
			var initialWorldDistance = initialWorldDelta.length();
			var currentWorldDelta = this.touchZoomTouchInfoB.currentPoint.worldPos.clone().subtract(this.touchZoomTouchInfoA.currentPoint.worldPos);
			var currentWorldDistance = currentWorldDelta.length();

			var scaleFactor = (currentWorldDistance > 0.0) ? (initialWorldDistance / currentWorldDistance) : 1.0;

			// Adjust scale
			gView.worldScale = this.touchZoomTouchInfoA.initialPoint.view.worldScale * Math.pow(scaleFactor, 0.7);
		}

		gView.applyViewLimits();	
		gView.updateCamera();
	}

	mousePressed()
	{		
		if (!this.isMousePanning && !this.isMouseZooming)
		{
			this.mousePanInitialPoint = new InteractionPoint(getMousePos());
			this.mousePanCurrentPoint = this.mousePanInitialPoint;
			this.isMousePanning = true;
		}
	}

	mouseDragged()
	{
		if (this.isMousePanning)
			this.mousePanCurrentPoint = new InteractionPoint(getMousePos());
	}

	mouseReleased()
	{
		this.isMousePanning = false;
	}

	mouseWheel(event)
	{
		if (!this.isMousePanning && !this.isMouseZooming)
		{
			var maxZoomAmount = 0.75;
			var zoom_delta = Math.max(-maxZoomAmount, Math.min(maxZoomAmount, -event.delta / 200.0));

			this.mouseZoomCurrentAmount = 1;		
			this.mouseZoomDesiredAmount = pow(2, -zoom_delta);
			this.mouseZoomInitialPoint = new InteractionPoint(getMousePos());
			
			this.isMouseZooming = true;
		}
	}

	touchStarted()
	{
		// Add all new touches to the touchInfos
		for (var i=0; i<touches.length; ++i)
		{
			if ((touches[i].id in this.touchInfos))
				continue;

			var point = new InteractionPoint(new Victor(touches[i].x, touches[i].y));

			this.touchInfos[touches[i].id] = {
				id: touches[i].id,
				initialPoint: point,
				currentPoint: point
			};
		}

		// Determine if we're panning (and with which touch)
		this.isTouchPanning = (Object.keys(this.touchInfos).length == 1);
		if (this.isTouchPanning)
			this.touchPanTouchInfo = this.touchInfos[Object.keys(this.touchInfos)[0]];

		// Determine if we're zooming (and with which two touches)
		this.isTouchZooming = (Object.keys(this.touchInfos).length == 2);
		if (this.isTouchZooming)
		{
			this.touchZoomTouchInfoA = this.touchInfos[Object.keys(this.touchInfos)[0]];
			this.touchZoomTouchInfoB = this.touchInfos[Object.keys(this.touchInfos)[1]];
		}
	}

	touchMoved()
	{
		for (var i=0; i<touches.length; ++i)
			this.touchInfos[touches[i].id].currentPoint = new InteractionPoint(new Victor(touches[i].x, touches[i].y));
	}

	touchEnded()
	{
		var newTouchInfos = {};

		// Copy over the start infos for only the still active touches
		for (var i=0; i<touches.length; ++i)
			newTouchInfos[touches[i].id] = this.touchInfos[touches[i].id];

		this.touchInfos = newTouchInfos;

		var wasZooming = this.isTouchZooming;

		// Determine if we're panning (and with which touch)
		this.isTouchPanning = (Object.keys(this.touchInfos).length == 1);
		if (this.isTouchPanning)
		{
			this.touchPanTouchInfo = this.touchInfos[Object.keys(this.touchInfos)[0]];

			if (wasZooming)
				this.touchPanTouchInfo.initialPoint = this.touchPanTouchInfo.currentPoint.clone();
		}

		// Determine if we're zooming (and with which two touches)
		this.isTouchZooming = (Object.keys(this.touchInfos).length == 2);
		if (this.isTouchZooming)
		{
			this.touchZoomTouchInfoA = this.touchInfos[Object.keys(this.touchInfos)[0]];
			this.touchZoomTouchInfoB = this.touchInfos[Object.keys(this.touchInfos)[1]];
		}			
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
var gPanZoomInteraction;

// Rendering
var gTilesOffscreenGraphics;
var gTileShader;
var gMapShader;

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
	reliefDepth: 0.50,
	cameraPitchAngle: 0.50,
	cameraFOV: 60.0,
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


function canStartLoadTileImage()
{
	var maxNumSimultaneousImagesBeingLoaded = gDebugSettings.loadOneByOne ? 1 : 6;

	return gNumTileImagesBeingLoaded < maxNumSimultaneousImagesBeingLoaded;
}


function updateTileLoading()
{
	var tilesToLoad = getTilesToLoad()

	for (var i=0; i<tilesToLoad.length; ++i)
	{
		var tile = tilesToLoad[i];

		if (!canStartLoadTileImage())
			return;

		// Do we have to load the albedo?
		if (tile.albedoImage.loadingState == ETileLoadingState.unloaded)
			tile.albedoImage.startLoading();

		if (!canStartLoadTileImage())
			return;

		// Do we have to load the elevation?
		if (tile.elevationImage.loadingState == ETileLoadingState.unloaded)
			tile.elevationImage.startLoading();
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
	gView.updateCamera();

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

	gPanZoomInteraction = new PanZoomInteraction();

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
	// folderRender.addInput(gDebugSettings, 'cameraFOV', {label: "Camera FOV", min:30.0, max:120.0});		
	
	console.log("939b106b.js: Successfully loaded. Enjoy!");
}


function calcDesiredLod()
{
	var cTileImageSize = gMap.tileSize;

	var bottomViewWorldWidth = gView.screenToWorldPos(gView.screenRect.max).x - gView.screenToWorldPos(new Victor(gView.screenRect.min.x, gView.screenRect.max.y)).x;

	var numTilePixelsOnScreen = bottomViewWorldWidth * cTileImageSize;
	var numTilePixelsPerScreenPixel = numTilePixelsOnScreen / gRenderWidth;

	var lod = Math.max(1.0, numTilePixelsPerScreenPixel);
	lod = Math.min(gMap.numLods-1, Math.round(Math.log2(lod)));

	return lod;
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
		return { image: gNullTileElevationImage, tileRect: gNullTileRect };
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



function drawTileQuad(tile, desiredLod, worldRect, uvRect)
{
	var right = worldRect.min.x >= gView.cameraPos.x;
	var top = worldRect.min.y < gView.cameraPos.y;

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

	gTileShader.setUniform('uReliefDepth', gDebugSettings.reliefDepth / Math.pow(2.0, desiredLod));
	gTileShader.setUniform('uUVTopLeft', [uvRect.min.x, uvRect.min.y]);
	gTileShader.setUniform('uUVBottomRight', [uvRect.max.x, uvRect.max.y]);

	// Draw our tile
	push();
	translate(worldRect.center.x, worldRect.center.y);
	plane(worldRect.size.x, worldRect.size.y);
	pop();
}


function drawBorderCell(borderCell, desiredLod)
{
	setTileUniforms('00', null);
	setTileUniforms('01', null);
	setTileUniforms('10', null);
	setTileUniforms('11', null);

	gTileShader.setUniform('uReliefDepth', gDebugSettings.reliefDepth / Math.pow(2.0, desiredLod));
	gTileShader.setUniform('uUVTopLeft', [0.0, 0.0]);
	gTileShader.setUniform('uUVBottomRight', [1.0, 1.0]);

	// Draw our border cell
	push();
	translate(borderCell.worldRect.center.x, borderCell.worldRect.center.y);
	plane(borderCell.worldRect.size.x, borderCell.worldRect.size.y);
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
	gPanZoomInteraction.updateView();

	clear();
	noStroke();
	shader(gTileShader);

	push();
	perspective(gView.FOVy, gView.aspect, gView.near, gView.far);
	camera(
		gView.cameraPos.x, gView.cameraPos.y, gView.cameraPosZ,
		gView.cameraTargetPos.x, gView.cameraTargetPos.y, gView.cameraTargetPosZ,
		gView.cameraUp.x, gView.cameraUp.y, gView.cameraUpZ);

	visitTileChildren(gRootTile, tile => {tile.isVisible = false;});

	var desiredLod = calcDesiredLod();

	// Determine which tiles and border cells are in our frustum
	var visibleTilesAndBorderCells = gTileGrids[desiredLod].getTilesAndBorderCellsInFrustum(gView.frustum);


	// Render all tiles within the quadrant
	for (var i=0; i<visibleTilesAndBorderCells.tiles.length; ++i)
	{	
		var visibleTile = visibleTilesAndBorderCells.tiles[i];

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
		if (screenTileInfo[0].worldRect.min.x < gView.cameraPos.x && screenTileInfo[0].worldRect.max.x > gView.cameraPos.x)
		{
			var splitFraction = screenTileInfo[0].worldRect.getFractionX(gView.cameraPos.x);
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
			if (screenTileInfo[j].worldRect.min.y < gView.cameraPos.y && screenTileInfo[j].worldRect.max.y > gView.cameraPos.y)
			{
				var splitFraction = screenTileInfo[j].worldRect.getFractionY(gView.cameraPos.y);
				var bottomTileInfo = {
					worldRect: screenTileInfo[j].worldRect.splitYAtFraction(splitFraction),
					uvRect: screenTileInfo[j].uvRect.splitYAtFraction(splitFraction)
				};
				screenTileInfo.push(bottomTileInfo);
			}
		}
		
		for (var j=0; j<screenTileInfo.length; ++j)
			drawTileQuad(visibleTile, desiredLod, screenTileInfo[j].worldRect, screenTileInfo[j].uvRect);
	}

	// Render all border cells
	for (var i=0; i<visibleTilesAndBorderCells.borderCells.length; ++i)
	{
		var borderCell = visibleTilesAndBorderCells.borderCells[i];

		drawBorderCell(borderCell, desiredLod);
	}


	pop();

	updateTileLoading();	
	updateTileUnloading();

	// Gather debug info
	var numTilesLoaded = 0;
	visitTileChildren(gRootTile, tile => { if (tile.albedoImage.loadingState == ETileLoadingState.loaded) numTilesLoaded++;});
	
	gDebugInfo.desiredLod = desiredLod;
	gDebugInfo.numTilesVisible = visibleTilesAndBorderCells.tiles.length;
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
	resetShader();

	// Draw mini map
	if (gDebugSettings.showTileMiniMap)
	 	drawTileMiniMap();

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

function drawTileMiniMap()
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
	noFill();
	stroke(0,0,0, 192);
	quad(
		gView.frustum.posTopLeft.x * tileScreenSize, gView.frustum.posTopLeft.y * tileScreenSize,
		gView.frustum.posTopRight.x * tileScreenSize, gView.frustum.posTopRight.y * tileScreenSize,
		gView.frustum.posBottomRight.x * tileScreenSize, gView.frustum.posBottomRight.y * tileScreenSize,
		gView.frustum.posBottomLeft.x * tileScreenSize, gView.frustum.posBottomLeft.y * tileScreenSize);

	pop();
}

function mousePressed()
{
	gPanZoomInteraction.mousePressed();

	return false;
}

function mouseDragged()
{
	gPanZoomInteraction.mouseDragged();

	return false;
}

function mouseReleased()
{
	gPanZoomInteraction.mouseReleased();

	return false;
}

function mouseWheel(event) 
{
	gPanZoomInteraction.mouseWheel(event);

	return false;
}

function touchStarted() 
{
	gPanZoomInteraction.touchStarted();
}

function touchEnded()
{
	gPanZoomInteraction.touchEnded();
}

function touchMoved() 
{
	gPanZoomInteraction.touchMoved();
}