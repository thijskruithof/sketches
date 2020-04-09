
var myrng;
var redraw = true;
var iteration = 0;

https://coolors.co/ffffff-87ff65-1a1d25-033f63-ffb045
var colors = [
	[0,38,38],
	[14,71,73],
	[149,198,35],
	[229,88,18]
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


function quadStriped(tl,tr,bl,br)
{
	var num = 6;
	for (var i=0; i<num; i+=2)
	{
		var f0 = i/num;
		var f1 = (i+1)/num;
		var top0 = tl.clone().mix(tr, f0);
		var top1 = tl.clone().mix(tr, f1);
		var left0 = tl.clone().mix(bl, f0);
		var left1 = tl.clone().mix(bl, f1);
		var bottom0 = bl.clone().mix(br, f0);
		var bottom1 = bl.clone().mix(br, f1);
		var right0 = tr.clone().mix(br, f0);
		var right1 = tr.clone().mix(br, f1);

		quad(top0.x,top0.y,top1.x,top1.y,left1.x,left1.y,left0.x,left0.y);
		quad(right0.x,right0.y,right1.x,right1.y,bottom1.x,bottom1.y,bottom0.x,bottom0.y);
	}
}

function quadEllipse(tl,tr,bl,br)
{
	var tcenter = tl.clone().mix(tr, 0.5);
	var bcenter = bl.clone().mix(br, 0.5);
	var center = tcenter.mix(bcenter, 0.5);
	
	var w = Math.min(tr.x-tl.x, br.x-bl.x);
	var h = Math.min(bl.y-tl.y, br.y-tr.y);
	var s = Math.min(w,h);
	ellipseMode(CENTER);
	ellipse(center.x,center.y,s*0.5,s*0.5);
}


function drawQuad(tl,tr,bl,br, iter)
{
	var gridPoints = [];	
	var xLines = [];
	var yLines = [];

	var minSize;

	if (iter == 0)
	{
		minSize = 40*pixelDensity();
	}
	else
	{
		var prefCount = 3.0;		
		var sizeX = Math.min((tr.x-tl.x)/prefCount,(br.x-bl.x)/prefCount);
		var sizeY = Math.min((br.y-tr.y)/prefCount,(bl.y-tl.y)/prefCount);
		minSize = Math.min(sizeX,sizeY);	
	}


	var numX = Math.floor( Math.min((tr.x-tl.x)/minSize,(br.x-bl.x)/minSize));
	var numY = Math.floor( Math.min((br.y-tr.y)/minSize,(bl.y-tl.y)/minSize));

	// Horizontal lines
	for (var iy = 0; iy<numY; ++iy)
	{
		var fy = iy/(numY-1);		
		var fyLeft = clamp(fy + randRange(-0.02, 0.01), 0, 1.0);
		var fyRight = clamp(fy + randRange(-0.02, 0.03), 0, 1.0);
		var lineLeft = tl.clone().mix(bl, fyLeft);
		var lineRight = tr.clone().mix(br, fyRight);
		xLines.push({a:lineLeft,b:lineRight});		
	}

	// Vertical lines
	for (var ix = 0; ix<numX; ++ix)
	{
		var fx = ix/(numX-1);		
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
	for (var iy=0; iy<numY-1; ++iy)
	{
		for (var ix=0; ix<numX-1; ++ix)
		{
			var style = randRange(0.0,1.0);

			var a0 = gridPoints[ix+iy*numX];
			var a1 = gridPoints[ix+iy*numX+1];
			var a2 = gridPoints[ix+(iy+1)*numX];
			var a3 = gridPoints[ix+(iy+1)*numX+1];

			if (style > 0.8 && iter == 0)
			{
				drawQuad(a0,a1,a2,a3,iter+1);
			}
			else if (style > 0.4)
			{
				noStroke();
				// https://coolors.co/app/ffffff-2a3439-edae49-d1495b-2a9df4
				var colIndex = Math.floor(randRange(0.0,3.999));
				var color = colors[colIndex];
				fill(color[0],color[1],color[2]);
				if (style > 0.6)
					// Solid
					quad(a0.x,a0.y,a1.x,a1.y,a3.x,a3.y,a2.x,a2.y);			
				else if (style > 0.5)
					// Diagonal striped
					quadStriped(a0,a1,a2,a3);
				else
					quadEllipse(a0,a1,a2,a3);
			}
		}	
	}

	stroke(0,0,0);	

	for (var i=0; i<yLines.length; ++i)
		line(yLines[i].a.x, yLines[i].a.y, yLines[i].b.x, yLines[i].b.y);
	for (var i=0; i<xLines.length; ++i)
	 	line(xLines[i].a.x, xLines[i].a.y, xLines[i].b.x, xLines[i].b.y);	
}

function mousePressed()
{
	if (!redraw)
	{
		redraw = true;
		iteration++;
	}
}

function draw() 
{
	if (!redraw)
		return;

	redraw = false;
	myrng = new Math.seedrandom('hello'+iteration.toString());
	
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