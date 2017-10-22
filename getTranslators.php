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
  $translator=$row['username'];
  $langTo=$row['madrelingua'];
  $query="SELECT * FROM languages WHERE username='$translator' AND idlanguageto='$langTo';";
  $langResult = $db->query($query);
  $langRow = $langResult->fetch(PDO::FETCH_ASSOC);
  $rating=$langRow['tottest'];
  array_push($toExit,array("Price"=>2, "Rating"=>$rating, "FirstName"=>$row['nome']{0},"LastName"=>$row['cognome']{0}, "IdCountry"=>$row['idstato'],"IdMothertongue"=>$row['madrelingua']));
}

$result->CloseCursor();
exit (json_encode($toExit));
?>
