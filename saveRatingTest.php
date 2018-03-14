<?php
include 'functions.php';

$db=getDB();
if(!$db) exit();

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>400)));
}

$user=$data['user'];
$token=$data['token'];
$translated=$data['trad'];
$from=$data['linguaF'];

if(!certToken($db, $user,$token)) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$today=date("Y-m-d H:i:s");
$query="INSERT INTO languagerating (datatest, translated, usrname, language) VALUES('$today', '$translated', '$user', '$from');";
$result = $db->query($query);

$result->CloseCursor();
exit(json_encode(array("message"=>"test submitted","statuscode"=>200,"score"=>$newscore)));
?>
