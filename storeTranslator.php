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

$nome=$_GET['name'];
$cognome=$_GET['lastname'];
$password=$_GET['password'];
$salted_password="startup".$password;
$hashed= hash('sha256' , $salted_password );
$user=$_GET['user'];

$query="INSERT INTO traduttore(nome, cognome, username, password) VALUES ('$nome', '$cognome', '$user', '$hashed');";

$db->query($query);

exit (json_encode(array("message"=>"translator added", "statuscode"=>200)));

$result->CloseCursor();
?>
