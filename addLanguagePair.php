<?php
include 'functions.php';
include 'languages.php';

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
$pair=$data['values'];
echo($language_codes[$pair['IdLanguageFrom']]);

if(!certToken($db, $user, $data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

//$query="INSERT INTO language_pair VALUES ();";
//$result = $db->query($query);
echo(json_encode($pair));

exit (json_encode($toExit));
?>
