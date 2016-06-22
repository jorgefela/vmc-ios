<?php
namespace models;

use lib\Core;
use PDO;

class Campaigns {

	protected $core;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	}

	public function getCampaignsOnly($id) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_email_campaign WHERE id_camp=:id LIMIT 1";
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

	public function getCampaigns($id_user) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_email_campaign WHERE user_id=:id";
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

	public function getCampaignsFromTo($id_user, $from, $to) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_email_campaign WHERE user_id =:id LIMIT :pagFrom , :pagTo";
		$stmt=$this->core->dbh->prepare($sql);
		$stmt->bindParam(':id', $id_user, PDO::PARAM_INT);	
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