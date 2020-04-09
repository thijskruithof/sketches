
var myrng;

function setup() 
{
	var cnv = createCanvas(windowWidth, windowHeight);
	cnv.style('display', 'block');
	cnv.position(0, 0);	

	background(255, 255, 255);
}

function windowResized() 
{
	resizeCanvas(windowWidth, windowHeight);
	background(255, 0, 200);
}

function randRange(min, max)
{
	return myrng.quick()*(max-min) + min;
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


function draw() 
{
	clear();

	var yLines = []; // vertical
	var xLines = []; // horizontal


	// vertical
	myrng = new Math.seedrandom('hello');
	var x = -50;
	while (x < windowWidth+50)
	{
		var x2 = x + randRange(-10,30)* (windowHeight/800);
		var aa = new Victor(x,0);
		var bb = new Victor(x2,windowHeight)
		yLines.push({a:aa, b:bb});
		x += randRange(20,30);
	}

	// horizontal
	myrng = new Math.seedrandom('hello');
	var y = -50;
	while (y < windowHeight+50)
	{
		var y2 = y + randRange(-10,30)*(windowWidth/800.0);
		var aa = new Victor(0, y);
		var bb = new Victor(windowWidth, y2)

		xLines.push({a:aa, b:bb});
		y += randRange(20,30);
	}	

	var gridPoints = [];	
	for (var ix=0; ix<xLines.length; ++ix)
	{
		for (var iy=0; iy<yLines.length; ++iy)
		{
			var xLine = xLines[ix];
			var yLine = yLines[iy];

			// Calculate intersection between the two lines
			var p = getIntersection(xLine, yLine);
			gridPoints.push(p);
		}
	}


	stroke(0,0,0);	
	// for (var i=0; i<yLines.length; ++i)
	// 	line(yLines[i].a.x, yLines[i].a.y, yLines[i].b.x, yLines[i].b.y);
	// for (var i=0; i<xLines.length; ++i)
	// 	line(xLines[i].a.x, xLines[i].a.y, xLines[i].b.x, xLines[i].b.y);

	for (var iy=0; iy<xLines.length-1; ++iy)
	{
		for (var ix=0; ix<yLines.length-1; ++ix)
		{
			var a0 = gridPoints[ix+iy*yLines.length];
			var a1 = gridPoints[ix+iy*yLines.length+1];
			var a2 = gridPoints[ix+(iy+1)*yLines.length];
			var a3 = gridPoints[ix+(iy+1)*yLines.length+1];

			line(a0.x, a0.y, a1.x, a1.y);
			line(a1.x, a1.y, a3.x, a3.y);
			line(a3.x, a3.y, a2.x, a2.y);
			line(a2.x, a2.y, a0.x, a0.y);			
		}	
	}
}