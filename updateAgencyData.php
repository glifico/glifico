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
$nome=$params['CompanyName'];
$citta=$params['City'];
$provincia=$params['StateProvince'];
$cap=$params['ZIP'];
$vat=$params['FiscalCode'];
$stato=$params['Country'];
$iban=$params['IBAN'];


$query="UPDATE agenzia set nome='$nome', citta='$citta', provincia='$provincia', vat='$vat', cap='$cap', stato='$stato', iban='$iban' WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
exit(json_encode(array("message"=>"Agency data updated", "statuscode"=>200)));

?>
