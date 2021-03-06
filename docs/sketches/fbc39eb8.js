

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

	// Disable any touch controls
	cnv.style('touch-action', 'none');
}

function projX(x,z)
{
	return x + (x - 0.5*gRenderWidth)*0.5*z;
}

function projY(y,z)
{
	return y + (y - 0.5*gRenderHeight)*0.5*z;
}

var scrollX = 0;

function draw() 
{
	preDraw();

	//myrng = new Math.seedrandom('hello'+iteration.toString());
	
	background(255, 255, 255);

	stroke(0,0,0);

	scrollX += gRenderDeltaTime * 100.0;

	var barW = 50;


	if (scrollX >= 0)
		scrollX -= barW*2;

	var pts0 = [];	

	// Stripes
	for (var x=scrollX; x<gRenderWidth+2*barW; x+=barW*2)
	{
		var h = gRenderHeight * (0.75 - 0.10*Math.cos(x/400.0 + gRenderTime*0.2));
		var z = 0.7 + 0.3*Math.cos(x/400.0 + gRenderTime*0.05);

		// Vert 
		fill(255,0,0);		

		quad(
			projX(x,0.0),projY(0,0.0), 
			projX(x+barW,0.0),projY(0,0.0), 
			projX(x+barW,0), projY(h, 0.0),
			projX(x,0), projY(h, 0.0));

		// Horz
		fill(255,90,90);		
		quad(
			projX(x,0),projY(h,0), 
			projX(x+barW,0),projY(h,0), 
			projX(x+barW,z), projY(h, z),
			projX(x,z), projY(h, z));

		// Vert
		fill(255,0,0);

		quad(
			projX(x,z),projY(h,z), 
			projX(x+barW,z),projY(h,z), 
			projX(x+barW,z), projY(h*2, z),
			projX(x,z), projY(h*2, z));			
	}	

	postDraw();
}

function mousePressed()
{
	//return false;
}

function mouseReleased()
{
	//return false;
}