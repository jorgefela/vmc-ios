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
		//$sql = "SELECT * FROM yr14_email_track WHERE mail_id=:userid LIMIT 20000";
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
}
?>