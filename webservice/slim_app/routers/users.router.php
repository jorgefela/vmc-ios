<?php
$app->post('/Users', function() use ($app) {

	$data = $app->request()->post();
	
	if(!empty($data['txt_name_first']) && !empty($data['txt_email']) ){

		$data['txt_name_first'] = cleanValues($data['txt_name_first']);
		$data['txt_name_last']  = cleanValues($data['txt_name_last']);
		$data['txt_email']      = cleanValues($data['txt_email']);
		$data['txt_phone']      = cleanValues($data['txt_phone']);

		if(empty($data['txt_name_last'])){
			$data['txt_name_last'] = "";
		}
		if(empty($data['txt_phone'])){
			$data['txt_phone'] = 0;
		}

		$ob = new models\Users();
		$result = $ob->insertUsersNew($data);
		$message = $ob->message;
		echo '{"reponse": "1", "result": '.json_encode($result).', "message":"'.$message.'"}';

		
		
	}else{
		$message = $ob->message;
		echo '{"reponse": "1", "result": "0", "message":"'.$message.'"}';

	}

	
});

