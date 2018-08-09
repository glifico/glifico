<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="select * from languagerating WHERE username='$user';";
$result = $db->query($query);
$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
    array_push($toExit,array("idtest"=>$row['id'], "LanguageF"=>$row['languagefrom'], "LanguageT"=>$row['languageto'], "DataTest"=>$row['datatest']));
}

$result->CloseCursor();

exit(json_encode($toExit));
?>
