var win_width = $(window).width();
var win_height = $(window).height();

function sketchProc(processing) 
{
    
    var line_array = {};
    var line_nbr = 100; //processing.random(win_width);
    var n = {};
    processing.setup = function()
    {
	processing.size(win_width,win_height);	
	for(var ind = 0; ind < line_nbr; ind++)
	{
	    line_array[ind] = processing.random(win_width);
	    n[ind] = processing.random(win_width);
	}
	
    };
    
    // Overide draw function, by default it will be called 60 times per second
    processing.draw = function() 
    {	
	processing.background(200);	

	//Vertical
	for(var ind = 0; ind < line_nbr; ind++)
	{
	    line_array[ind] = line_array[ind] + .001;	
	    n = processing.noise(line_array[ind])*win_width;
	    processing.line(n, 0, n, processing.height);			    
	}	
    };
}

// attaching the sketchProc function to the canvas
var canvas = document.getElementById("anim_back");
var processingInstance = new Processing(canvas, sketchProc);
