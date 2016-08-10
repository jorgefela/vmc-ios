<?php
namespace models;
use lib\Core;
use lib\Config;

class Database {

	public $dbx;

	private function __construct() {
	}

	static function connect_db() {
		$server = Config::read('db.host');
		$user = Config::read('db.user');
		$pass = Config::read('db.password');
		$database = Config::read('db.basename');
		$cn= mysqli_connect($server, $user, $pass, $database);
		mysqli_set_charset($cn,"utf8");
		return $cn;
	}
}
