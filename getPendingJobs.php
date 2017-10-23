<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * FROM payments WHERE translator='$user' ORDER BY status DESC;";
$result = $db->query($query);
$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  array_push($toExit,array("id"=>$row['id'],"job"=>$row['job'],"price"=>$row['price'],"currency"=>$row['currency'],"status"=>$row['status'],"link"=>$row['link'],"description"=>$row['description'],"choice"=>1));
}

$query="SELECT * FROM payments WHERE secondTranslator='$user' ORDER BY status DESC;";
$result = $db->query($query);
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  array_push($toExit,array("id"=>$row['id'],"job"=>$row['job'],"price"=>$row['price'],"currency"=>$row['currency'],"status"=>$row['secondstatus'],"link"=>$row['link'],"description"=>$row['description'],"choice"=>2));
}

$result->CloseCursor();

exit(json_encode($toExit));

 ?>
