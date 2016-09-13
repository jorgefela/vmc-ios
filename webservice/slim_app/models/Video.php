<?php
namespace models;
use lib\Core;
use PDO;
class Video extends Database {

	protected $core;
	public $db;
	public $num_reg = 0;
	public $message = "No records found";

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->db=parent::connect_db();
	}

	public function getVideoLibrary($id) {
		$r=array();	 

		

		if(\lib\Core::isInteger($id) and \lib\Core::isInteger($id)){

			$sql = "SELECT * FROM `yr14_video` WHERE userid='".$id."'";

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

	public function getVideoLibraryFromTo($id_user, $from, $to) {
		$r=array();	 
		


		if(\lib\Core::isInteger($id_user) and \lib\Core::isInteger($id_user)){

			$sql = "SELECT * FROM `yr14_video` WHERE userid='".$id_user."' LIMIT '".$from."' , '".$to."'";

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