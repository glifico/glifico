<?php

include 'functions.php';


if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>500)));
}


$db=getDB();
if(!$db) exit;

$user=$data['user'];

if(!certTokenA($db, $user, $data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>500)));


$params=$data['values'];

//ToDo
//exit (json_encode([array("id"=>$row['id'],  "FiscalCode"=>$row['vat'],  "Street"=>$row['street'], "Number"=>$row['number'], "Number"=>$row['number'],  "EmailReference"=>$row['email'],"Bank"=>$row['banca'], "PayamentMode"=>$row['pagamento'], "IBAN"=>$row['iban'],"EmailReferenceBilling"=>$row['email'])]));
$street=$params['Street'];
$citta=$params['City'];
$provincia=$params['StateProvince'];
$country=$params['Country'];
$cap=$params['ZIP'];
$vat=$params['FiscalCode'];
$email=$params['email'];
$email_bil=$params['email_bil'];
$phone=$params['phone'];
$phone_bil=$params['phone_bil'];

$query="UPDATE agenzia set street='$street', citta='$citta', provincia='$provincia', stato='$country', vat='$vat', cap='$cap', email='$email', email_bil='$email_bil', phone='$phone', phone_bil='$phone_bil' WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
exit(json_encode(array("message"=>"Agency data updated", "statuscode"=>200)));

?>
