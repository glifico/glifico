<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$lang=$_GET['lang'];
$query="SELECT id, language, question, answer1, answer2, answer3 FROM skillTest WHERE language='$lang' ORDER BY RANDOM() LIMIT 5;";
$result = $db->query($query);
$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  $row['scelta']="";
  array_push($toExit,$row);
}

$result->CloseCursor();

exit(json_encode($toExit));
?>
