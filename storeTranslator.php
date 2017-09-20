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
$json=json_decode($str,true);

echo(json_encode($json));
echo($json['email']);

$password=$_GET["password"];
$salted=$user."startup".$password;
$pwd=hash('sha256',$salted);


$query="INSERT INTO traduttore(nome, cognome, email, username, password) VALUES ('$nome', '$cognome', '$email', '$user', '$hashed');";

echo($query);

$db->query($query);

exit (json_encode(array("message"=>"translator added", "statuscode"=>200)));

$result->CloseCursor();
?>
