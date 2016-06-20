<?php

namespace models;
use lib\Core;
use PDO;
class Authenticate {

	public $secret = null;
	public $prefix = null;
	public $key    = null;
	public $keyRemote = null;

	function __construct() {

		$this->secret = "5WLf8JgbbaoglFnVSjKh";
		$this->prefix = "vmc";
		$this->key    = "7DFTm9BIrnUMkgDQuACX";
	}

	public function createKey($email){

		$app      = \Slim\Slim::getInstance();
		$prefix   = $this->prefix;
		$key      = $this->key;
		$ipVist   = $this->get_real_ip();
		$keyToken = $this->encryptVal($prefix.$key.$ipVist.$email);
		$emailecr = $this->encryptVal($email);

		$app->setEncryptedCookie('uid', $prefix, '10 minutes');
		$app->setEncryptedCookie('uemail', $emailecr, '10 minutes');
		$app->setEncryptedCookie('key', $keyToken, '10 minutes');

		$this->keyRemote = $keyToken;
		
	}

	public function cleanKey(){

		$app = \Slim\Slim::getInstance();
		$this->prefix = null;
		$this->key = null;
		$this->keyRemote = null;
		
		$app->setEncryptedCookie('uid', '', '0.01 minutes');
		$app->setEncryptedCookie('uemail', '', '0.01 minutes');
		$app->setEncryptedCookie('key', '', '0.01 minutes');
		
	}


	public function authenticate(\Slim\Route $route) {

		$app = \Slim\Slim::getInstance();
		$uid = $app->getEncryptedCookie('uid');
		$uem = $app->getEncryptedCookie('uemail');
		$key = $app->getEncryptedCookie('key');

		if ($this->validateUserKey($uid, $key, $uem) === false) {
			$app->halt(401);
		}

	}

	public function getKey() {

		return $this->keyRemote;

	}

	public function validateUserKey($uid, $key, $uem) {

		$prefix    = $this->prefix;
		$dkey      = $this->key;
		$ipVist    = $this->get_real_ip();
		$dkeyToken = $this->decryptVal($key);
		$email     = $this->decryptVal($uem);


		if ($uid == $prefix && $dkeyToken == $prefix.$dkey.$ipVist.$email) {

			return true;

		} else {

			return false;

		}
	}

	public function encryptVal($val) {

		$key = $this->secret;

		$encrypted = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($key), $val, MCRYPT_MODE_CBC, md5(md5($key))));

		return $encrypted; 

	}

	public function decryptVal($val) {
        $key = $this->secret;
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