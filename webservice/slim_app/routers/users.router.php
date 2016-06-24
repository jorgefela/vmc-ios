<?php
$app->post('/Users', function() use ($app) {

	$data = array(
		           'name'=>'daniel',
		           'email'=>'danies@gmail.com',
		           'password'=>'1234',
		           'role'=>'usuario');

	$ob = new models\Users();
    $data = $ob->insertUsers('');
    echo '{"reponse": "1", "result": '.json_encode($data).', "message":""}';
});

