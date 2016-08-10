<?php
namespace models;

use lib\Core;
use PDO;

class Campaigns extends Database {

	protected $core;
	public $db;
	public $num_reg = 0;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->db=parent::connect_db();
	}

	public function getCampaignsOnly($id_user, $id) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_email_campaign WHERE id_camp=:id LIMIT 1";
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

	public function getCampaigns($id_user, $id_email) {
		$r=array();	 
		
		$sql = "SELECT * FROM yr14_email_campaign WHERE user_id=:id";
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
		} else {
			$r = 0;
		}
		$stmt=null;		
		return $r;
	}
}
?>