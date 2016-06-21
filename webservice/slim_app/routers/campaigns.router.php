<?php
$app->get('/user/:id_user/campaigns(/:id)','authenticate', function ($id_user, $id=0) use ($app) {

  $app->contentType('application/json');

  if(!empty($id_user) && isInteger($id_user) && $id==0){

      $ob = new models\Campaigns();
      $data = $ob->getCampaigns($id_user);
      echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else if(!empty($id_user) && isInteger($id_user) && isInteger($id) && $id != 0){

    $ob = new models\Campaigns();
    $data = $ob->getCampaignsOnly($id);
    echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';

  }else{

     $data =array();
     echo '{"reponse": "1", "result": '.json_encode($data).', "message":"No records found"}';
      
  }

});