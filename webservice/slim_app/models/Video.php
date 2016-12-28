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
		


		if(\lib\Core::isInteger($id_user)){

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

	public function SubirVideoLibrary($id_user, $nombre, $archivo_video, $archivo_imagen) {

		$insert = false;
		$r=array();	
		$ruta = getcwd();
		//$aRuta = explode("public", $ruta);
		$aRuta = explode("api", $ruta);

		$target_dir = $aRuta[0]."app/Uploads/videos/";
		$target_dir_imagen = $aRuta[0]."app/Uploads/images/";
		$nombre_archivos = $this->getString($id_user);
		$nombre_video = $nombre_archivos.".mp4";
		$nombre_imagen = $nombre_archivos.".jpg";
		//$target_dir = $target_dir . basename($_FILES["uploadFile"]["name"]);
		$target_dir = $target_dir . $nombre_video;
		$target_dir_imagen = $target_dir_imagen . $nombre_imagen;
		
		//$_FILES["uploadFile"]["tmp_name"]
		if (move_uploaded_file($archivo_video, $target_dir)) {
			$this->message = "Success ".$target_dir;
			$this->num_reg = 1;
			$insert = true;
			if (move_uploaded_file($archivo_imagen, $target_dir_imagen)) {

			}
		} else {
			$this->message = "Sorry, there was an error uploading your file.";
			$this->num_reg = 0;
			$insert = false;
		}

		if($insert and \lib\Core::isInteger($id_user)){
			$fecha = date("Y-m-d H:i:s");

			$sql = "INSERT INTO `yr14_video` (userid, catid, v_type, name, file, btn_pos, primery_thumb, thumb,alt, description, status, shortUrl, created_date, trash_date)
			VALUE (
					".$id_user.",0,'mp4',
					'".$nombre."',
					'".$nombre_video."',
					'',
					'".$nombre_imagen."',
					'".$nombre_imagen."',
					'Click to play video',
					'',1,'urlcorta',
					'".$fecha."',
					'0000-00-00 00:00:00')";

			if ($result = mysqli_query($this->db, $sql)) {
				$idinsert = mysqli_insert_id($this->db);
				//var_dump("id: ".$idinsert);
				$r = $this->getVideoinsert($idinsert);

				$this->num_reg = 0;
				$this->message = "Success";

			}

		}

		return $r;
	}

	public function getString($id) {
		if(empty($id)) {
			$id = 0;
		}
		$caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
		$numerodeletras=10;
		$cadena = "";
		$time = time();
		$hora = date("d_m_Y_H_i_s", $time);
		for($i = 0; $i < $numerodeletras; $i++) {
			$cadena .= substr($caracteres,rand(0,strlen($caracteres)),1);
		}
		return "id_".$id."_".$cadena."_".$hora."_vmc";
	}

	public function getVideoinsert($id) {
		$r=array();	 
		


		if(\lib\Core::isInteger($id)){

			$sql = "SELECT * FROM `yr14_video` WHERE id = '".$id."' LIMIT 1";

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