<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;


$user=$_GET['user'];
if(!certTokenA($db, $user, $_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * FROM traduttore LIMIT 10;";
$result = $db->query($query);
$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  array_push($toExit,array("FirstName"=>$row['nome']{0},"LastName"=>$row['cognome']{0}, "IdCountry"=>$row['idstato'],"IdMothertongue"=>$row['madrelingua']));
}


exit (json_encode($toExit));
?>
