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
$from=$pair['LanguageFrom'];
$to=$pair['LanguageTo'];
$field=$pair['Field'];

if(!certToken($db, $user, $data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="select id, job  from payments where translator ='$user' and languagefrom = '$from' and field = 'select all' and languageto = '$to' and whoaccepted=1;";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
if (strlen(htmlspecialchars($row["job"])) > 1) {
    exit (json_encode(array("message"=>"job in progress", "job" =>$row, "statuscode"=>301)));
}

$query="select id, job  from payments where translator ='$user' and languagefrom = '$from' and field = '$field' and languageto = '$to' and whoaccepted=1;";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
if (strlen(htmlspecialchars($row["job"])) > 1) {
    exit (json_encode(array("message"=>"job in progress", "job" =>$row, "statuscode"=>301)));
}

$query="select id, job  from payments where secondtranslator ='$user' and languagefrom = '$from' and languageto = '$to' and field = 'select all' and whoaccepted=2;";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
if (strlen(htmlspecialchars($row["job"])) > 1) {
    exit (json_encode(array("message"=>"job in progress", "job" =>$row, "statuscode"=>302)));
}


$query="select id, job  from payments where secondtranslator ='$user' and languagefrom = '$from' and languageto = '$to' and field = '$field' and whoaccepted=2;";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
if (strlen(htmlspecialchars($row["job"])) > 1) {
    exit (json_encode(array("message"=>"job in progress", "job" =>$row, "statuscode"=>302)));
}


$query="DELETE FROM language_pair WHERE username='$user' AND from_l='$from' AND to_l='$to' and field='$field';";
$result = $db->query($query);

user_try_del_lang($user,$from);
user_try_del_lang($user,$to);

exit (json_encode(array("message"=>"language deleted", "statuscode"=>200)));
?>
