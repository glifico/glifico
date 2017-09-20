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

$object=$_GET['token'];
echo($object);
$str=base64_decode($object);
$json=json_decode($str);

echo(json_encode($json));
echo("pippo");

$nome=$json['name'];
echo("pippo");
$cognome=$json['lastName'];
echo("pippo");
$password=$json['password'];
echo("pippo");
$email=$json['email'];
echo("pippo");
$user=$json['user'];
echo("pippo");
$salted_password=$user."startup".$password;
echo("pippo");
$hashed= hash('sha256' , $salted_password );
echo("pippo");

echo($nome);
echo($cognome);
echo($password);
echo($email);
echo($user);
echo($hashed);

$query="INSERT INTO traduttore(nome, cognome, email, username, password) VALUES ('$nome', '$cognome', '$email', '$user', '$hashed');";

echo($query);

$db->query($query);

exit (json_encode(array("message"=>"translator added", "statuscode"=>200)));

$result->CloseCursor();
?>
