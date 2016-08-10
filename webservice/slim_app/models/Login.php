<?php

namespace models;
use lib\Core;
//use lib\DB;
use PDO;

class Login extends Authenticate {

	protected $core;
	public $db;
	public $num_reg = 0;
	public $message = "No records found";

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  parent::__construct();
	  $this->db=parent::connect_db();
	}


	public function getUserByLogin($email, $pass) {

		$r = array();

		if( !empty($email) and !empty($pass) ){
			$pass = md5($pass);
			$role = "user";

			$sql = "SELECT * FROM yr14_user WHERE email='".$email."' AND password='".$pass."' AND role='user' LIMIT 1";

			if ($result = mysqli_query($this->db,$sql)) {

				$this->num_reg = mysqli_num_rows($result);


				$r = mysqli_fetch_array($result, MYSQLI_ASSOC);


				if( $this->num_reg > 0 ) {

					$this->message = "Success";

					parent::createKey($email);

				}else{

					parent::cleanKey();

				}
				mysqli_free_result($result);
				$result = null;

			} else {
				
				parent::cleanKey();
				$r = false;
			}

		}	

		$stmt=null;
		return $r;
	}


}