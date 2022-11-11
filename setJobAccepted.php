<?php
include 'functions.php';



$db=getDB();
if(!$db) exit;

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>500)));
}

$user=$data['user'];
$id=$data['id'];
$choice=$data['choice'];

if(!certToken($db, $user,$data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

if($choice==1){$query="UPDATE payments SET status='Accepted', whoaccepted=1 WHERE translator='$user' and id='$id';";}
if($choice==2){$query="UPDATE payments SET secondstatus='Accepted', whoaccepted=2 WHERE secondtranslator='$user' and id='$id';";}
$result = $db->query($query);


$result->CloseCursor();
notifySlack("#payments",$user." accepted a job",":necktie:");
exit(json_encode(array("message"=>"job updated", "statuscode"=>200)));
?>
