<?php

// email user and a single email
$app->get('/user/:id_user/email(/:id)','authenticate', function ($id_user, $id=0) use ($app) {

  $app->contentType('application/json');
  $rows = 0;
  $message = "No records found";

  if(!empty($id_user) && isInteger($id_user) && $id==0){

      $ob = new models\Email();
      $full="";
      $data = $ob->getEmail($id_user, $full);
      $rows = $ob->num_reg;
      if($rows>0){
        $message = "";
      }
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else if(!empty($id_user) && isInteger($id_user) && isInteger($id) && $id != 0){

    $ob = new models\Email();
    $full="";
    $data = $ob->getEmailOnly($id_user, $id, $full);
    $rows = $ob->num_reg;
      if($rows>0){
        $message = "";
      }
    echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else{

     $data =array();
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }

});

//range for paging
$app->get('/user/:id_user/email/from/:from/to/:to','authenticate', function ($id_user, $from, $to) use ($app) {

  $app->contentType('application/json');
  $rows = 0;
  $message = "No records found";

  if(!empty($id_user) && isInteger($id_user) && (!empty($from) && isInteger($from) || $from==0) && !empty($to) && isInteger($to) ){

      $ob = new models\Email();
      $full="";
      $data = $ob->getEmailFromTo($id_user, $from, $to, $full);
      $rows = $ob->num_reg;
      if($rows>0){
        $message = "";
      }
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  } else {

     $data =array();
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }

});