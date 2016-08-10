<?php
$app->get('/user/:id_user/contact(/:id)','authenticate', function ($id_user, $id = 0) use ($app) {

  $app->contentType('application/json');
  $ob = new models\Contacts();

  if( !empty($id_user) && isInteger($id_user) && $id == 0){


      $data = $ob->getContacts($id_user);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else if( !empty($id_user) && isInteger($id_user) && isInteger($id) && $id != 0 ){

    $data = $ob->getContactsOnly($id, $id_user);
    $rows = $ob->num_reg;
    $message = $ob->message;
    echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else{

     $data = array();
     $rows = $ob->num_reg;
     $message = $ob->message;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  } 
  $data = null;

});

//range for paging contact
$app->get('/user/:id_user/contacts/from/:from/to/:to','authenticate', function ($id_user, $from, $to) use ($app) {

  $app->contentType('application/json');
  $ob = new models\Contacts();

  if( !empty($id_user) && isInteger($id_user) && (!empty($from) && isInteger($from) || $from == 0) && !empty($to) && isInteger($to) ){

      
      $data = $ob->getContactsFromTo($id_user, $from, $to);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  } else {

     $data = array();
     $rows = $ob->num_reg;
     $message = $ob->message;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }
  $data = null;

});

$app->get('/user/:id_user/contacts_list/:id','authenticate', function ($id_user, $id) use ($app) {

  $app->contentType('application/json');
  $ob = new models\Contacts();

  if( !empty($id_user) && isInteger($id_user) && !empty($id) && isInteger($id) ){

      $data = $ob->getContactsList($id_user, $id);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else{

     $data =array();
     $rows = $ob->num_reg;
     $message = $ob->message;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }

  $data = null;

});
//range for paging contact list
$app->get('/user/:id_user/contacts_list/:id/from/:from/to/:to','authenticate', function ($id_user, $id, $from, $to) use ($app) {

  $app->contentType('application/json');
  $ob = new models\Contacts();

  if( !empty($id_user) && isInteger($id_user) && !empty($id) && isInteger($id) && (!empty($from) && isInteger($from) || $from == 0) && !empty($to) && isInteger($to) ){

      
      $data = $ob->getContactsListFromTo($id_user, $id, $from, $to);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  } else {

     $data = array();
     $rows = $ob->num_reg;
     $message = $ob->message;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }
  $data = null;

});

$app->post('/contact','authenticate', function () use ($app) {

  $data = $app->request()->post();

  $ob = new models\Contacts();

  

  if( !empty($data["id_user"]) && isInteger($data["id_user"]) ){

      $data["email"] = cleanValues($data["email"]);
      $data["nombre"] = cleanValues($data["nombre"]);
      $data["lnombre"] = cleanValues($data["lnombre"]);
      $data["telefono"] = cleanValues($data["telefono"]);

      $data = $ob->insertContact($data);
      $rows = $ob->num_reg;
      $message = $ob->message;

      if( $rows == 0 ){

        echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

      }else{

        echo '{"reponse": "1", "rows": '.$rows.', "result": ['.json_encode($data).'], "message":"'.$message.'"}';

      }
      

  } else {

     $data = array();
     $rows = $ob->num_reg;
     $message = $ob->message2;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }
  unset($ob);
});

$app->put('/contact','authenticate', function () use ($app) {

  $data = $app->request()->put();
  //$data = $app->request->params;

  $ob = new models\Contacts();

  if( !empty($data["id_user"]) && isInteger($data["id_user"]) && !empty($data["id"]) && isInteger($data["id"]) ){

      $data["email"] = cleanValues($data["email"]);
      $data["nombre"] = cleanValues($data["nombre"]);
      $data["lnombre"] = cleanValues($data["lnombre"]);
      $data["telefono"] = cleanValues($data["telefono"]);

      $data = $ob->updateContact($data);
      $rows = $ob->num_reg;
      $message = $ob->message;

      if( $rows == 0 ){

        echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

      }else{

        echo '{"reponse": "1", "rows": '.$rows.', "result": ['.json_encode($data).'], "message":"'.$message.'"}';

      }
      

  } else {

     $data = array();
     $rows = $ob->num_reg;
     $message = $ob->message3;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }
  unset($ob);
});