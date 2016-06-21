<?php
$app->get('/user/:id_user/contact(/:id)','authenticate', function ($id_user, $id=0) use ($app) {

  $app->contentType('application/json');

  if(!empty($id_user) && isInteger($id_user) && $id==0){

      $ob = new models\Contacts();
      $data = $ob->getContacts($id_user);
      echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else if(!empty($id_user) && isInteger($id_user) && isInteger($id) && $id != 0){

    $ob = new models\Contacts();
    $data = $ob->getContactsOnly($id);
    echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else{

     $data =array();
     echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }

});

$app->get('/user/:id_user/contacts_list/:id','authenticate', function ($id_user, $id) use ($app) {

  $app->contentType('application/json');

  if(!empty($id_user) && isInteger($id_user) && !empty($id) && isInteger($id) ){

      $ob = new models\Contacts();
      $data = $ob->getContactsList($id_user, $id);
      echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else{

     $data =array();
     echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }

});