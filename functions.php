<?php

function getDB(){
  $dbopts = parse_url(getenv('DATABASE_URL'));
  $dsn = "pgsql:"
  ."host=".$dbopts["host"].";"
  . "dbname=".ltrim($dbopts["path"],'/').";"
  . "user=".$dbopts["user"].";"
  . "port=5432;"
  . "sslmode=require;"
  . "password=".$dbopts["pass"];
  $db = new PDO($dsn);
  return $db;
}

function tokenize($user, $password){
  return hash('crc32',$user."tokenize".$password);
}

function certToken($db, $user, $token){
  $query="SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  $password=htmlspecialchars($row['password']);
  $result->CloseCursor();
  return $token==hash('crc32',$user."tokenize".$password);
}

function certTokenA($db, $user, $token){
  $query="SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  $password=htmlspecialchars($row['password']);
  $result->CloseCursor();
  return $token==hash('crc32',$user."tokenize".$password);
}

 ?>
