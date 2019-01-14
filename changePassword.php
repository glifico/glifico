<?php
include 'functions.php';

$db = getDB();
if (! $db) exit();

if (isset ( $_GET ["user"] ) && isset ( $_GET ["password"] ) && isset ( $_GET ["token"] )) {
	$user = $_GET ["user"];
	$password = $_GET ["password"];
	$token = $_GET ["token"];
} else {
	exit ( json_encode ( array ("message" => "error: parameters not correctly setted","statuscode" => 400	) ) );
}

$query = "SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
$result = $db->query ( $query );
$row = $result->fetch ( PDO::FETCH_ASSOC );

if (strlen ( htmlspecialchars ( $row ["username"] ) ) < 2) {
	// translator not found look for agency
	$query = "SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
	$result = $db->query ( $query );
	$row = $result->fetch ( PDO::FETCH_ASSOC );

	$str = htmlspecialchars ( $row ["password"] ) . $user . "glifico";
	$true_token = hash ( 'sha256', $str );

	if ($true_token != $token) {
		exit ( json_encode ( array ("message" => "error: wrong token",	"statuscode" => 400	) ) );
	}

	$salted = $user . "startup" . $password;
	$pwd = hash ( 'sha256', $salted );

	$query = "UPDATE agenzia set password='$pwd' WHERE username='$user';";
	$result = $db->query ( $query );
	$row = $result->fetch ( PDO::FETCH_ASSOC );
} else {

	$str = htmlspecialchars ( $row ["password"] ) . $user . "glifico";
	$true_token = hash ( 'sha256', $str );

	if ($true_token != $token) {
		exit ( json_encode ( array ("message" => "error: wrong token","statuscode" => 400) ) );
	}

	$salted = $user . "startup" . $password;
	$pwd = hash ( 'sha256', $salted );

	$query = "UPDATE traduttore set password='$pwd' WHERE username='$user';";
	$result = $db->query ( $query );
	$row = $result->fetch ( PDO::FETCH_ASSOC );
}

exit ( json_encode ( array ("statuscode" => 200) ) );
?>
