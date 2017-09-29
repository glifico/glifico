<?php

function certToken($db, $user, $token){
  $query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  if(strlen(htmlspecialchars($row["username"]))<2){
    //translator not found look for agency
    $query="SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);
  }
  $password=htmlspecialchars($row['password']);
  $result->CloseCursor();
  return $token==hash('crc32',$user."tokenize".$password);
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

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT username, language, datatest, tottest FROM languages WHERE username='$user' ORDER BY language;";
$result = $db->query($query);
$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  array_push($toExit,array("Language"=>$row['language'],"TotTest"=>$row['tottest'],"DataTest"=>$row['datatest']));
}

$result->CloseCursor();

exit(json_encode($toExit));
?>
