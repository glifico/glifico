<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
$langF=$_GET['langF'];

if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query = "select * from languagerating WHERE languagefrom='$langF';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
$toExit=array("idtest"=>$row['idtest'], "LanguageF"=>$row['languagefrom'], "LanguageT"=>$row['languageto'], "DataTest"=>$row['datatest']);

$query = "select * from ratingtest WHERE id='$idtest';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$toExit['originaltext'] = $row['text_to_translate'];
$result->CloseCursor();

exit(json_encode($toExit));
?>
