<?php
$app->post('/Users', function() use ($app) {

	$data = $app->request()->post();

	if(!empty($data['txt_name_first']) && !empty($data['txt_email']) && validEmail($data['txt_email']) ){

		$passworSnCode = RandomString();
		$data['txt_password'] = md5($passworSnCode);
		$data['txt_name_first'] = cleanValues($data['txt_name_first']);
		$data['txt_name_last'] = cleanValues($data['txt_name_last']);
		$data['txt_email'] = cleanValues($data['txt_email']);
		$data['txt_phone'] = cleanValues($data['txt_phone']);
		

		$ob = new models\Users();
		
		$result = $ob->insertUsersNew($data);

		if(ctype_digit(strval($result))){
			$ob->setPasswordSnCode($passworSnCode);
			echo $ob->pass_sn_code;

		}
		
		$message = $ob->message;

		echo '{"reponse": "1", "result": '.$result.', "message":"'.$message.'"}';

	}else{

		$message = $ob->message;
		echo '{"reponse": "1", "result": "0", "message":"'.$message.'"}';

	}	
});