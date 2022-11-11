<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query = "select username, avg(stylemark) as stylemark, avg(grammarmark) as grammarmark, languageto, languagefrom from languagerating WHERE username='$user' group by username, languageto, languagefrom;";
$result = $db->query($query);
$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
    array_push($toExit,array("LanguageF"=>$row['languagefrom'], "LanguageT"=>$row['languageto'], "Grammarmark"=>$row['grammarmark'], "Stylemark"=>$row['stylemark']));
}

$result->CloseCursor();

exit(json_encode($toExit));
?>
