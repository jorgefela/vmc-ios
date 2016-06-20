<?php
$app->post('/videos','authenticate', function () use ($app) {

	//$data = $app->request()->post();
  //$data['idUser']=104;

	$ob = new models\Video();
  $iduser = 38;
  //$iduser = 104;
  $app->contentType('application/json');

  $data = $ob->getVideoLibrary($iduser);
 
    echo '{"reponse": true, "result": '.json_encode($data).', "message":""}';
});