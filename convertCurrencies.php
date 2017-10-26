<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$query="SELECT * from language_pair;";
$result = $db->query($query);

$url="https://v3.exchangerate-api.com/bulk/72aabbf884e8a2247df4bdff/EUR";
//$url="https://api.fixer.io/latest";
$handle = json_decode(file_get_contents($url),true);

$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  $username=$row['username'];
  $to=$row['to_l'];
  $from=$row['from_l'];
  $price=$row['price'];
  $cur=substr($row['currency'],0,3);
  $priceEuro=truncate((float)$price/$handle['rates'][$cur],2);
  $query="UPDATE language_pair SET price_euro='$priceEuro' WHERE username='$username' AND from_l='$from' AND to_l='$to' AND price='$price';";
  $db->query($query);
}

$result->CloseCursor();
exit(json_encode(array("stauscode"=>200,"message"=>"currencies updated")));

?>
