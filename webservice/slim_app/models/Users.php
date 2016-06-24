<?php
namespace models;
use lib\Core;
use PDO;
class Users {

	protected $core;
	public $message;
	public $pass_sn_code;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	}

	public function insertUsersNew($data) {
	
		try {

			$sql = "INSERT INTO 
			     yr14_user (
			                password,
			                name,
			                lname,
			                email,
			                contact,
			                plan,
			                price
			                ) 
					VALUES (
					        :txt_password,
					        :txt_name_first,
					        :txt_name_last,
					        :txt_email,
					        :txt_phone,
					        'Trial',
					        '0'
					        )";

			$stmt = $this->core->dbh->prepare($sql);

			if ( $stmt->execute($data) ) {

				$this->message = "record inserted correctly";
				$stmt->closeCursor();

				return $this->core->dbh->lastInsertId();

			} else {

				$this->message = "Error inserting the record.";
				$stmt->closeCursor();
				
				return false;

			}

			$stmt = null;

		} catch(PDOException $e) {

			$stmt = null;
        	$this->message = $e->getMessage();

    	}
		
	}

	public function setPasswordSnCode($password){
		$this->pass_sn_code = $password;

	}
}
?>