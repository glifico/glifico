<?php

function search($db, $id){
  $query="SELECT id, scelta WHERE id='$id'";

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

$user=$_POST['user'];
$document=json_decode($_POST['document'],true);
$domande=$document['domande'];

$score=0;

foreach ($domande as $domanda) {
  $id=$domanda['id'];
  $risposta=search($db, $id);
  if($risposta==$domanda['scelta']) $score+=1;
}

exit(json_encode(array("message"=>"Test submitted","statuscode"=>400,"score"=>$score,"domande"=>$_POST['document'])));
?>
