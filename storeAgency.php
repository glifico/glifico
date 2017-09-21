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
$email=$json['email'];
$user=$json['user'];
$password=$json["password"];
$vat=$json['vat'];
$salted=$user."startup".$password;
$pwd=hash('sha256',$salted);


$query="INSERT INTO agenzia(nome, vat, email, username, password) VALUES ('$nome', '$vat', '$email', '$user', '$pwd');";

$db->query($query);

exit (json_encode(array("message"=>"agency added", "statuscode"=>200)));

$result->CloseCursor();
?>
