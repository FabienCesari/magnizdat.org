<?php

require 'app_tokens.php'; //Load the twitter app tokens.
require 'tmhOAuth.php';   //Load the OAuth lib.

//Creating a new OAuth connection Object.
$connection = new tmhOAuth(array('consumer_key'=>$consumer_key,
				 'consumer_secret'=>$consumer_secret,
				 'user_token'=>$user_token,
				 'user_secret'=>$user_secret));

//Sending a request to twitter.
$code = $connection->request('POST',
			     $connection->url('1.1/statuses/update'),
			     array('status'=>$_POST['tweet'])); 



?>