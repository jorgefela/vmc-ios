<?php
namespace models;
use lib\Core;
use PDO;
class Users {

	protected $core;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->core->dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
	}

	public function insertUsers($data) {
	
		try {
			$sql = "INSERT INTO yr14_user (name, email, password, role) 
					VALUES (:name, :email, :password, :role)";
			$stmt = $this->core->dbh->prepare($sql);
			if ($stmt->execute($data)) {
				return $this->core->dbh->lastInsertId();;
			} else {
				return '0';
			}
		} catch(PDOException $e) {
        	return $e->getMessage();
    	}
		
	}
}
?>