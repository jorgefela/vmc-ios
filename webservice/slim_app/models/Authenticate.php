<?php

namespace models;
use lib\Core;
use PDO;
use lib\Config;

class Authenticate  {

	public $keyRemote = null;
	public $keyDate = null;
	protected $security;

	function __construct() {

		$this->security = \lib\Core::getInstance();
		$this->keyDate = date("m.d.y");

	}

	public function createKey($email){
		$app      = \Slim\Slim::getInstance();
		$prefix   = $this->security->prefix;
		$key      = $this->security->key;
		$date     = $this->keyDate;
		$ipVist   = $this->get_real_ip();
		$keyToken = $this->encryptVal($prefix.$key.$ipVist.$email.$date);
		$emailecr = $this->encryptVal($email);
		$timeSesion = $this->security->time_cookie;

		$app->setEncryptedCookie('uid', $prefix, $timeSesion);
		$app->setEncryptedCookie('uemail', $emailecr, $timeSesion);
		$app->setEncryptedCookie('key', $keyToken, $timeSesion);
		$this->keyRemote = $keyToken;
		
	}

	public function cleanKey(){

		$app = \Slim\Slim::getInstance();

		$this->keyRemote = null;
		
		$app->setEncryptedCookie('uid', '', '0.01 minutes');
		$app->setEncryptedCookie('uemail', '', '0.01 minutes');
		$app->setEncryptedCookie('key', '', '0.01 minutes');
		
	}

	public function updateKeyLocal($uid, $uem, $key){

		$app = \Slim\Slim::getInstance();

		$timeSesion = $this->security->time_cookie;

		$app->setEncryptedCookie('uid', $uid, $timeSesion);
		$app->setEncryptedCookie('uemail', $uem, $timeSesion);
		$app->setEncryptedCookie('key', $key, $timeSesion);

	}


	public function authenticate(\Slim\Route $route) {

		$app = \Slim\Slim::getInstance();
		$uid = $app->getEncryptedCookie('uid');
		$uem = $app->getEncryptedCookie('uemail');
		$key = $app->getEncryptedCookie('key');

		if ($this->validateUserKey($uid, $key, $uem) === false ) {
			$app->halt(401);
		}else{
			$this->updateKeyLocal($uid, $uem, $key);
		}

	}

	public function getKey() {

		return $this->keyRemote;

	}

	public function validateUserKey($uid, $key, $uem) {

		$app = \Slim\Slim::getInstance();

		$prefix    = $this->security->prefix;
		$dkey      = $this->security->key;
		$date      = $this->keyDate;
		$ipVist    = $this->get_real_ip();
		$dkeyToken = $this->decryptVal($key);
		$email     = $this->decryptVal($uem);
		$remoteKey = $app->request()->headers()->get('key');
		$dRemotKey = $this->decryptVal($remoteKey);


		if ( ($uid === $prefix) && ($dkeyToken === $prefix.$dkey.$ipVist.$email.$date) && ($dRemotKey === $prefix.$dkey.$ipVist.$email.$date) ) {

			return true;

		} else {

			return false;

		}
	}

	public function encryptVal($val) {

		$key = $this->security->secret;

		$encrypted = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($key), $val, MCRYPT_MODE_CBC, md5(md5($key))));

		return $encrypted; 

	}

	public function decryptVal($val) {

        $key = $this->security->secret;
		$decrypted = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5($key), base64_decode($val), MCRYPT_MODE_CBC, md5(md5($key))), "\0");

		return $decrypted;

	}

	public function get_real_ip() {

		if (isset($_SERVER["HTTP_CLIENT_IP"])) {

            return $_SERVER["HTTP_CLIENT_IP"];

        } elseif (isset($_SERVER["HTTP_X_FORWARDED_FOR"])) {

            return $_SERVER["HTTP_X_FORWARDED_FOR"];

        } elseif (isset($_SERVER["HTTP_X_FORWARDED"])) {

            return $_SERVER["HTTP_X_FORWARDED"];

        } elseif (isset($_SERVER["HTTP_FORWARDED_FOR"])) {

            return $_SERVER["HTTP_FORWARDED_FOR"];

        } elseif (isset($_SERVER["HTTP_FORWARDED"])) {

            return $_SERVER["HTTP_FORWARDED"];

        } else {

            return $_SERVER["REMOTE_ADDR"];

        }
 
    }
}