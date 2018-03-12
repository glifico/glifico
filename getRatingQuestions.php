<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$lang=$_GET['lang'];
$query="SELECT id, language, topic, text_to_translate FROM ratingTest WHERE language='$lang' ORDER BY RANDOM() LIMIT 1;";
$result = $db->query($query);
if(!$result) {
    exit(json_encode(array("message"=>"error reading db", "statuscode"=>400)));
}else{    
    $row = $result->fetch(PDO::FETCH_ASSOC);
}
$result->CloseCursor();

exit(json_encode($row));
?>
