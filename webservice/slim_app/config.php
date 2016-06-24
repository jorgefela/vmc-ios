<?php

use lib\Config;

// DB Config
if($_SERVER['HTTP_HOST']=="localhost:8888" || $_SERVER['HTTP_HOST']=="localhost") {
	Config::write('db.host',     'localhost');
	Config::write('db.port',     '');
	Config::write('db.basename', 'vmctechn_vmc_2014');
	Config::write('db.user',     'root');
	Config::write('db.password', 'root');
} else {
	Config::write('db.host',     'localhost');
	Config::write('db.port',     '');
	Config::write('db.basename', 'vmctechn_vmc_2014');
	Config::write('db.user',     'vmctechn_vmc2014');
	Config::write('db.password', 'Rh4#n;SiyZZ$');

}

// cookie autenticate
Config::write('timeCookie', '30 minutes');
Config::write('secret',     '5WLf8JgbbaoglFnVSjKh');
Config::write('prefix',     'vmc');
Config::write('key',        '7DFTm9BIrnUMkgDQuACX');
Config::write('key_vmc_web','');

//get the dynamic route
$url="http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$url=explode('public/', $url);

// Project Config
Config::write('path', $url[0]);