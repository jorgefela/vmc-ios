<?php
$app->get('/user/:id_user/videos','authenticate', function ($id_user) use ($app) {

	//$data = $app->request()->post();

  $app->contentType('application/json');

  if(!empty($id_user) && isInteger($id_user) ){

      $ob = new models\Video();
      $data = $ob->getVideoLibrary($id_user);
      echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else{

     $data =array();
     echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }


});


//range for paging videos
$app->get('/user/:id_user/videos/from/:from/to/:to','authenticate', function ($id_user, $from, $to) use ($app) {

  $app->contentType('application/json');

  if(!empty($id_user) && isInteger($id_user) && (!empty($from) && isInteger($from) || $from==0) && !empty($to) && isInteger($to) ){

      $ob = new models\Video();
      $data = $ob->getVideoLibraryFromTo($id_user, $from, $to);
      echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  } else {

     $data =array();
     echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }

});