<?php
$app->get('/user/:id_user/email(/:id)','authenticate', function ($id_user, $id=0) use ($app) {

  $app->contentType('application/json');

  if(!empty($id_user) && isInteger($id_user) && $id==0){

      $ob = new models\Email();
      $data = $ob->getEmail($id_user);
      echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else if(!empty($id_user) && isInteger($id_user) && isInteger($id) && $id != 0){

    $ob = new models\Email();
    $data = $ob->getEmailOnly($id);
    echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else{

     $data =array();
     echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }

});

