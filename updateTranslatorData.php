<?php

function certToken($db, $user, $token){
  $query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
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

echo($user);
if(!certToken($db, $user, $data['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>500)));


$params=$data['values'];
echo($params);
$nome=$params['FirstName'];
$cognome=$params['LastName'];
$data_nascita=$params['Birthday'];
$citta=$params['City'];
$provincia=$params['StateProvince'];
$zip=$params['ZIP'];
$idStato=$params['idCountry'];
$madrelingua=$params['idMothertongue'];

echo($data);


$query="UPDATE traduttore set nome='$nome', cognome='$cognome', data_nascita='$data_nascita', citta='$citta', provincia='$provincia', cap='$cap', idstato='$idStato', madrelingua='$madrelingua' WHERE username='$user';";
echo($query);
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
exit(json_encode(array("statuscode"=>200));

?>
