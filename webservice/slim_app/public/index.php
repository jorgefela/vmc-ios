<?php
require '../vendor/autoload.php';
require '../config.php';
require '../middleware/middleware.php';

$app = new \Slim\Slim(array(
    'debug' => true,
));

// Automatically load router files
$routers = glob('../routers/*.router.php');
foreach ($routers as $router) {
    require $router;
}
$app->run();