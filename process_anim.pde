var tweets_count = json_tweets.length; //Number of entities.
      var char_nbr = [];
      var min_size = 140 ,max_size = 0;
      for(var ind = 0; ind < json_tweets.length; ind++)
      {	      
	  char_nbr[ind] = json_tweets[ind].length;	      
	  if(char_nbr[ind] < min_size)
	      min_size = char_nbr[ind];
	  if(char_nbr[ind] > max_size)
	      max_size = char_nbr[ind];	      
      }            
      var e = [][];
      var ds = 2;
      var dragging = 'false';
      var locked_circle;
      var locked_offset_x;
      var locked_offset_y;
      
function sketchProc(processing)
{
  processing.mousePressed function()
    {
	      for(var ind = 0;ind < tweets_count; ind++)
	      {
		  if(processing.sq(e[ind][0] - processing.mouseX) + processing.sq(e[ind][1] - processing.mouseY) < processing.sq(e[ind][2]/2))
		  {
		      locked_circle   = ind;
		      locked_offset_x = processing.mouseX - parseInt(e[ind][0]);
		      locked_offset_y = processing.mouseY - parseInt(e[ind][1]);
		      dragging = "true";
		      break;
		  }
	      }	      	      
	  }
	  
	  processing.mouseReleased function()
	  {
	      dragging = "false";
	  }
	  
	  // Set up canvas
	  processing.setup = function()
	  {	      
	    processing.frameRate(60);	      
	      processing.size(940, 78);
	      processing.strokeWeight(1);
	      
	      for (var j = 0; j < count; j++) 
	      {
		  e[j][0]=processing.random(processing.width);
		  e[j][1]=processing.random(processing.height);
		  e[j][2]=processing.random(min_size, max_size); 
		  e[j][3]=processing.random(-.12, .12); 
		  e[j][4]=processing.random(-.12, .12); 
	      }
	  }

	  processing.draw = function() 
	    {
	      processing.background(0);
	      for(var ind = 0;ind < tweets_count; ind++)
		{
		  processing.noStroke();
		  var radi = e[ind][2];
		  var diam = radi/2;
		  if(processing.sq(e[ind][0] - processing.mouseX) + processing.sq(e[ind][1] - processing.mouseY) < processing.sq(e[ind][2]/2))
		    processing.fill(64, 187, 128, 100);
		  else
		    processing.fill(64, 128, 187, 100);
		  if(locked_circle == ind && dragging == "true")
		    {
		      e[ind][0] = processing.mouseX - locked_offset_x;
		      e[ind][1] = processing.mouseY - locked_offset_y;
		    }
		  processing.ellipse(e[ind][0], e[ind][1], radi, radi);		  		  
		  e[ind][0] += e[ind][3];
		  e[ind][1] += e[ind][4];		  
		  
		  if(e[ind][0] < -diam )
		    e[ind][0] = processing.width + diam;
		  if(e[ind][0] < processing.width+diam )
		    e[ind][0] = -diam;
		  
		  if(e[ind][1] < 0-diam )
		    e[ind][1] = processing.height + diam;
		  if(e[ind][1] < processing.height+diam )
		    e[ind][1] = -diam;
		  
		  
		  if ((locked_circle == ind && dragging == "true")) 
		    {		      
		      processing.fill(255, 255, 255, 255);		      
		      processing.stroke(128, 255, 0, 100);
		    } 
		  else 
		    {            		      
		      processing.fill(0, 0, 0, 255);		      
		      processing.stroke(64, 128, 128, 255);
		    }		 
		  
		  for (var k = 0; k < tweets_count; k++) 
		    {		      
		      if ( processing.sq(e[ind][0] - e[k][0]) + processing.sq(e[ind][1] - e[k][1]) < processing.sq(diam) )
			processing.line(e[ind][0], e[ind][1], e[k][0], e[k][1]);		      
		    }		  
		  processing.noStroke();      		  
		  processing.rect(e[ind][0]-ds, e[ind][1]-ds, ds*2, ds*2);
		}	     
	    }
      }
      
      var canvas = document.getElementById("canvas_1");
      // attaching the sketchProc function to the canvas
      var p = new Processing(canvas, sketchProc);
      //p.exit(); to detach it


/* 
 PROCESSINGJS.COM HEADER ANIMATION  
 MIT License - F1lT3R/Hyper-Metrix
 Native Processing Compatible 
 */

// Set number of circles
int count = 20;
// Set maximum and minimum circle size
int maxSize = 100;
int minSize = 20;
// Build float array to store circle properties
float[][] e = new float[count][5];
// Set size of dot in circle center
float ds=2;
// Set drag switch to false
boolean dragging=false;
// integers showing which circle (the first index in e) that's locked, and its position in relation to the mouse
int lockedCircle; 
int lockedOffsetX;
int lockedOffsetY;

// If user presses mouse...
void mousePressed () {
  // Look for a circle the mouse is in, then lock that circle to the mouse
  // Loop through all circles to find which one is locked
  for (int j=0;j< count;j++) {
    // If the circles are close...
    if (sq(e[j][0] - mouseX) + sq(e[j][1] - mouseY) < sq(e[j][2]/2)) {
      // Store data showing that this circle is locked, and where in relation to the cursor it was
      lockedCircle = j;
      lockedOffsetX = mouseX - (int)e[j][0];
      lockedOffsetY = mouseY - (int)e[j][1];
      // Break out of the loop because we found our circle
      dragging = true;
      break;
    }
  }
}
// If user releases mouse...
void mouseReleased() {
  // ..user is no-longer dragging
  dragging=false;
}

// Set up canvas
void setup() {
  // Frame rate
  frameRate(60);
  // Size of canvas (width,height)
  size(940, 78);
  // Stroke/line/border thickness
  strokeWeight(1);
  // Initiate array with random values for circles
  for (int j=0;j< count;j++) {
    e[j][0]=random(width); // X 
    e[j][1]=random(height); // Y
    e[j][2]=random(minSize, maxSize); // Radius        
    e[j][3]=random(-.12, .12); // X Speed
    e[j][4]=random(-.12, .12); // Y Speed
  }
}

// Begin main draw loop (called 25 times per second)
void draw() {
  // Fill background black
  background(0);
  // Begin looping through circle array
  for (int j=0;j< count;j++) {
    // Disable shape stroke/border
    noStroke();
    // Cache diameter and radius of current circle
    float radi=e[j][2];
    float diam=radi/2;
    if (sq(e[j][0] - mouseX) + sq(e[j][1] - mouseY) < sq(e[j][2]/2))
      fill(64, 187, 128, 100); // green if mouseover
    else
      fill(64, 128, 187, 100); // regular
    if ((lockedCircle == j && dragging)) {
      // Move the particle's coordinates to the mouse's position, minus its original offset
      e[j][0]=mouseX-lockedOffsetX;
      e[j][1]=mouseY-lockedOffsetY;
    }
    // Draw circle
    ellipse(e[j][0], e[j][1], radi, radi);
    // Move circle
    e[j][0]+=e[j][3];
    e[j][1]+=e[j][4];


    /* Wrap edges of canvas so circles leave the top
     and re-enter the bottom, etc... */
    if ( e[j][0] < -diam      ) { 
      e[j][0] = width+diam;
    } 
    if ( e[j][0] > width+diam ) { 
      e[j][0] = -diam;
    }
    if ( e[j][1] < 0-diam     ) { 
      e[j][1] = height+diam;
    }
    if ( e[j][1] > height+diam) { 
      e[j][1] = -diam;
    }

    // If current circle is selected...
    if ((lockedCircle == j && dragging)) {
      // Set fill color of center dot to white..
      fill(255, 255, 255, 255);
      // ..and set stroke color of line to green.
      stroke(128, 255, 0, 100);
    } 
    else {            
      // otherwise set center dot color to black.. 
      fill(0, 0, 0, 255);
      // and set line color to turquoise.
      stroke(64, 128, 128, 255);
    }

    // Loop through all circles
    for (int k=0;k< count;k++) {
      // If the circles are close...
      if ( sq(e[j][0] - e[k][0]) + sq(e[j][1] - e[k][1]) < sq(diam) ) {
        // Stroke a line from current circle to adjacent circle
        line(e[j][0], e[j][1], e[k][0], e[k][1]);
      }
    }
    // Turn off stroke/border
    noStroke();      
    // Draw dot in center of circle
    rect(e[j][0]-ds, e[j][1]-ds, ds*2, ds*2);
  }
}

