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
$langFrom=$data['from'];
$langTo=$data['to'];
$reqRating=$data['rating'];
if(!certTokenA($db, $user, $token)) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT username, from_l, to_l, price from language_pair WHERE from_l LIKE '$langFrom' AND to_l LIKE '$langTo';"
$result = $db->query($query);


$pricequery="SELECT avg(price) FROM($query) sub;";
$priceRes=$db->query($query);
//$price=$priceRes->fetch(PDO::FETCH_ASSOC);
$price=2;


$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  $translator=$row['username'];
  $queryUser="SELECT * FROM traduttore WHERE username='$translator';";
  $resultUser = $db->query($queryUser);

  $queryRating="SELECT * FROM languages WHERE language='$langTo' AND tottest>='$reqRating';";
  $resultRating = $db->query($query);

  $rowUser=$resultUser->fetch(PDO::FETCH_ASSOC);
  $rating=$row['tottest'];
  array_push($toExit,array("Price"=>$price, "Rating"=>$rating, "FirstName"=>$rowUser['nome']{0},"LastName"=>$rowUser['cognome']{0}, "IdMothertongue"=>$rowUser['madrelinguaid'],"Mothertongue"=>$rowUser['madrelingua']));
}

$result->CloseCursor();
exit (json_encode($toExit));
?>
