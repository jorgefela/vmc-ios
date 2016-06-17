<?php
use App\Model\LoginModel;
 

 

 $app->group('/access/', function () {
  $this->get('login', function ($req, $res, $args) {
        $login = $req->getParam('login'); 
        $pass = $req->getParam('pass');
        $lm = new LoginModel;
 
         
          return $res
           ->withHeader('Content-type', 'application/json')
           ->getBody()
           ->write(
            json_encode(
                $lm->GetValLogin($login,$pass)
            )
            );

    });

 });



