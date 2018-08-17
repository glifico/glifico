<?php
include 'functions.php';

$db=getDB();

if(!$db) exit;

$token=$_GET['token'];
$str=base64_decode($token);
//true return an array instead of an object
$json=json_decode($str,true);

$user=$json['user'];

$nome=$json['name'];
$cognome=$json['lastName'];
$email=$json['email'];
$password=$json["password"];
$vat=$json['vat'];
$now = new DateTime($_GET['tecAcceptanceDate']);
$tec = $now->format('Y-m-d H:i:s');
$salted=$user."startup".$password;
$pwd=hash('sha256',$salted);


$query="INSERT INTO traduttore(nome, cognome, vat, email, username, password, tec) VALUES ('$nome', '$cognome', '$vat', '$email', '$user', '$pwd','$tec');";
echo($query);
$db->query($query);

exit (json_encode(array("message"=>"translator added", "statuscode"=>200)));
?>
