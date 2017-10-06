<?php
function certToken($db, $user, $token){
  $query="SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  $password=htmlspecialchars($row['password']);
  $result->CloseCursor();
  return $token==hash('crc32',$user."tokenize".$password);
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


$user=$_GET['user'];
if(!certToken($db, $user, $_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT * FROM agenzia WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);


exit (json_encode([array("id"=>$row['id'], "CompanyName"=>$row['nome'], "FiscalCode"=>$row['vat'], "VATCode"=>$row['vat'], "Street"=>$row['street'], "Number"=>$row['number'], "Number"=>$row['number'], "City"=>$row['citta'],"StateProvince"=>$row['provincia'],"ZIP"=>$row['cap'], "Country"=>$row['stato'], "EmailReference"=>$row['email'],"Bank"=>$row['banca'], "PayamentMode"=>$row['pagamento'], "IBAN"=>$row['iban'],"EmailReferenceBilling"=>$row['email'])]));
?>
