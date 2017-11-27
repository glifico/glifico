<?php
include 'functions.php';
include 'languages.php';

$db=getDB();
if(!$db) exit;

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>500)));
}

$user=$data['user'];
$pair=$data['values'];
$from=$pair['from'];
$from=$language_codes[$pair['IdLanguageFrom']];
$to=$language_codes[$pair['IdLanguageTo']];
$price=$pair['PricePerCharacter'];
$price_euro=convert_to_euro($price,$pair['IdCurrency']);
$currency=get_currency_description($pair['IdCurrency']);
$field="translations";
$seervice="translations";


if(!certToken($db, $user, $data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="INSERT INTO language_pair (username,from_l,to_l,price,price_euro,field,service,currency) VALUES ('$user','$from','$to','$price','$price_euro','$field','$service','$currency');";
$result = $db->query($query);


exit (json_encode(array("message"=>"language added", "statuscode"=>200)));
?>
