<?php

function certToken($db, $user, $token){
  $query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  if(strlen(htmlspecialchars($row["username"]))<2){
    //translator not found look for agency
    $query="SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);
  }
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
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrond token", "statuscode"=>400)));


$languages=[];
array_push($languages,json_encode(array("LanguageTo"=>"Italian","IdLanguageTo"=>"it")));
array_push($languages,json_encode(array("LanguageTo"=>"English","IdLanguageTo"=>"en")));
array_push($languages,json_encode(array("LanguageTo"=>"Klingon","IdLanguageTo"=>"kl")));

$languages_str=json_encode($languages);

echo($languages);
echo($languages_str);

$query="UPDATE languages SET languages= '$languages_str' WHERE username='$user'";

$db->query($query);
echo("$query");

$query="SELECT USERNAME, LANGUAGES FROM languages WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

echo(htmlspecialchars($row['languages']));

$result->CloseCursor();


?>
