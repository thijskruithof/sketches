
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

	stroke(0,0,0);

	var x = 0;
	while (x < windowWidth)
	{
		var x2 = x + randRange(-10,30);
		line(x, 0, x2, windowHeight);

		x += randRange(20,30);
	}

	var y = 0;
	while (y < windowHeight)
	{
		var y2 = y + randRange(-10,30);
		line(0, y, windowWidth, y2);

		y += randRange(20,30);
	}	
}