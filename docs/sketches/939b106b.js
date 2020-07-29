

function setup() 
{
	var cnv = createCanvas(window.innerWidth, window.innerHeight);
	cnv.position(0, 0);	
	cnv.style('position', 'absolute');

	// Disable any touch controls
	cnv.style('touch-action', 'none');
}



function draw() 
{
	preDraw();

	background(255, 255, 255);


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