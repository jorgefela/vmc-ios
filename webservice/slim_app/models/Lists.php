<?php
namespace models;

use lib\Core;
use PDO;

class Lists  extends Database {

	protected $core;
	public $db;
	public $num_reg = 0;
	public $message = "No records found";
	public $message2 = "Failed to create contact";

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->db=parent::connect_db();
	}

	public function getListsOnly($id, $id_user) {
		$r=array();	 
		
		if( \lib\Core::isInteger($id) && \lib\Core::isInteger($id_user) ){
			$sql = "SELECT
			          f.id,
			          f.name,
			          (SELECT count(*) AS reg FROM `yr14_contact` AS r WHERE  r.`status` = 1 AND f.`id` = r.`list` AND f.`userid` = r.`userid`) AS n_subcriber
		            FROM `yr14_list` AS f 
		            WHERE 1 = f.`status` AND f.`id` = ".$id." AND ".$id_user." = f.`userid`";

		    if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);

				if($this->num_reg > 0){
					$this->message = "Success";
				}
				
				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
					$r[] = $row;
				}
				mysqli_free_result($result);
				$result = null;
			}

		}
		

		return $r;

	}

	public function getLists($id_user) {
		$r=array();

		if( \lib\Core::isInteger($id_user) ){
			/*$sql = "SELECT
			          f.id,
			          f.name,
			          (SELECT count(*) AS reg FROM `yr14_contact` AS r WHERE  r.`status` = 1 AND f.`id` = r.`list` AND f.`userid` = r.`userid`) AS n_subcriber
		            FROM `yr14_list` AS f 
		            WHERE 1 = f.`status` AND ".$id_user." = f.`userid`";*/
		    $sql = "SELECT
			          f.id,
			          f.name
		            FROM `yr14_list` AS f 
		            WHERE 1 = f.`status` AND ".$id_user." = f.`userid` ORDER BY f.name";

			if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);


				if($this->num_reg > 0){
					$this->message = "Success";
				}
				
				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {

					//$cantReg = "0";

					$cantReg = $this->getTotalContacList($id_user, $row["id"]);
					
					$r[] = array(
						         'id' => $row["id"], 
						         'name' => $row["name"], 
						         'n_subcriber' => $cantReg 
						         );
				}
				mysqli_free_result($result);
				$result = null;

			}

		}
			
		return $r;
	}

	public function getListsFromTo($id_user, $from, $to) {
		$r=array();

		if( \lib\Core::isInteger($id_user) && \lib\Core::isInteger($from) && \lib\Core::isInteger($to) ){
			$sql = "SELECT
			          f.id,
			          f.name,
			          (SELECT count(*) AS reg FROM `yr14_contact` AS r WHERE  r.`status` = 1 AND f.`id` = r.`list` AND f.`userid` = r.`userid`) AS n_subcriber
		            FROM `yr14_list` AS f 
		            WHERE 1 = f.`status` AND ".$id_user." = f.`userid` 
		            LIMIT ".$from.",".$to."";

		    if ($result = mysqli_query($this->db, $sql)) {

				$this->num_reg = mysqli_num_rows($result);

				if($this->num_reg > 0){
					$this->message = "Success";
				}
				
				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {

					$r[] = $row;
				}
				mysqli_free_result($result);
				$result = null;

			}

		}
				
		return $r;
	}

	public function insertList($data) {
		$r=array();
		$id = 0;

		if( \lib\Core::isInteger($data["id_user"]) ){
			$sql = "INSERT INTO yr14_list (
			                                userid,
			                                name,
			                                created_date
			                                )
			                         VALUE (
			                                ".$data["id_user"].",
			                                '".$data["nombre_lista"]."',
			                                '".date("Y-m-d H:i:s")."'
			                         )";

		    if ( mysqli_query($this->db, $sql) ) {

				//$this->num_reg = mysqli_num_rows($result);
				$id = mysqli_insert_id($this->db);

				$this->insertFieldList($id, $data);
				$this->num_reg = 1;
				$this->message = "Success";
				
				$r["id"] = $id;

			}

		}
				
		return $r;
	}

	public function insertFieldList($id, $data) {


		if( \lib\Core::isInteger($data["id_user"]) ){

			$fielnameArray = explode("||", $data["campos_extras"]);
			$cantCampos =  count($fielnameArray);
			$values = "";
			$control_name='';

			if($cantCampos > 0){

				for($i = 0; $i < $cantCampos; $i++){

					if($i == $cantCampos - 1){

						$sep = "";

					}else{

						$sep = ", ";

					}

					$control_name = trim($fielnameArray[$i]);
					$control_name = str_replace(' ', '_', $control_name);
					$control_name = substr($control_name,0,-1);

					if($control_name=="WHERE" || $control_name=="where"){
						$control_name = $control_name."R";
					}

					$control_name =	\lib\Core::limpiaSimbolosEspeciales($fielnameArray[$i]);
					$values .= "('".$data["id_user"]."', '".$id."', '".trim($fielnameArray[$i])."', '".trim($control_name)."', 'text')".$sep;

				}//fin for camposExtras

				$sql = "INSERT INTO yr14_contact_field (userid, listid, field_name, control_name, field_type ) VALUE ".$values."";

				if (mysqli_query($this->db, $sql)) {

					$this->num_reg = 1;
					$this->message = "Success";


				}else{

					$this->message = "Failed to create extra fields";

				}

			}//fin validar $cantCampos > 0


		}
	}

	public function getTotalContacList($id_user, $id_list){
		$sql = "SELECT count(*) AS reg FROM `yr14_contact` AS r WHERE r.`status` = 1 AND  ".$id_list." = r.`list` AND ".$id_user." = r.`userid` LIMIT 1";
		$count = 0;

			if ($result = mysqli_query($this->db, $sql)) {

				$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
				$count = $row["reg"];
				mysqli_free_result($result);
				$result = null;
			}

		return $count;

	}
}
?>