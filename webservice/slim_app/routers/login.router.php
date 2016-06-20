<?php
$app->post('/login', function () use ($app) {

	$data = $app->request()->post();

	$ob   = new models\Login($app);

    $app->contentType('application/json');
    $data = $ob->getUserByLogin($data['email'], $data['password']);
    $key  = $ob->getKey();
    if($data==false){
    	$response = $data;
    	$data = array();

    }else{
    	$response = true;
    }
   echo '{"reponse": '.$response.', "key": "'. $key .'", "result": ' . json_encode($data) . '}';
});