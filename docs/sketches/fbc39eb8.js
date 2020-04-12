

var myrng;

// https://coolors.co/ffffff-87ff65-1a1d25-033f63-ffb045
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


function setup() 
{
	var cnv = createCanvas(window.innerWidth, window.innerHeight);
	cnv.position(0, 0);	
	cnv.style('position', 'absolute');
}


var scrollX = 0;

function draw() 
{
	preDraw();

	//myrng = new Math.seedrandom('hello'+iteration.toString());
	
	background(255, 255, 255);

	noStroke();

	scrollX -= gRenderDeltaTime * 100.0;

	var barW = 50;
	var h = gRenderHeight * 0.7;
	var hw = gRenderWidth * 0.5;
	var persp = 0.5;

	if (scrollX < -barW*2)
		scrollX += barW*2;

	for (var x=scrollX; x<gRenderWidth; x+=barW*2)
	{
		// Vert
		fill(255,0,0);		
		rect(x,0,barW, h);		

		// Horz
		fill(255,90,90);		
		quad(
			x,h, 
			x+barW,h, 
			x+barW+(x+barW-hw)*persp, gRenderHeight,
			x+(x-hw)*persp, gRenderHeight);

	}	

	postDraw();
}
