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
		} else {
			$r = 0;
		}
		$stmt=null;		
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
		} else {
			$r = 0;
		}
		$stmt=null;		
		return $r;
	}

	public function getEmailFromTo($id_user, $from, $to) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_email WHERE userid =:id LIMIT :pagFrom , :pagTo";
		$stmt=$this->core->dbh->prepare($sql);
		$stmt->bindParam(':id', $id_user, PDO::PARAM_INT);	
		$stmt->bindValue(':pagFrom', (int) trim($from), PDO::PARAM_INT);	
		$stmt->bindValue(':pagTo', (int) trim($to), PDO::PARAM_INT);

		if ($stmt->execute()) {
			$r=$stmt->fetchAll(PDO::FETCH_ASSOC);
			$stmt->closeCursor();
		} else {
			$r = 0;
		}
		$stmt=null;		
		return $r;
	}

}
?>