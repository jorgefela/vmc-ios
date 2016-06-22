<?php
namespace models;

use lib\Core;
use PDO;

class Email {

	protected $core;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	}

	public function getEmailOnly($id) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_email WHERE id=:id LIMIT 1";
		$stmt=$this->core->dbh->prepare($sql);
		$stmt->bindParam(':id', $id, PDO::PARAM_INT);	

		if ($stmt->execute()) {
			$r=$stmt->fetchAll(PDO::FETCH_ASSOC);
			$stmt->closeCursor();
			$stmt=null;
		} else {
			$stmt=null;
			$r = 0;
		}		
		return $r;
	}

	public function getEmail($id_user) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_email WHERE userid =:id";
		$stmt=$this->core->dbh->prepare($sql);
		$stmt->bindParam(':id', $id_user, PDO::PARAM_INT);	

		if ($stmt->execute()) {
			$r=$stmt->fetchAll(PDO::FETCH_ASSOC);
			$stmt->closeCursor();
			$stmt=null;
		} else {
			$stmt=null;
			$r = 0;
		}		
		return $r;
	}

}
?>