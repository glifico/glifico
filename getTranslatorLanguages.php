<?php

function certToken($db, $user, $token){
  echo("check");
  $query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  if(strlen(htmlspecialchars($row["username"]))<2){
    //translator not found look for agency
    $query="SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);
  }
echo("aa");
  $password=htmlspecialchars($row['password']);
echo($password);
$result->CloseCursor();
  return $token==hash('crc32',$user."tokenize".$password);
}

echo("start");

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

if(certToken($db, $_GET['user'],$_GET['token'])) echo("token Ok");
if(!certToken($db, $_GET['user'],$_GET['token'])) exit;


$languages=[];
push_back($languages,json_encode(array("LanguageTo"=>"Italian","IdLanguageTo"=>"it")));
push_back($languages,json_encode(array("LanguageTo"=>"English","IdLanguageTo"=>"en")));
push_back($languages,json_encode(array("LanguageTo"=>"Klingon","IdLanguageTo"=>"kl")));

$languages_str=json_encode($languages);

echo($languages);
echo($languages_str);

$query="INSERT INTO languages (username, languages) VALUES ('$user','$languages_str')";

$db->query($query);
echo("$query");

$query="SELECT USERNAME, LANGUAGES FROM languages WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

echo(htmlspecialchars($row['languages']));

$result->CloseCursor();


?>
