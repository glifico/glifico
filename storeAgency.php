<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$token=$_GET['token'];
$str=base64_decode($token);
//true return an array instead of an object
$json=json_decode($str,true);

$nome=$json['name'];
$email=$json['email'];
$user=$json['user'];
$tec=$json['tecAcceptanceDate'];
$password=$json["password"];
$vat=$json['vat'];
$salted=$user."startup".$password;
$pwd=hash('sha256',$salted);

$query="INSERT INTO agenzia(nome, vat, email, username, password, tec) VALUES ('$nome', '$vat', '$email', '$user', '$pwd', '$tec');";
$db->query($query);

exit (json_encode(array("message"=>"agency added", "statuscode"=>200)));
?>
