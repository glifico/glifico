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
$url=$data['url'];
$count=$data['count'];
$selected=$data['translators'];
$jobTitle=$data['job'];
$jobDescr=$data['description'];
$translator="test";
if(!certTokenA($db, $user,$data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="INSERT INTO payments (job, description, status, username, document, translator, currency) VALUES ('$jobTitle','$jobDescr','To Be Assigned', '$user', '$url','$translator', 'EUR - Euro');";
$result = $db->query($query);

$result->CloseCursor();

send_email([array("email"=>get_user_email($translator))],"There is a new job on glifico","You have a new job on glifico, got to https://glifico.com/pendingJobs.html to look it out!");
exit(json_encode(array("message"=>"job created", "statuscode"=>200,"selected"=>json_encode($selected))));
?>
