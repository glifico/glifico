<?php

function certToken($db, $user, $token){
  // $query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
  // $result = $db->query($query);
  // $row = $result->fetch(PDO::FETCH_ASSOC);
  //
  // if(strlen(htmlspecialchars($row["username"]))<2){
  //   //translator not found look for agency
  //   $query="SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
  //   $result = $db->query($query);
  //   $row = $result->fetch(PDO::FETCH_ASSOC);
  // }
  // $password=htmlspecialchars($row['password']);
  // $result->CloseCursor();
  //return $token==hash('crc32',$user."tokenize".$password);
//DEBUG
return true;
}

// $dbopts = parse_url(getenv('DATABASE_URL'));
// $dsn = "pgsql:"
// ."host=".$dbopts["host"].";"
// . "dbname=".ltrim($dbopts["path"],'/').";"
// . "user=".$dbopts["user"].";"
// . "port=5432;"
// . "sslmode=require;"
// . "password=".$dbopts["pass"];
//
//
// $db = new PDO($dsn);
// if(!$db) exit;

$user=$_GET['user'];
if(!certToken($db, $user,$_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

// $query="SELECT USERNAME, LANGUAGES FROM languages WHERE username='$user';";
// $result = $db->query($query);
// $row = $result->fetch(PDO::FETCH_ASSOC);

//$toExit=$row['languages'];

//$result->CloseCursor();

$toExit=[];
array_push($toExit,"{\"TotTest\":5,\"Language\":\"Italian\",\"DataTest\":\"25/09/2017T12:000Z\"}");
array_push($toExit,"{\"Language\":\"Japanese\"}");


exit(json_encode($toExit));
?>