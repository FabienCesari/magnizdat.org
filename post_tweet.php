<?php
session_start();

$debug = true;
if($debug == true)
  {
    ini_set('display_errors', 'On');
    error_reporting(E_ALL);
  }

require 'app_tokens.php'; //Load the twitter app tokens.
require 'tmhOAuth.php';   //Load the OAuth lib.

$nbr_tweets_max =100;

//Creating a new OAuth connection Object.
$connection = new tmhOAuth(array('consumer_key'=>$consumer_key,
				 'consumer_secret'=>$consumer_secret,
				 'user_token'=>$user_token,
				 'user_secret'=>$user_secret));

//Sending a request to twitter.
$connection->request('GET',
		     $connection->url('1.1/search/tweets'),
		     array('q'=>htmlspecialchars($_POST['tweet']),
			   'result_type'=>'recent',
			   'count'=>$nbr_tweets_max)); 

//Extract tweets.
$results = json_decode($connection->response['response']);
$tweets = $results->statuses;

if (sizeof($tweets)==0) {
  print "No tweets found for: " $_POST['tweets'];
  exit;
}

$count = count($tweets);
$tweets_arr= array();
for($ind = 0; $ind < $count; $ind++)   
{    
  //print_r($tweets[$ind]->text);
  $tweets_arr[$ind] = $tweets[$ind]->text;
}

$_SESSION['tweets_array'] = $tweets_arr;
header('Location: index.php');
?>