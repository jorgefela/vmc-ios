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
        
        $key = "";
        $dataRsl=false;

        if(!empty($data['email']) && validEmail($data['email'])){

            $data['email'] = cleanValues($data['email']);
            $data['password'] = cleanValues($data['password']);
            $ob   = new models\Login($app);
            $dataRsl = $ob->getUserByLogin($data['email'], $data['password']);
            $key  = $ob->getKey();

        }
         
        if($dataRsl==false){
            $response = 0;
            $dataRsl = array();
        }else{
            $response = 1;
        }
        $app->contentType('application/json');
        echo '{"success": '.$response.', "key": "'. $key .'", "result": ' . json_encode($dataRsl) . '}';
   }
});