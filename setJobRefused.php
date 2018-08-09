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

if($choice==1){$query="UPDATE payments SET status='Refused' WHERE translator='$user' and id='$id';";}
if($choice==2){$query="UPDATE payments SET secondStatus='Refused' WHERE secondTranslator='$user' and id='$id';";}

$result = $db->query($query);

$query="SELECT USERNAME, EMAIL FROM agenzia WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
notifySlack("#payments",$user." refused a job",":no_entry:");
$to=[array("email"=>$row['email'])];
$mailStatus = send_email($to,"Translator refused a job on Glifico","One of the Job you submitted was refuse. Create a new one on https://glifico.com/search.html");

exit(json_encode(array("message"=>"job updated", "statuscode"=>200, "mailstatus"=>$mailStatus)));
?>
