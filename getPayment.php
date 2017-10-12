<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
$id=$_GET['id'];
if(!certTokenA($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * FROM payments WHERE username='$user' and id='$id' LIMIT 1;";
$result = $db->query($query);
$toExit=[];
$row = $result->fetch(PDO::FETCH_ASSOC);
array_push($toExit,array("id"=>$row['id'],"job"=>$row['job'],"price"=>$row['price'],"currency"=>$row['currency'],"status"=>$row['status'],"description"=>$row['description']));


$result->CloseCursor();

exit(json_encode($toExit));
?>
