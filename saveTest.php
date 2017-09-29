<?php

function search($db, $id){
  $query="SELECT id, scelta FROM skilltest WHERE id='$id';";

  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  return $row['scelta'];
}

function updateTest($db, $user, $languageto, $tot){
  $query="UPDATE languages SET tottest='$tot' WHERE username='$user' and language='$languageto';";
  $result = $db->query($query);

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
$domande=$data['document'];

$score=0;

foreach ($domande as $domanda) {
  $id=$domanda['id'];
  $risposta=search($db, $id);
  if($risposta==$domanda['scelta']) $score+=1;
}

if($score>5) $score=5;

updateTest($db,$user,$domande[0]['language'],$score);

exit(json_encode(array("message"=>"Test submitted","statuscode"=>200,"score"=>$score)));
?>
