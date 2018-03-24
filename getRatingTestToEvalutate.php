<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
$langF=$_GET['langF'];

if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query = "select * from languagerating WHERE languagefrom='$langF' and username!='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
$toExit=array("idtest"=>$row['idtest'], "LanguageF"=>$row['languagefrom'], "LanguageT"=>$row['languageto'], "DataTest"=>$row['datatest'], "TranslatedText"=>$row['translated']);

$idtest=$row['idtest'];
$query = "select * from ratingtest WHERE id='$idtest';";
echo($query);
echo($toExit);
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$toExit['OriginalText'] = $row['text_to_translate'];
$result->CloseCursor();

exit(json_encode($toExit));
?>
