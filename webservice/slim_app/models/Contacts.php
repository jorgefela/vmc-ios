<?php
namespace models;

use lib\Core;
use PDO;

class Contacts extends Database {

	protected $core;
	public $db;
	public $num_reg = 0;
	public $message = "No records found";
	public $message2 = "Error creating list";
	public $message3 = "Error update contact";

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->db=parent::connect_db();
	}



	public function insertContact($data) {
		$r=array();
		$id = 0;

		if( \lib\Core::isInteger($data["id_user"]) ){
			$sql = "INSERT INTO yr14_contact (
			                                    userid,
			                                    list,
			                                    name,
			                                    lname,
			                                    org_name,
			                                    job_title,
			                                    email,
			                                    contact,
			                                    address,
			                                    unit,
			                                    city,
			                                    state,
			                                    zip_code,
			                                    photo,
			                                    status,
			                                    unsubscribe,
			                                    created_date
			                                )
			                         VALUE (
			                                ".$data["id_user"].",
			                                '".$data["id_list"]."',
			                                '".$data["nombre"]."',
			                                '".$data["lnombre"]."',
			                                '',
			                                '',
			                                '".$data["email"]."',
			                                '".$data["telefono"]."',
			                                '',
			                                '',
			                                '',
			                                '',
			                                '',
			                                '',
			                                '1',
			                                '0',
			                                '".date("Y-m-d H:i:s")."'
			                         )";

		    if ( mysqli_query($this->db, $sql) ) {

				//$this->num_reg = mysqli_num_rows($result);
				$id = mysqli_insert_id($this->db);
				$cant = $this->getTotalContacLista($data["id_user"], $data["id_list"]);
				$this->num_reg = 1;
				$this->message = "Success";
				$r["id"] = $id;
				$r["n_subcriber"] = $cant;

			}

		}
				
		return $r;
	}


	public function getTotalContacLista($id_user, $id_list){
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

	public function getContacts($id_user){
		
		$r=array();	 
		
		if( \lib\Core::isInteger($id_user) ){
			echo $sql = "SELECT 
			                   id,
			                   userid,
			                   list,
			                   name,
			                   lname,
			                   org_name,
			                   job_title,
			                   email,
			                   contact,
			                   address,
			                   unit,
			                   city,
			                   state,
			                   zip_code,
			                   photo,
			                   status,
			                   unsubscribe,
			                   created_date
			             FROM `yr14_contact` AS r 
			             WHERE r.`status` = 1 
			             AND ".$id_user." = r.`userid` ";

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

	public function getContactsOnly($id, $id_user){
		
		$r=array();	 
		
		if( \lib\Core::isInteger($id) && \lib\Core::isInteger($id_user)){
			$sql = "SELECT 
			               id,
			               userid,
			               list,
			               name,
			               lname,
			               org_name,
			               job_title,
			               email,
			               contact,
			               address,
			               unit,
			               city,
			               state,
			               zip_code,
			               photo,
			               status,
			               unsubscribe,
			               created_date 
			        FROM `yr14_contact`
			        WHERE status = 1  
			        AND ".$id." = id 
			        AND userid = ".$id_user." 
			        LIMIT 1";

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

	public function getContactsList($id_user, $id_list){
		
		$r=array();	 
		
		if( \lib\Core::isInteger($id_list) && \lib\Core::isInteger($id_user) ){
			$sql = "SELECT 
			               id,
			               userid,
			               list,
			               name,
			               lname,
			               org_name,
			               job_title,
			               email,
			               contact,
			               address,
			               unit,
			               city,
			               state,
			               zip_code,
			               photo,
			               status,
			               unsubscribe,
			               created_date
			        FROM `yr14_contact` AS r
			        WHERE r.`status` = 1 
			        AND  ".$id_list." = r.`list` 
			        AND ".$id_user." = r.`userid` ORDER BY email";

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

	public function getContactsListFromTo($id_user, $id, $from, $to){
		
		$r=array();	 
		
		if( \lib\Core::isInteger($id) && \lib\Core::isInteger($id_user) ){
			$sql = "SELECT 
			              id,
			              userid,
			              list,
			              name,
			              lname,
			              org_name,
			              job_title,
			              email,
			              contact,
			              address,
			              unit,
			              city,
			              state,
			              zip_code,
			              photo,
			              status,
			              unsubscribe,
			              created_date 
			        FROM `yr14_contact` 
			        WHERE status = 1 
			        AND ".$id_list." = list 
			        AND ".$id_user." = userid LIMIT ".$from.",".$to;

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

	public function updateContact($data) {
		$r=array();
		$id = 0;

		if( \lib\Core::isInteger($data["id_user"]) ){
			$sql = "UPDATE 
			          yr14_contact 
			        set name = '".$data["nombre"]."',
			            lname = '".$data["lnombre"]."',
			            email = '".$data["email"]."',
			            contact = '".$data["telefono"]."'
			        WHERE id = ".$data["id"]."
			        AND userid = ".$data["id_user"]."
			      ";

		    if ( mysqli_query($this->db, $sql) ) {

				//$this->num_reg = mysqli_num_rows($result);
				$id = mysqli_insert_id($this->db);
				$this->num_reg = 1;
				$this->message = "Success";
				$r["id"] = $data["id"];
			}

		}
				
		return $r;
	}
}
?>