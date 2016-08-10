<?php
namespace models;
use lib\Core;
use PDO;
use lib\Config;
class DB {
	public $db;

	private function __construct() {}

	static function connect_db() {
	$server = 'localhost'; // this may be an ip address instead
	$user = 'user';
	$pass = 'pass';
	$database = 'slim_db';
	//$connection = new mysqli($server, $user, $pass, $database);

	//return $connection;
	return "hola";
}



}
/*
function connect_db() {
	$server = 'localhost'; // this may be an ip address instead
	$user = 'user';
	$pass = 'pass';
	$database = 'slim_db';
	//$connection = new mysqli($server, $user, $pass, $database);

	//return $connection;
	return "hola";
}
*/

