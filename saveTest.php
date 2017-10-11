<?php
include 'functions.php';


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

$db=getDB();
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

$language=$domande[0]['language'];
$query="SELECT username, tottest FROM languages WHERE username='$user' AND language='$language' ORDER BY tottest DESC;";
$result = $db->query($query);

$row = $result->fetch(PDO::FETCH_ASSOC);
$oldscore=$row['tottest'];
$newscore=$score;
$score=intval(($newscore+$oldscore)/2);

updateTest($db,$user,$language,$newscore);

$result->CloseCursor();
exit(json_encode(array("message"=>"test submitted","statuscode"=>200,"score"=>$newscore)));
?>
