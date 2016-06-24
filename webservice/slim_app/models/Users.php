<?php
namespace models;
use lib\Core;
use PDO;
class Users {

	protected $core;
	public $message;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->core->dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
	}

	public function insertUsersNew($data) {
	
		try {

			$sql = "INSERT INTO 
			     yr14_user (
			                name,
			                lname,
			                email,
			                contact,
			                plan,
			                price
			                ) 
					VALUES (
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
				$stmt = null;
				return $this->core->dbh->lastInsertId();

			} else {

				$this->message = "Error inserting the record.";
				$stmt = null;
				return false;

			}

		} catch(PDOException $e) {

			$stmt = null;
        	$this->message = $e->getMessage();

    	}
		
	}
}
?>