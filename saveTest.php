<?php

function search($id){
  return 3;
}

$user=$_POST['user'];
$document=json_decode($_POST['document'],true);
$domande=$document['domande'];

$score=0;

foreach ($domande as $domanda) {
  $id=$domanda['id'];
  $risposta=search($id);
  if($risposta==$domanda['scelta']) $score+=1;
  echo($score);
}

exit(json_encode(array("message"=>"Test submitted","statuscode"=>400,"score"=>$score)));
 ?>
