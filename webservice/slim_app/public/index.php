<?php
ini_set('max_execution_time', 500);
set_time_limit(500);
session_cache_limiter(false);
session_start();
require '../middleware/middleware.php';
require '../vendor/autoload.php';
require '../config.php';


$app = new \Slim\Slim(array(
    'debug' => true,
));

// Automatically load router files
$routers = glob('../routers/*.router.php');
foreach ($routers as $router) {
    require $router;
}
$app->run();