<?php
$app->post('/login', function () use ($app) {

	$data = $app->request()->post();

    if(empty($data['email']) && empty($data['password'])){

        error_log("Username/Password empty.");
        $app->halt(401);

    }else if(empty($data['email']) || empty($data['password'])){

       error_log("Username/Password empty.");
        $app->halt(401);

    }else{

        $ob   = new models\Login($app);
        $app->contentType('application/json');
        $data = $ob->getUserByLogin($data['email'], $data['password']);
        $key  = $ob->getKey();
        if($data==false){
            $response = 0;
            $data = array();
        }else{
            $response = 1;
        }
        echo '{"success": '.$response.', "key": "'. $key .'", "result": ' . json_encode($data) . '}';
   }
});