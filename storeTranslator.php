<?php

function checkPresence($db, $user){
  $query="SELECT username FROM traduttore WHERE username='$user';";
  $result=$db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC)

  if(strlen(htmlspecialchars($row["username"]))>2) exit(json_encode(array("message"=>"username already present", "statuscode"=>408)));
}

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

$user=$json['user'];

checkPresence($db, $user);

$nome=$json['name'];
$cognome=$json['lastName'];
$email=$json['email'];
$password=$json["password"];
$vat=$json['vat'];
$salted=$user."startup".$password;
$pwd=hash('sha256',$salted);


$query="INSERT INTO traduttore(nome, cognome, vat, email, username, password) VALUES ('$nome', '$cognome', '$vat', '$email', '$user', '$pwd');";

$db->query($query);

exit (json_encode(array("message"=>"translator added", "statuscode"=>200)));

$result->CloseCursor();
?>
