<?php

use lib\Config;

// DB Config
Config::write('db.host', 'localhost');
Config::write('db.port', '');
Config::write('db.basename', 'vmctechn_vmc_2014');
Config::write('db.user', 'root');
Config::write('db.password', 'root');

// cookie autenticate
Config::write('timeCookie', '30 minutes');

//get the dynamic route
$url="http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$url=explode('public/', $url);

// Project Config
Config::write('path', $url[0]);