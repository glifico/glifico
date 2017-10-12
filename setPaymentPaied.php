<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
$id=$_GET['id'];
if(!certTokenA($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="UPDATE payments SET status='Completed' WHERE username='$user' and id='$id';";
$result = $db->query($query);

$result->CloseCursor();

exit(json_encode(array("message"=>"Payment updated", "statuscode"=>200)));
?>
