<?php
// Application middleware

// e.g: $app->add(new \Slim\Csrf\Guard);
$mw = function ($request, $response, $next) {
	$app = new \Slim\App;
	$user = '';
	$pass = '';
 
 
$user = $request->getHeaderLine('username');
$pass = $request->getHeaderLine('password');
//$pass = sha1($pass);
 
 
 
    //$response->getBody()->write('ANTES'.$user);
    $response = $next($request, $response);
    //$response->getBody()->write('DESPUES');

    return $response;
};
