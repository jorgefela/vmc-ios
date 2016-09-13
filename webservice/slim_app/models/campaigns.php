<?php
namespace models;

use lib\Core;
use PDO;

class Campaigns extends Database {

	protected $core;
	public $db;
	public $num_reg = 0;
	public $message = "No records found";

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->db=parent::connect_db();
	}

	public function getCampaignsOnly($id_user, $id) {
		$r=array();	 
		
		
		if(\lib\Core::isInteger($id_user) and \lib\Core::isInteger($id_user)){

			$sql = "SELECT * FROM yr14_email_campaign WHERE id_camp='".$id."' LIMIT 1";

			if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);
				$this->message = "Success";
				
				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
					$r[] = $row;
				}
				mysqli_free_result($result);
				$result = null;

			}

		}
		return $r;
	}

	public function getCampaigns($id_user, $id_email) {
		$r=array();	 

		if(\lib\Core::isInteger($id_user) and \lib\Core::isInteger($id_user)){

			$sql = "SELECT * FROM yr14_email_campaign WHERE user_id='".$id_user."' AND id_email = '".$id_email."'";

			if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);
				$this->message = "Success";
				
				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
					$r[] = $row;
				}
				mysqli_free_result($result);
				$result = null;

			}

		}
		

		return $r;
	}

	public function getCampaignsFromTo($id_user, $from, $to) {
		$r=array();	
		
		

		if(\lib\Core::isInteger($id_user) and \lib\Core::isInteger($id_user)){

			$sql = "SELECT * FROM yr14_email_campaign WHERE user_id = '".$id_user."' LIMIT '".$from."' , '".$to."'";

			if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);
				$this->message = "Success";
				
				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
					$r[] = $row;
				}
				mysqli_free_result($result);
				$result = null;

			}

		}

		return $r;
	}
}
?>