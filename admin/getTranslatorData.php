<?php
include '../functions.php';

$db=getDB();
if(!$db) exit;


$user=$_GET['user'];

$query="SELECT * FROM traduttore WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();

exit (json_encode([array("FirstName"=>$row['nome'],
    "LastName"=>$row['cognome'],
    "Birthday"=>$row['data_nascita'],
    "City"=>$row['citta'],
    "StateProvince"=>$row['provincia'],
    "ZIP"=>$row['cap'],
    "IdCountry"=>$row['idstato'],
    "IdMothertongue"=>$row['madrelinguaid'],
    "Email"=>$row['email'],
    "Street"=>$row['street'],
    "IBAN"=>$row['iban'],
    "swift"=>$row['swift'],
    "nratings"=>$row['nratings'],
    "EmailReferenceBilling"=>$row['emailbilling'],
    "Phone"=>$row['phone'],
    "PhoneBilling"=>$row['phonebilling']
)]));
?>
