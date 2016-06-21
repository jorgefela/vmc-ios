<?php
function authenticate(\Slim\Route $route) {
  $ob = new models\Authenticate();
  $ob->authenticate($route);
}

// validations
function isInteger($input){
    return(ctype_digit(strval($input)));
}

function cleanValues($value){

	$value = addslashes(cleanString($value)); 
	return $value;
}

function cleanString($valor)
{
	$valor = trim($valor);
    $valor = stripslashes($valor);
    $valor = htmlspecialchars($valor);
	$valor = str_ireplace("SELECT","",$valor);
	$valor = str_ireplace("select","",$valor);
	$valor = str_ireplace("COPY","",$valor);
	$valor = str_ireplace("copy","",$valor);
	$valor = str_ireplace("DELETE","",$valor);
	$valor = str_ireplace("delete","",$valor);
	$valor = str_ireplace("DROP","",$valor);
	$valor = str_ireplace("drop","",$valor);
	$valor = str_ireplace("DUMP","",$valor);
	$valor = str_ireplace("dump","",$valor);
	$valor = str_ireplace("TRUNCATE","",$valor);
	$valor = str_ireplace("truncate","",$valor);
	$valor = str_ireplace("INTO","",$valor);
	$valor = str_ireplace("into","",$valor);
	$valor = str_ireplace("UPDATE","",$valor);
	$valor = str_ireplace("update","",$valor);
	$valor = str_ireplace(" OR ","",$valor);
	$valor = str_ireplace(" or ","",$valor);
	$valor = str_ireplace(" UNION ","",$valor);
	$valor = str_ireplace(" union ","",$valor);
	//$valor = str_ireplace("%","",$valor);
	//$valor = str_ireplace("LIKE","",$valor);
	//$valor = str_ireplace("like","",$valor);
	$valor = str_ireplace("--","",$valor);
	$valor = str_ireplace("^","",$valor);
	//$valor = str_ireplace("[","",$valor);
	//$valor = str_ireplace("]","",$valor);
	//$valor = str_ireplace("\","",$valor);
	//$valor = str_ireplace("!","",$valor);
	//$valor = str_ireplace("¡","",$valor);
	//$valor = str_ireplace("?","",$valor);
	//$valor = str_ireplace("=","",$valor);
	//$valor = str_ireplace("&","",$valor);
	$valor = str_replace( '\\\'', '\'',$valor);
    $valor = str_replace( '\\\'', '\'',$valor);
	return $valor;
}

function validEmail($email){
    // First, we check that there's one @ symbol, and that the lengths are right
    if (!preg_match("/^[^@]{1,64}@[^@]{1,255}$/", $email)) {
        // Email invalid because wrong number of characters in one section, or wrong number of @ symbols.
        return false;
    }
    // Split it into sections to make life easier
    $email_array = explode("@", $email);
    $local_array = explode(".", $email_array[0]);
    for ($i = 0; $i < sizeof($local_array); $i++) {
        if (!preg_match("/^(([A-Za-z0-9!#$%&'*+\/=?^_`{|}~-][A-Za-z0-9!#$%&'*+\/=?^_`{|}~\.-]{0,63})|(\"[^(\\|\")]{0,62}\"))$/", $local_array[$i])) {
            return false;
        }
    }
    if (!preg_match("/^\[?[0-9\.]+\]?$/", $email_array[1])) { // Check if domain is IP. If not, it should be valid domain name
        $domain_array = explode(".", $email_array[1]);
        if (sizeof($domain_array) < 2) {
            return false; // Not enough parts to domain
        }
        for ($i = 0; $i < sizeof($domain_array); $i++) {
            if (!preg_match("/^(([A-Za-z0-9][A-Za-z0-9-]{0,61}[A-Za-z0-9])|([A-Za-z0-9]+))$/", $domain_array[$i])) {
                return false;
            }
        }
    }

    return true;
}