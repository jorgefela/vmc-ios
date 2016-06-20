<?php

use lib\Config;

// DB Config
Config::write('db.host', 'localhost');
Config::write('db.port', '');
Config::write('db.basename', 'vmctechn_vmc_2014');
Config::write('db.user', 'root');
Config::write('db.password', 'root');

//
Config::write('timeCookie', '10 minutes');

// Project Config
Config::write('path', 'http://localhost:8888/SlimMVC');