<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT USERNAME, LANGUAGE FROM languages WHERE username='$user' ORDER BY language;";
$result = $db->query($query);

$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
    array_push($toExit,array("IdLanguageTo"=>substr($row['language'],0,2),"LanguageTo"=>$row['language']));
}

$result->CloseCursor();

exit(json_encode($toExit));
?>
