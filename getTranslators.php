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
$reqRating=['rating'];
if(!certTokenA($db, $user, $token)) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * FROM languages WHERE idlanguageto='$langTo' AND tottest>='$reqRating';";
$result = $db->query($query);

$pricequery="select avg(price) from(select price from traduttore) sub;";
$priceres=$db->query($query);
$price=$result->fetch(PDO::FETCH_ASSOC);



$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  $translator=$row['username'];
  $rating=$row['tottest'];
  array_push($toExit,array("Price"=>$price, "Rating"=>$rating, "FirstName"=>$row['nome']{0},"LastName"=>$row['cognome']{0}, "IdCountry"=>$row['idstato'],"IdMothertongue"=>$row['madrelinguaid'],"Mothertongue"=>$row['madrelingua']));
}

$result->CloseCursor();
exit (json_encode($toExit));
?>
