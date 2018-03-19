<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;


$user=$_GET['user'];
if(!certToken($db, $user, $_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$id=$_GET['id'];


exit (json_encode([array("Language"=> $language_codes[$id], "Id"=> $id)]));
?>
