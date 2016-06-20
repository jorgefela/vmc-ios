<?php

namespace models;
use lib\Core;
use PDO;

class Login extends Authenticate {

	protected $core;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  parent::__construct();
	}

	public function getUserByLogin($email, $pass) {

		$r = array();

		if( !empty($email) and !empty($pass) ){
			$pass = md5($pass);
			$sql = "SELECT * FROM yr14_user WHERE email=:email AND password=:pass LIMIT 1";
			$stmt = $this->core->dbh->prepare($sql);
			$stmt->bindParam(':email', $email, PDO::PARAM_STR);
			$stmt->bindParam(':pass', $pass, PDO::PARAM_STR);

			if ($stmt->execute()) {
				$r = $stmt->fetchAll(PDO::FETCH_ASSOC);
				$stmt->closeCursor();
				$stmt=null;
				if( count($r) > 0 ) {
					parent::createKey($email);

				}else{
					parent::cleanKey();

				}

			} else {
				$stmt=null;
				parent::cleanKey();
				$r = false;
			}

		}	

		return $r;
	}
}