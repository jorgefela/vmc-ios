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
        $ob   = new models\Login($app);

        if(!empty($data['email']) && validEmail($data['email'])){

            $data['email'] = cleanValues($data['email']);
            $data['password'] = cleanValues($data['password']);
            
            $dataRsl = $ob->getUserByLogin($data['email'], $data['password']);
            $key  = $ob->getKey();
            

        }
        $app->contentType('application/json');
        $rows = $ob->num_reg;
        $message = $ob->message;
         
        if($rows==0){
            
            echo '{"success": 1, "key": "'. $key .'", "rows": '.$rows.', "message":"'.$message.'", "result": []}';

        }else{
            echo '{"success": 1, "key": "'. $key .'", "rows": '.$rows.', "message":"'.$message.'", "result": [' . json_encode($dataRsl) . ']}';
        }
                
   }
});