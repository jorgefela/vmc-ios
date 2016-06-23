<?php
namespace models;

use lib\Core;
use PDO;

class Lists {

	protected $core;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	}

	public function getListsOnly($id) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_list WHERE id=:id LIMIT 1";
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

	public function getLists($id_user) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_list WHERE userid =:id";
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

	public function getListsFromTo($id_user, $from, $to) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_list WHERE userid=:userid LIMIT :pagFrom , :pagTo";
		$stmt=$this->core->dbh->prepare($sql);
		$stmt->bindParam(':userid', $id_user, PDO::PARAM_INT);
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