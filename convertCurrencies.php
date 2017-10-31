<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$query="SELECT * from language_pair;";
$result = $db->query($query);

$url="https://v3.exchangerate-api.com/bulk/72aabbf884e8a2247df4bdff/EUR";
//$url="https://api.fixer.io/latest";
$handle = json_decode(file_get_contents($url),true);

$query="SELECT * from currencies;";
$result = $db->query($query);

foreach ($handle['rates'] as $currency => $value) {
  $query="UPDATE currencies SET conversion='$conversion' WHERE currency='$currency';";
  //$query="INSERT INTO currencies (currency, conversion) VALUES('$currency',$value);";
  $db->query($query);
}

$result->CloseCursor();
exit(json_encode(array("stauscode"=>200,"message"=>"currencies updated")));

?>
