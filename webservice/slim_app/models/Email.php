<?php
namespace models;

use lib\Core;
use PDO;

class Email extends Database {

	protected $core;
	public $db;
	public $num_reg = 0;

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->db=parent::connect_db();
	}

	public function getEmailOnly($id_user, $id, $full_data) {
		$r=array();
		

		if(\lib\Core::isInteger($id_user) and \lib\Core::isInteger($id)){

			$campos = "id, userid, catid, title, from_name, from_email, subject,send_date, status, shortUrl, created_date";

			if(!empty($full_data) and $full_data=="full"){

				$campos = "*";

			}

			$sql = "SELECT ".$campos." FROM yr14_email WHERE id = ".$id." AND userid =".$id_user." AND status = 1 ";

			if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);
				
				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
					$r[] = $row;
				}
				mysqli_free_result($result);
				$result = null;

			}
		}
		return $r;
	}

	public function getEmail($id_user, $full_data) {
		$r=array();	

		if(\lib\Core::isInteger($id_user)){

			$campos = "id, userid, catid, title, from_name, from_email, subject,send_date, status, shortUrl, created_date";

			if(!empty($full_data) and $full_data=="full"){

				$campos = "*";

			}

			$sql = "SELECT ".$campos." FROM yr14_email WHERE userid =".$id_user." AND status = 1 ORDER BY id DESC";

			if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);

				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
					$r[] = $row;
				}
				mysqli_free_result($result);
				$result = null;

			}
		}

		return $r;
	}

	public function getEmailFromTo($id_user, $from, $to, $full_data) {
		$r=array();	

		if(\lib\Core::isInteger($id_user)){

			$campos = "id, userid, catid, title, from_name, from_email, subject,send_date, status, shortUrl, created_date";

			if(!empty($full_data) and $full_data=="full"){

				$campos = "*";

			}

			$sql = "SELECT ".$campos." FROM yr14_email WHERE userid =".$id_user." AND status = 1 LIMIT ".$from." , ".$to."";

			if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);

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