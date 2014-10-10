var win_width = $(window).width();
var win_height = $(window).height();
var sketch_selection = 1;
var main_color = 200;

function sketchProc(processing) 
{	
    var nbr_of_circles = Math.ceil(processing.random(10,100));
    var min_size = 20;
    var max_size = 100;	
    var point_size = 2;
    var ds = 4;
    var lockedCircle;
    var lockedOffsetX;
    var lockedOffsetY;
    var dragging = 0;	
    var circles_arr  = new Array(nbr_of_circles);	
    for(var i = 0; i< nbr_of_circles; i++)
    {
	circles_arr[i] = new Array(5);
    }	
    
    processing.mousePressed =function() 
    {	    
	for (var j = 0; j < nbr_of_circles; j++) 
	{		
	    if (processing.sq(circles_arr[j][0] - processing.mouseX) + processing.sq(circles_arr[j][1] - processing.mouseY) < processing.sq(circles_arr[j][2]/2)) 
	    {		 
		lockedCircle = j;
		lockedOffsetX = processing.mouseX - circles_arr[j][0];
		lockedOffsetY = processing.mouseY - circles_arr[j][1];		    
		dragging = 1;
		break;
	    }
	}
    }
    
    processing. mouseReleased = function() 
    {	
	dragging = 0;
    }
    
    processing.setup = function()
    {
	processing.frameRate(60);
	processing.size(win_width,win_height);
	//processing.strokeWeight(1);
	for(var ind = 0; ind < nbr_of_circles; ind++)
	{ 
	    circles_arr[ind][0] = processing.random(win_width);
	    circles_arr[ind][1] = processing.random(win_height);
	    circles_arr[ind][2] = processing.random(min_size,max_size);
	    circles_arr[ind][3] = processing.random(-.12,.12);
	    circles_arr[ind][4] = processing.random(-.12,.12);		
	}	  
    }
    
    processing.draw = function() 
    {
	processing.background(200);	
	for(var ind = 0; ind < nbr_of_circles; ind++)
	{
	    //processing.noStroke();
	    var diametre = circles_arr[ind][2];
	    var radius = diametre / 2;
	    
	    processing.stroke(0);
	    processing.noFill();
	    processing.ellipse(circles_arr[ind][0], circles_arr[ind][1], diametre, diametre);
	    
	    circles_arr[ind][0]+=circles_arr[ind][3];
	    circles_arr[ind][1]+=circles_arr[ind][4];
	    
	    //Wrap ediges of canvas		
	    if (circles_arr[ind][0] < -radius ) 		
		circles_arr[ind][0] = win_width+radius;	    
	    
	    if (circles_arr[ind][0] > win_width+radius)
		circles_arr[ind][0] = -radius;
	    
	    if (circles_arr[ind][1] < 0-radius ) 
		circles_arr[ind][1] = win_height+radius;
	    
	    if (circles_arr[ind][1] > win_height+radius) 
		circles_arr[ind][1] = -radius;
	    
	    processing.stroke(0);
	    
	    for (var k=0;k< nbr_of_circles;k++) 
	    {		    		    
 		var d = processing.dist(circles_arr[ind][0],circles_arr[ind][1],circles_arr[k][0],circles_arr[k][1])		    		    		    
		var base,h;
		var px,py,q1x,q1y,q2x,q2y;
		
		c1x = circles_arr[ind][0];
		c1y = circles_arr[ind][1];
		c2x = circles_arr[k][0];
		c2y = circles_arr[k][1];
		r1 = circles_arr[ind][2] / 2;
		r2 = circles_arr[k][2] / 2;
		
		processing.stroke(255,100,100);
		processing.noFill();
		
		
		//Checking if the circles intersects;		    
		if(d < (circles_arr[ind][2] + circles_arr[k][2])/2)
		{		
		    
		    base=(r1*r1-r2*r2+d*d)/(2*d);
		    h=processing.sqrt(r1*r1-base*base);
		    
		    //Center of the arc.
		    px=c1x+base*(c2x-c1x)/d;
		    py=c1y+base*(c2y-c1y)/d;
	  	    
		    //intersections points.
		    q1x=px+h*(c2y-c1y)/d;
		    q1y=py-h*(c2x-c1x)/d;
		    q2x=px-h*(c2y-c1y)/d;
		    q2y=py+h*(c2x-c1x)/d;
		    
		    processing.fill(0);			
		    
		    processing.ellipse(px,py,point_size,point_size);
		    processing.ellipse(q1x,q1y,point_size,point_size);
		    processing.ellipse(q2x,q2y,point_size,point_size);
		    
		    //processing.line(q1x,q1y,q2x,q2y);
		    //processing.line(c1x,c1y,c2x,c2y);
		    //processing.line(q1x,q1y,c2x,c2y);
		    
		    processing.noFill();
		}    
		
	    }//end
	    
	    processing.noStroke();      		
	    processing.rect(circles_arr[ind][0]-ds, circles_arr[ind][1]-ds, ds*2, ds*2);
	}//loop on circles
    }
}    

// attaching the sketchProc function to the canvas
var canvas = document.getElementById("anim_back");
var processingInstance = new Processing(canvas, sketchProc);
