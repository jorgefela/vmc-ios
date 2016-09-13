<?php
// campaigns user and a single campaigns
$app->get('/user/:id_user/email/:id_email/campaigns(/:id)','authenticate', function ($id_user, $id_email, $id=0) use ($app) {

  $app->contentType('application/json');
  $rows = 0;
  $message = "No records found";

  if(!empty($id_user) && isInteger($id_user) && isInteger($id_email) && $id==0){

      $ob = new models\Campaigns();
      $data = $ob->getCampaigns($id_user, $id_email);
      $rows = $ob->num_reg;
      $message = $ob->message;
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else if(!empty($id_user) && isInteger($id_user) && isInteger($id) && $id != 0){

    $ob = new models\Campaigns();
    $data = $ob->getCampaignsOnly($id_user, $id);
    echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  }else{

     $data =array();
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }

});

//range for paging
$app->get('/user/:id_user/campaigns/from/:from/to/:to','authenticate', function ($id_user, $from, $to) use ($app) {

  $app->contentType('application/json');
  $rows = 0;
  $message = "No records found";

  if(!empty($id_user) && isInteger($id_user) && (!empty($from) && isInteger($from) || $from==0) && !empty($to) && isInteger($to) ){

      $ob = new models\Campaigns();
      $data = $ob->getCampaignsFromTo($id_user, $from, $to);
      echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';

  } else {

     $data =array();
     echo '{"reponse": "1", "rows": '.$rows.', "result": '.json_encode($data).', "message":"'.$message.'"}';
      
  }

});