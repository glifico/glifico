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
if(!certTokenA($db, $user,$data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * from payments LIMIT 0;";
$result = $db->query($query);

$result->CloseCursor();
exit(json_encode(array("message"=>"Job created", "statuscode"=>200,"selected"=>json_encode($selected))));
?>
