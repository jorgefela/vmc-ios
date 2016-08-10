<?php
$app->get('/user/:id_user/statictics/start_date/:date/cat/:cat','authenticate', function ($id_user, $date, $cat) use ($app) {

  $app->contentType('application/json');

  $ob = new models\Statictics();

  if(!empty($id_user) && isInteger($id_user) ){

      $data = $ob->getDataStatictics($id_user, $date, $cat);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": ['.json_encode($data).'], "message":"'.$message.'"}';

  }else{

     $data =array();
     $rows = $ob->num_reg;
     $message = $ob->message;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }
  unset($ob);
});


