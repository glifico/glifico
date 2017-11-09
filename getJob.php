<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
$id=$_GET['id'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * FROM payments WHERE translator='$user' and id='$id' LIMIT 1;";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();

exit(json_encode(array("id"=>$row['id'],"job"=>$row['job'],"price"=>$row['price'],"currency"=>$row['currency'],"status"=>$row['status'],"link"=>$row['translated'],"description"=>$row['description'])));
?>
