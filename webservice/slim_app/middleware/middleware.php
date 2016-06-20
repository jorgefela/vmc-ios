<?php
function authenticate(\Slim\Route $route) {
  $ob = new models\Authenticate();
  $ob->authenticate($route);
}