<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;


if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>400)));
}

$user=$data['user'];
$token=$data['token'];
$domande=$data['document'];
$from=$data['from'];
$to=$data['to'];
if(!certTokenA($db, $user, $token)) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * FROM traduttore WHERE madrelingua='$from' LIMIT 15;";
$result = $db->query($query);

$price=2;

$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  $translator=$row['username'];
  $langTo=$row['madrelingua'];
  $query="SELECT * FROM languages WHERE username='$translator' AND idlanguageto='$langTo';";
  $langResult = $db->query($query);
  $langRow = $langResult->fetch(PDO::FETCH_ASSOC);
  $rating=$langRow['tottest'];
  array_push($toExit,array("Price"=>$price, "Rating"=>$rating, "FirstName"=>$row['nome']{0},"LastName"=>$row['cognome']{0}, "IdCountry"=>$row['idstato'],"IdMothertongue"=>$row['madrelingua']));
}

$result->CloseCursor();
exit (json_encode($toExit));
?>
