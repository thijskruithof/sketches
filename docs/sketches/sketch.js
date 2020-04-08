
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

function draw() 
{
	myrng = new Math.seedrandom('hello');

	clear();

	var yLines = [];
	var xLines = [];

	var x = 0;
	while (x < windowWidth)
	{
		var x2 = x + randRange(-10,30);
		yLines.push({a:new Victor(x,0), b:new Victor(x2,windowHeight)});
		x += randRange(20,30);
	}
	var y = 0;
	while (y < windowHeight)
	{
		var y2 = y + randRange(-10,30);
		xLines.push({a:new Victor(0,y), b:new Victor(windowWidth,y2)});
		y += randRange(20,30);
	}	

	// var gridPoints = [];	
	// for (var ix=0; ix<xLines.length; ++ix)
	// {
	// 	for (var iy=0; iy<yLines.length; ++iy)
	// 	{
	// 		var xLine = xLines[ix];
	// 		var yLine = yLines[iy];

	// 		// Calculate intersection between the two lines


	// 	}
	// }


	stroke(0,0,0);	
	for (var i=0; i<yLines.length; ++i)
		line(yLines[i].a.x, yLines[i].a.y, yLines[i].b.x, yLines[i].b.y);
	for (var i=0; i<xLines.length; ++i)
		line(xLines[i].a.x, xLines[i].a.y, xLines[i].b.x, xLines[i].b.y);
}