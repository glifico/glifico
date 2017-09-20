<?php
$dbopts = parse_url(getenv('DATABASE_URL'));
$dsn = "pgsql:"
."host=".$dbopts["host"].";"
. "dbname=".ltrim($dbopts["path"],'/').";"
. "user=".$dbopts["user"].";"
. "port=5432;"
. "sslmode=require;"
. "password=".$dbopts["pass"];
$db = new PDO($dsn);
if(!$db) exit;

$object=$_POST['token'];
$str=base64_decode($object);
$json=json_decode($str);

$nome=$json['name'];
$cognome=$json['lastname'];
$password=$json['password'];
$email=$json['email'];
$user=$json['user'];
$salted_password=$user."startup".$password;
$hashed= hash('sha256' , $salted_password );

$query="INSERT INTO traduttore(nome, cognome, email, username, password) VALUES ('$nome', '$cognome', '$email', '$user', '$hashed');";

$db->query($query);

exit (json_encode(array("message"=>"translator added", "statuscode"=>200)));

$result->CloseCursor();
?>
