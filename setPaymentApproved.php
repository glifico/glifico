<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
$id=$_GET['id'];
if(!certTokenA($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT id, username, whoaccepted from payments WHERE username='$user' and id='$id';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$choice=$row['whoaccepted'];

if($choice==1){$query="UPDATE payments SET status='Approved' WHERE username='$user' and id='$id';";}
if($choice==2){$query="UPDATE payments SET secondstatus='Approved' WHERE username='$user' and id='$id';";}

$result = $db->query($query);

$result->CloseCursor();
notifySlack("#payments",$user." approved a job",":thumbsup:");
exit(json_encode(array("message"=>"payment updated", "statuscode"=>200)));
?>
