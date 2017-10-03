<?php
function certToken($db, $user, $token){
  $query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
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

$query="SELECT * FROM traduttore WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);


exit (json_encode([array("FirstName"=>$row['nome'],"LastName"=>$row['cognome'],"Birthday"=>$row['data_nascita'],"City"=>$row['citta'],"StateProvince"=>$row['provincia'],"ZIP"=>$row['cap'], "IdCountry"=>$row['idstato'],"IdMothertongue"=>$row['madrelingua'])]));
?>
