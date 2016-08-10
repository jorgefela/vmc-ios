<?php
$app->get('/user/:id_user/list(/:id)','authenticate', function ($id_user, $id=0) use ($app) {

  $app->contentType('application/json');

  $ob = new models\Lists();

  if(!empty($id_user) && isInteger($id_user) && $id==0){

      $data = $ob->getLists($id_user);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else if(!empty($id_user) && isInteger($id_user) && isInteger($id) && $id != 0){

    $data = $ob->getListsOnly($id, $id_user);
    $rows = $ob->num_reg;
    $message = $ob->message;
    echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else{

     $data =array();
     $rows = $ob->num_reg;
     $message = $ob->message;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }
  unset($ob);
});
 
//range for paging list
$app->get('/user/:id_user/list/from/:from/to/:to','authenticate', function ($id_user, $from, $to) use ($app) {

  $app->contentType('application/json');

  $ob = new models\Lists();

  if(!empty($id_user) && isInteger($id_user) && (!empty($from) && isInteger($from) || $from==0) && !empty($to) && isInteger($to) ){

      $data = $ob->getListsFromTo($id_user, $from, $to);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  } else {

     $data =array();
     $rows = $ob->num_reg;
     $message = $ob->message;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }
  unset($ob);
});

//new list
$app->post('/list','authenticate', function () use ($app) {

  $data = $app->request()->post();

  $ob = new models\Lists();

  

  if(!empty($data["id_user"]) && isInteger($data["id_user"]) ){

      $data["nombre_lista"] = cleanValues($data["nombre_lista"]);
      $data["campos_extras"]  = cleanValues($data["campos_extras"]);

      $data = $ob->insertList($data);
      $rows = $ob->num_reg;
      $message = $ob->message;

      if($rows==0){

        echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

      }else{

        echo '{"reponse": "1", "rows": '.$rows.', "result": ['.json_encode($data).'], "message":"'.$message.'"}';

      }
      

  } else {

     $data =array();
     $rows = $ob->num_reg;
     $message = $ob->message2;
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }
  unset($ob);
});