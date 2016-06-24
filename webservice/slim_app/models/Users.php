<?php
namespace models;
use lib\Core;
use PDO;
class Users {

	protected $core;
	public $message;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	}

	public function insertUsersNew($data) {
	
		try {

			$sql = "INSERT INTO 
			     yr14_user ( 
			                password, name, lname, email, contact, plan, price 
			                ) 
					VALUES (
					        :password, :name, :lname, :email, :phone, :plan, :price 
					        )";
		    $password = $this->generatePassword();
		    $insertData = array(
                            "password" => md5($password),
                            "name"     => $data['txt_name_first'],
                            "lname"    => $data['txt_name_last'],
                            "email"    => $data['txt_email'],
                            "phone"    => $data['txt_phone'],
                            "plan"     => "Trial",
                            "price"    => 0
);

			$stmt = $this->core->dbh->prepare($sql);

			if ( $stmt->execute($insertData) ) {

				$this->message = "record inserted correctly";

				return $this->core->dbh->lastInsertId();

			} else {

				$this->message = "Error inserting the record.";
				$stmt->closeCursor();
				$stmt = null;
				
				return false;

			}

			

		} catch(PDOException $e) {

			$stmt = null;
        	$this->message = "Error inserting the record.";

    	}
		
	}

	public function generatePassword(){
		$randstring = "";
		$characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		for ($i = 0; $i < 6; $i++) {
			$randstring .= $characters[rand(0, strlen($characters))];
		}
		return $randstring;

	}


}
?>