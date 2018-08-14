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

if(!certToken($db, $user, $data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>500)));


$params=$data['values'];
$nome=$params['FirstName'];
$cognome=$params['LastName'];
$data_nascita=$params['Birthday'];
$citta=$params['City'];
$provincia=$params['StateProvince'];
$cap=$params['ZIP'];
$idStato=$params['IdCountry'];
$madrelinguaId=$params['IdMothertongue'];
$data_nascita=$params['Birthday'];
$street=$params['Street'];
$email=$params['Email'];
$iban=$params['IBAN'];
$swift=$params['swift'];


$query="UPDATE traduttore set nome='$nome', cognome='$cognome', data_nascita='$data_nascita', citta='$citta', provincia='$provincia', street='$street',  cap='$cap', idstato='$idStato', madrelinguaid='$madrelinguaId', email='$email', iban='$iban', swift='$swift' WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
exit(json_encode(array("message"=>"Translator data updated","query"=>$query, "statuscode"=>200)));

?>
