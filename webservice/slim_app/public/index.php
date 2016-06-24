<?php
require '../middleware/middleware.php';
require '../vendor/autoload.php';
require '../config.php';


$app = new \Slim\Slim(array(
    'debug' => false,
));

// Automatically load router files
$routers = glob('../routers/*.router.php');
foreach ($routers as $router) {
    require $router;
}
$app->run();