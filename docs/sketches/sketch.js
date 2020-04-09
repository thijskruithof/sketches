
var myrng;
var redraw = true;

https://coolors.co/ffffff-87ff65-1a1d25-033f63-ffb045
var colors = [
	[135,255,101],
	[26,29,37],
	[3,63,99],
	[255,176,69]
];


function randRange(min, max)
{
	return myrng.quick()*(max-min) + min;
}

// https://stackoverflow.com/questions/7616461/generate-a-hash-from-string-in-javascript
function hashCode(str) 
{
	var hash = 0, i, chr;
	for (i = 0; i < str.length; i++) 
	{
		chr   = str.charCodeAt(i);
		hash  = ((hash << 5) - hash) + chr;
		hash |= 0; // Convert to 32bit integer
	}
	return hash;
}

function clamp(v, min, max)
{
	return Math.max(Math.min(v,max),min);
}

function remap(v, imin, imax, omin, omax)
{
	var a = clamp( (v-imin)/(imax-imin), 0.0, 1.0);
	return omin + a*(omax-omin);
}

function getIntersection(line0, line1)
{
	var s1 = line0.b.clone().subtract(line0.a);
	var s2 = line1.b.clone().subtract(line1.a);

	var p0p2 = line0.a.clone().subtract(line1.a);
	var norm = -s2.x*s1.y + s1.x*s2.y;
	var s = new Victor(-s1.y, s1.x).dot(p0p2) / norm;
	var t = new Victor(-s2.y, s2.x).dot(p0p2) / norm;
	
	// if (s < 0 || s > 1 || t < 0 || t > 1)
	// 	return null;

	return line0.a.clone().add(s1.multiply(new Victor(t,t)));
}




function setup() 
{
	var cnv = createCanvas(windowWidth, windowHeight);
	cnv.style('display', 'block');
	cnv.position(0, 0);	
}

function windowResized() 
{
	redraw = true;
	resizeCanvas(windowWidth, windowHeight);
}



function drawQuad(tl,tr,bl,br, iter)
{
	var gridPoints = [];	
	var xLines = [];
	var yLines = [];

	var prefCount = Math.floor(26 / (4*iter+1));

	var sizeX = Math.min((tr.x-tl.x)/prefCount,(br.x-bl.x)/prefCount);
	var sizeY = Math.min((br.y-tr.y)/prefCount,(bl.y-tl.y)/prefCount);
	var minSize = Math.min(sizeX,sizeY);

	var numX = Math.floor( Math.min((tr.x-tl.x)/minSize,(br.x-bl.x)/minSize));
	var numY = Math.floor( Math.min((br.y-tr.y)/minSize,(bl.y-tl.y)/minSize));

	// Horizontal lines
	for (var iy = 0; iy<numY; ++iy)
	{
		var fy = iy/numY;		
		var fyLeft = clamp(fy + randRange(-0.02, 0.04), 0, 1.0);
		var fyRight = clamp(fy + randRange(-0.02, 0.04), 0, 1.0);
		var lineLeft = tl.clone().mix(bl, fyLeft);
		var lineRight = tr.clone().mix(br, fyRight);
		xLines.push({a:lineLeft,b:lineRight});		
	}

	// Vertical lines
	for (var ix = 0; ix<numX; ++ix)
	{
		var fx = ix/numX;		
		var fxTop = clamp(fx + randRange(-0.02, 0.04), 0, 1.0);
		var fxBottom = clamp(fx + randRange(-0.02, 0.04), 0, 1.0);		
		var lineTop = tl.clone().mix(tr, fxTop);
		var lineBottom = bl.clone().mix(br, fxBottom);
		yLines.push({a:lineTop,b:lineBottom});		
	}	

	// Grid points
	for (var iy = 0; iy<numY; ++iy)
	{
		for (var ix = 0; ix<numX; ++ix)
		{
			var p = getIntersection(xLines[iy],yLines[ix]);
			gridPoints.push(p);
		}
	}


	// Squares
	noStroke();

	for (var iy=0; iy<numY-1; ++iy)
	{
		for (var ix=0; ix<numX-1; ++ix)
		{
			var style = randRange(0.0,1.0);

			if (style < 0.7)
				continue;

			var a0 = gridPoints[ix+iy*numX];
			var a1 = gridPoints[ix+iy*numX+1];
			var a2 = gridPoints[ix+(iy+1)*numX];
			var a3 = gridPoints[ix+(iy+1)*numX+1];

			if (style > 0.9 && iter == 0)
			{
				drawQuad(a0,a1,a2,a3,iter+1);
			}
			else 
			{
				// https://coolors.co/app/ffffff-2a3439-edae49-d1495b-2a9df4
				var colIndex = Math.floor(remap(style, 0.7,0.9, 0.0, 3.999));
				var color = colors[colIndex];
				fill(color[0],color[1],color[2]);
				quad(a0.x,a0.y,a1.x,a1.y,a3.x,a3.y,a2.x,a2.y);			
			}
		}	
	}

	stroke(0,0,0);	

	for (var i=0; i<yLines.length; ++i)
		line(yLines[i].a.x, yLines[i].a.y, yLines[i].b.x, yLines[i].b.y);
	for (var i=0; i<xLines.length; ++i)
	 	line(xLines[i].a.x, xLines[i].a.y, xLines[i].b.x, xLines[i].b.y);	

}




function draw() 
{
	if (!redraw)
		return;

	redraw = false;
	myrng = new Math.seedrandom('hello');
	
	background(255, 255, 255);
	clear();

	drawQuad(
		new Victor(0,0), 
		new Victor(windowWidth, 0),
		new Victor(0, windowHeight),
		new Victor(windowWidth, windowHeight),
		0
	);

	
}