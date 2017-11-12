<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
$id=$_GET['id'];
if(!certTokenA($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="UPDATE payments SET status='Accepted' WHERE username='$user' and id='$id';";
$result = $db->query($query);

$result->CloseCursor();
notifySlack("#payments",$user." approved a job",":thumbsup:");
exit(json_encode(array("message"=>"payment updated", "statuscode"=>200)));
?>
