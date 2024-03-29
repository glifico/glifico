<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$lang=$_GET['lang'];
$idtest=$_GET[idtest];

$query="SELECT id, language, topic, text_to_translate FROM ratingTest WHERE language='$lang' and ID='$idtest' LIMIT 1;";
$result = $db->query($query);
$toExit=[];

if(!$result) {
    exit(json_encode(array("message"=>"error reading db", "statuscode"=>400)));
}else{    
    while($row = $result->fetch(PDO::FETCH_ASSOC)){
        array_push($toExit,$row);
    }    
}
$result->CloseCursor();

exit(json_encode($toExit));
?>
