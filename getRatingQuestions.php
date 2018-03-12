<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$lang=$_GET['lang'];
$query="SELECT id, language, topic FROM ratingTest WHERE language='$lang' ORDER BY RANDOM() LIMIT 1;";
$result = $db->query($query);
echo("pp");
if($result) $row = $result->fetch(PDO::FETCH_ASSOC);
echo($row);
echo("aa");
echo($row['language']);
$result->CloseCursor();

exit(json_encode($row));
?>
