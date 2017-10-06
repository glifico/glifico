<?php

function certToken($db, $user, $token){
  $query="SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  $password=htmlspecialchars($row['password']);
  $result->CloseCursor();
  return $token==hash('crc32',$user."tokenize".$password);
}


if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>500)));
}


$dbopts = parse_url(getenv('DATABASE_URL'));
$dsn = "pgsql:"
."host=".$dbopts["host"].";"
. "dbname=".ltrim($dbopts["path"],'/').";"
. "user=".$dbopts["user"].";"
. "port=5432;"
. "sslmode=require;"
. "password=".$dbopts["pass"];
$db = new PDO($dsn);
if(!$db) exit;

$user=$data['user'];

if(!certToken($db, $user, $data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>500)));


$params=$data['values'];

//ToDo
//exit (json_encode([array("id"=>$row['id'],  "FiscalCode"=>$row['vat'],  "Street"=>$row['street'], "Number"=>$row['number'], "Number"=>$row['number'],  "EmailReference"=>$row['email'],"Bank"=>$row['banca'], "PayamentMode"=>$row['pagamento'], "IBAN"=>$row['iban'],"EmailReferenceBilling"=>$row['email'])]));
$nome=$params['CompanyName'];
$citta=$params['City'];
$provincia=$params['StateProvince'];
$cap=$params['ZIP'];
$vat=$params['FiscalCode'];
$stato=$params['Country'];



$query="UPDATE agenzia set nome='$nome', citta='$citta', provincia='$provincia', vat='$vat' cap='$cap', stato='$stato' WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
exit(json_encode(array("message"=>"Agency data updated", "statuscode"=>200)));

?>
