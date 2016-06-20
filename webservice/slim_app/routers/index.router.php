<?php
$app->get('/', function () use ($app) {
    $app->halt(401);
});
