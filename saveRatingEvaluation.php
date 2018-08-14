<?php
include_once 'functions.php';
include_once 'test.php';

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
$idtest=$data['idtest'];
$grammarmark=$data['ratings']['grammar'];
$stylemark=$data['ratings']['style'];
$languageto = $data['languageto'];
$languagefrom = $data['languagefrom'];

if(!certToken($db, $user,$token)) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="INSERT INTO languagerating (grammarmark, stylemark) VALUES('$grammarmark','$stylemark');";
$result = $db->query($query);

$result->CloseCursor();

$tot = ($grammarmark + $stylemark)/2;
updateTotalTest($db, $user, $languageto, $tot);
updateTotalTest($db, $user, $languagefrom, $tot);
exit(json_encode(array("message"=>"test submitted","statuscode"=>200)));
?>
