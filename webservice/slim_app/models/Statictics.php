<?php
namespace models;
use lib\Core;
use PDO;
class Statictics extends Database {

	protected $core;
	public $db;
	public $num_reg = 0;
	public $message = "No records found";

	function __construct() {
	  $this->core = \lib\Core::getInstance();
	  $this->db=parent::connect_db();
	}

	public function getDataStatictics($id_user, $start_date, $categories){

		$r =  array();
		$count=0;
		$j=0;
		$delivery = 0;
		$opens = 0;
		$plays = 0;
		$click = 0;
		$bounces = 0;
		$spam = 0;
		$date_start = $start_date;
		$date_end = "";

		if(\lib\Core::isInteger($id_user) and \lib\Core::isInteger($categories) and \lib\Core::isFormatoFechaSencillo($start_date) ){
			$rUser = $this->getDataSubUserSendGrid($id_user);
			$obj = $this->getDataRemote($start_date, $categories, $rUser["sendgrid_user"], $rUser["sendgrid_pass"]);
			
			
			 foreach($obj as $obje)
			 {

			 	if(21 > $count){

			 		$delivery += $obje->stats[0]->metrics->delivered;
			 		$opens    += $obje->stats[0]->metrics->opens;
			 		$plays     = 0;
			 		$click    += $obje->stats[0]->metrics->clicks;
			 		$bounces  += $obje->stats[0]->metrics->bounces;
			 		$spam     += $obje->stats[0]->metrics->spam_reports;
			 		$date_end  = $obje->date;
			 		$count++;
			 	
			 	}else{
			 		break;
			 	}

         }
            if($count>0){
            	$this->num_reg = 1;
            	$this->message = "Success";
            }
            
		}

		$r =  array(
         	          "delivery"  =>$delivery,
         	          "opens"     =>$opens,
         	          "plays"     =>$plays,
         	          "click"     =>$click,
         	          "bounces"   =>$bounces,
         	          "spam"      =>$spam/*,
         	          "date_start"=>$date_start,
         	          "date_end"  =>$date_end,
         	          "reg"     =>$count*/
         	          );

		
		return $r;

	}



	public function getDataRemote($start_date, $categories, $subuser, $pass){

		$url = "?start_date=".$start_date."&categories=".$categories;

		$service_url = "https://api.sendgrid.com/v3/categories/stats".$url;

		$curl = curl_init($service_url);
		curl_setopt($curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		curl_setopt($curl, CURLOPT_USERPWD, "".$subuser.":".$pass."");
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "GET");
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		$response = curl_exec($curl);
		curl_close($curl);
		$obj = json_decode($response);
		return $obj;
	}

	private function getDataSubUserSendGrid($id_user){
		$r =  array();
		$sql = "SELECT sendgrid_id, sendgrid_user, sendgrid_pass FROM yr14_user WHERE id ='".$id_user."' LIMIT 1";
		
		if ($result = mysqli_query($this->db, $sql)) {
			//$this->num_reg = mysqli_num_rows($result);
			$r = mysqli_fetch_array($result, MYSQLI_ASSOC);
		}
		
		return $r;

	}
}
?>