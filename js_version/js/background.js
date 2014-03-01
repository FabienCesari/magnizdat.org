var win_width = $(window).width();
var win_height = $(window).height();

function sketchProc(processing) 
{
    var line_nbr = processing.random(100);
    var xoff = 0.0;
    processing.setup = function()
    {
	processing.size(win_width,win_height);
	processing.background(0);
	      
    };
    
    // Overide draw function, by default it will be called 60 times per second
    processing.draw = function() 
    {	
	processing.background(204);	
	xoff = xoff + .01;	
	var n = processing.noise(xoff) * processing.width;	
	processing.line(n, 0, n, processing.height);		
    };
}

// attaching the sketchProc function to the canvas
var canvas = document.getElementById("anim_back");
var processingInstance = new Processing(canvas, sketchProc);
