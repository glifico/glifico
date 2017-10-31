<?php
include 'functions.php';
$db=getDB();
if(!$db) exit;
$query="SELECT * from language_pair;";
$result = $db->query($query);

$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  $username=$row['username'];
  $to=$row['to_l'];
  $from=$row['from_l'];
  $price=$row['price'];
  $cur=substr($row['currency'],0,3);
  $query="SELECT currency, conversion from currencies where currency='$cur';";
  $convResult = $db->query($query);
  $convRow = $convResult->fetch(PDO::FETCH_ASSOC)
  $priceEuro=round((float)$price/$convRow['conversion'],2);
  $query="UPDATE language_pair SET price_euro='$priceEuro' WHERE username='$username' AND from_l='$from' AND to_l='$to' AND price='$price';";
  $db->query($query);
}
$result->CloseCursor();
exit(json_encode(array("stauscode"=>200,"message"=>"currencies updated")));
