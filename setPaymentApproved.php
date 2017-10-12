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
    "text": "'.$name.' approved a job on Glifico!",
    "icon_emoji": ":thumbsup:"
  }
';
  curl_setopt($handle,CURLOPT_POSTFIELDS, $data);

  curl_exec($handle);
}

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
$id=$_GET['id'];
if(!certTokenA($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="UPDATE payments SET status='Pending' WHERE username='$user' and id='$id';";
$result = $db->query($query);

$result->CloseCursor();
NotifySlack($user);
exit(json_encode(array("message"=>"Payment updated", "statuscode"=>200)));
?>
