<?php
namespace models;
use lib\Core;
use PDO;
class Video {

	protected $core;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	}

	public function getVideoLibrary($id) {
		$r=array();	 

		$sql = "SELECT * FROM `yr14_video` WHERE userid=:userid";
		$stmt=$this->core->dbh->prepare($sql);
		$stmt->bindParam(':userid', $id, PDO::PARAM_INT);	

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

	public function getVideoLibraryFromTo($id_user, $from, $to) {
		$r=array();	 
		
		$sql = "SELECT * FROM `yr14_video` WHERE userid=:userid LIMIT :pagFrom , :pagTo";
		$stmt=$this->core->dbh->prepare($sql);
		$stmt->bindParam(':userid', $id_user, PDO::PARAM_INT);
		$stmt->bindValue(':pagFrom', (int) trim($from), PDO::PARAM_INT);	
		$stmt->bindValue(':pagTo', (int) trim($to), PDO::PARAM_INT);

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