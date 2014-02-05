<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <script type="text/javascript" src="processing-1.4.1.min.js"></script>
    <script type="text/javascript" src="timbre.js"></script>
    <script type="text/javascript" src="animation.js"></script>
    <!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->    
    <title>magnizdat.org</title>    
  </head>
  
  <body>    
    <form action="post_tweet.php" method="post">
      <input type="text" name="tweet"/>
      <input type="submit" value="post" />
    </form>       
    <?php
      
    session_start();

    $debug = true;
    if($debug == true)
      {
	ini_set('display_errors', 'On');
	error_reporting(E_ALL);
      }

      if(isset($_SESSION['tweets_array']))
	{
	  $tweets = $_SESSION['tweets_array'];
	  unset($_SESSION['tweets_array']);
	  $j_tweets = json_encode($tweets);	  	  
    ?>
    
    <p>
      <canvas id="canvas1" width="200" height="200"></canvas>
    </p>    
    <script id="script1" type="text/javascript">
      
      var json_tweets=<?php echo $j_tweets ?>; //Getting back the tweets array.
      // Simple way to attach js code to the canvas is by using a function
      
      var canvas = document.getElementById("canvas1");
      // attaching the sketchProc function to the canvas
      var p = new Processing(canvas, sketchProc);
      
    </script>
    
    <?php
	}  
    ?>
  </body>
</html>
