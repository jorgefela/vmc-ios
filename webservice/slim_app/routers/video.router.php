<?php
$app->post('/videos','authenticate', function () use ($app) {

	$data = $app->request()->post();

  $app->contentType('application/json');

  if(!empty($data['idUser']) && isInteger($data['idUser'])){

      $ob = new models\Video();
      $data = $ob->getVideoLibrary($data['idUser']);
      echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else{

     $data =array();
     echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }


});
