<?php

// email user and a single email
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

//range for paging
$app->get('/user/:id_user/email/from/:from/to/:to','authenticate', function ($id_user, $from, $to) use ($app) {

  $app->contentType('application/json');

  if(!empty($id_user) && isInteger($id_user) && !empty($from) && isInteger($from) && !empty($to) && isInteger($to) ){

      $ob = new models\Email();
      $data = $ob->getEmailFromTo($id_user, $from, $to);
      echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  } else {

     $data =array();
     echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }

});