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
$url=$data['url'];
$preview=$data['preview'];
$choice=$data['choice'];
if(!certToken($db, $user,$data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

if($choice==1){$query="UPDATE payments SET status='Translated', translated='$url', preview='$preview' WHERE translator='$user' and id='$id';";}
if($choice==2){$query="UPDATE payments SET secondStatus='Translated', translated='$url', preview='$preview' WHERE secondTranslator='$user' and id='$id';";}

$result = $db->query($query);

$result->CloseCursor();
notifySlack("#payments",$user." translated a job",":thumbsup:");

$query="SELECT USERNAME, EMAIL FROM agenzia WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
$to=[array("email"=>$row['email'])];
$mailStatus = send_email($to,"Translator translated a job on Glifico","One of your jobs is now translated.");


exit(json_encode(array("message"=>"job translated", "statuscode"=>200, "email_status"=>$mailStatus)));
?>
