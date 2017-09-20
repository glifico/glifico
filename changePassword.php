<?php
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

if(isset($_GET["user"])&&isset($_GET["password"])&&isset($_GET["token"])){
  $user=$_GET["user"];
  $password=$_GET["password"];
  $token=$_GET["token"];
}else{
  exit (json_encode(array("message"=>"error: user not found", "statuscode"=>400)));
}

$query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$str=htmlspecialchars($row["password"]).$user."glifico";
$true_token=hash('sha256',$str);

if(!$true_token==$token){
  exit (json_encode(array("message"=>"error: wrong token", "statuscode"=>400)));
}

$salted=$user."startup".$password;
$pwd=hash('sha256',$salted);

$query="UPDATE traduttore set password='$pwd' WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

exit(json_encode(array("statuscode"=>200)));
?>
