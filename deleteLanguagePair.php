<?php
require_once 'functions.php';
require_once 'languages.php';
require_once 'speak.php';


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
$from=$language_codes[$pair['IdLanguageFrom']];
$to=$language_codes[$pair['IdLanguageTo']];

if(!certToken($db, $user, $data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="DELETE FROM language_pair WHERE username='$user' AND from_l='$from' AND to_l='$to';";
$result = $db->query($query);

user_try_del_lang($user,$from);
user_try_del_lang($user,$to);

exit (json_encode(array("message"=>"language added", "statuscode"=>200)));
?>
