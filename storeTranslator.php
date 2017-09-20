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

$token=$_GET['token'];
$str=base64_decode($token);
//true return an array instead of an object
$json=json_decode($str,true);

$nome=$json['name'];
$cognome=$json['lastName'];
$email=$json['email'];
$user=$json['user'];
$password=$json["password"];
$salted=$user."startup".$password;
$pwd=hash('sha256',$salted);


$query="INSERT INTO traduttore(nome, cognome, email, username, password) VALUES ('$nome', '$cognome', '$email', '$user', '$hashed');";

$db->query($query);

exit (json_encode(array("message"=>"translator added", "statuscode"=>200)));

$result->CloseCursor();
?>
