<?php

function tokenize($user, $password){
  return hash('crc32',$user."tokenize".$password);
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

$query="
CREATE TABLE IF NOT EXISTS TRADUTTORE (
  ID SERIAL,
  NOME varchar(100) DEFAULT NULL,
  COGNOME varchar(100) DEFAULT NULL,
  DATA_NASCITA date DEFAULT NULL,
  MADRELINGUA varchar(100) DEFAULT NULL,
  PASSWORD varchar(50) DEFAULT NULL,
  HAS_NEW_MESSAGE varchar(1) NOT NULL DEFAULT 'N'
  );
  ";

  $db->query($query);

  if(isset($_GET["user"])&&isset($_GET["password"])){
    $user=$_GET["user"];
    $password=$_GET["password"];
    $salted=$user."startup".$password;
    $pwd=hash('sha256',$salted);
  }else{
    exit (json_encode(array("message"=>"error: user not found", "statuscode"=>400)));
  }


  $query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);
  if(htmlspecialchars($row["password"])==$pwd){
    $token=tokenize($user, $password);
    echo json_encode(array("user"=>$user, "token"=>$token, "statuscode"=>200));
  }else{
    exit (json_encode(array("message"=>"error: wrong password", "statuscode"=>400)));
  }

  $result->CloseCursor();
  ?>
