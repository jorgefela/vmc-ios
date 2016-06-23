<?php

namespace lib;

use lib\Config;
use PDO;

class Core {
    public $dbh; // handle of the db connexion
    public $secret;
    public $prefix;
    public $key;
    public $time_cookie;
    private static $instance;

    private function __construct() {
        // building data source name from config
        $dsn = 'mysql:host=' . Config::read('db.host') .
               ';dbname='    . Config::read('db.basename') .
               ';port='      . Config::read('db.port') .
               ';connect_timeout=15';
        // getting DB user from config                
        $user = Config::read('db.user');
        // getting DB password from config                
        $password = Config::read('db.password');

        $this->dbh = new PDO($dsn, $user, $password);
        $this->dbh->exec("set names utf8");

        // getting DB keys cookies from config 
        $this->secret = Config::read('secret');
        $this->prefix = Config::read('prefix');
        $this->key    = Config::read('key');
        $this->time_cookie=Config::read('timeCookie');
    }

    public static function getInstance() {
        if (!isset(self::$instance))
        {
            $object = __CLASS__;
            self::$instance = new $object;
        }
        return self::$instance;
    }
    
    // others global functions
}