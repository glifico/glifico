<?php
include 'functions.php';



$db=getDB();
if(!$db) exit;


$user=$_GET['user'];
if(!certTokenA($db, $user, $_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * FROM agenzia WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
exit (json_encode([array("id"=>$row['id'], 
    "CompanyName"=>$row['nome'], 
    "FiscalCode"=>$row['vat'], 
    "VATCode"=>$row['vat'], 
    "Street"=>$row['street'], 
    "Number"=>$row['number'], 
    "City"=>$row['citta'],
    "StateProvince"=>$row['provincia'],
    "ZIP"=>$row['cap'], 
    "Country"=>$row['stato'], 
    "EmailReference"=>$row['email'],
    "PhoneReference"=>$row['phone'], 
    "Bank"=>$row['banca'], 
    "PayamentMode"=>$row['pagamento'], 
    "IBAN"=>$row['iban'],
    "swift"=>$row['swift'], 
    "EmailReferenceBilling"=>$row['email_bil'],
    "PhoneReferenceBilling"=>$row['phone_bil']
)]));
?>
