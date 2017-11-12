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

function get_user_email($user){
  $db=getDB();
  if(!$db) return;
  $query="SELECT USERNAME, EMAIL FROM traduttore WHERE username='$user';";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  $email=htmlspecialchars($row['email']);
  $result->CloseCursor();
  return $email;
}

function send_email($to, $subject, $body){
  $url="https://api.sendgrid.com/v3/mail/send";
  $handle = curl_init($url);
  $data='{
    "personalizations": [
      {
        "to": '.json_encode($to).',
        "subject": "'.$subject.'"
      }
    ],
    "from": {
      "email": "info@glifico.com"
    },
    "content": [
      {
        "type": "text/plain",
        "value": "'.$body.'"
      }
    ]
  }';

  curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($handle, CURLOPT_CONNECTTIMEOUT, 5);
  curl_setopt($handle, CURLOPT_TIMEOUT, 60);
  curl_setopt($handle, CURLOPT_HTTPHEADER, array(
    'Authorization: Bearer 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',
    'Content-Type: application/json'
  ));
  curl_setopt($handle,CURLOPT_POSTFIELDS, $data);
  $result = curl_exec($handle);

}

 ?>
