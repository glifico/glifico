<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT username, language, datatest, tottest FROM languages WHERE username='$user' ORDER BY tottest DESC;";
$result = $db->query($query);
$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  array_push($toExit,array("Language"=>$row['language'],"TotTest"=>$row['tottest'],"DataTest"=>$row['datatest']));
}

$result->CloseCursor();

exit(json_encode($toExit));
?>
