<?php
$app->get('/user/:id_user/videos','authenticate', function ($id_user) use ($app) {

	//$data = $app->request()->post();

  $app->contentType('application/json');
  $ob = new models\Video();

  if(!empty($id_user) && isInteger($id_user) ){

      
      $data = $ob->getVideoLibrary($id_user);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      //echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else{

     $data =array();
     $rows = $ob->num_reg;
     $message = $ob->message;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
     //echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }


});


//range for paging videos
$app->get('/user/:id_user/videos/from/:from/to/:to','authenticate', function ($id_user, $from, $to) use ($app) {

  $app->contentType('application/json');
  $ob = new models\Video();

  if(!empty($id_user) && isInteger($id_user) && (!empty($from) && isInteger($from) || $from==0) && !empty($to) && isInteger($to) ){

      
      $data = $ob->getVideoLibraryFromTo($id_user, $from, $to);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      //echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  } else {

     $data =array();
     $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
     //echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }

});