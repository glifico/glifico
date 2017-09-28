<?php

function search($db, $id){
  $query="SELECT id, scelta FROM test WHERE id='$id'";

  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  $result->CloseCursor();
  return $row['scelta'];
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
if(!$db) exit();

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>400)));
}

$user=$data['user'];
$document=$data['document'];
$domande=$document['domande'];

$score=0;
$text="";
$text=$domande.$user;
foreach ($domande as $domanda) {
  $id=$domanda['id'];
  $risposta=search($db, $id);
  if($risposta==$domanda['scelta']) $score+=1;
  $score+=10;
}

exit(json_encode(array("message"=>"Test submitted","statuscode"=>200,"score"=>$score,"text"=>$text)));
?>
