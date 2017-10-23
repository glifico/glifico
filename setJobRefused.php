<?php
include 'functions.php';

function NotifySlack($name)
{
  $url="https://hooks.slack.com/services/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";
  $handle = curl_init($url);
  curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($handle, CURLOPT_CONNECTTIMEOUT, 5);
  curl_setopt($handle, CURLOPT_TIMEOUT, 60);
  curl_setopt($handle, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/json'
  ));
  $data='{
    "channel": "#payments",
    "username": "Glifico payments $$",
    "text": "'.$name.' refused a job!",
    "icon_emoji": ":no_entry:"
  }
';
  curl_setopt($handle,CURLOPT_POSTFIELDS, $data);

  curl_exec($handle);
}

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


$result->CloseCursor();
NotifySlack($user);
exit(json_encode(array("message"=>"Job updated", "statuscode"=>200)));
?>