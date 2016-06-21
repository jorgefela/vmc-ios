<?php
namespace models;

use lib\Core;
use PDO;

class Contacts {

	protected $core;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	}

	public function getContactsOnly($id) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_contact WHERE id=:id LIMIT 1";
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

	public function getContacts($id_user) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_contact WHERE userid =:id";
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

	public function getContactsList($id_user, $id_list) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_contact WHERE userid =:idu AND list =:idl";
		$stmt=$this->core->dbh->prepare($sql);
		$stmt->bindParam(':idu', $id_user, PDO::PARAM_INT);	
		$stmt->bindParam(':idl', $id_list, PDO::PARAM_INT);	

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