<?php

function sendMail($dest, $link)
{
  $url="https://api.sendgrid.com/v3/mail/send";
  $handle = curl_init($url);
  $data='{
    "personalizations": [
      {
        "to": [
          {
            "email": "'.$dest.'"
          }
        ],
        "subject": "Glifico password reset"
      }
    ],
    "from": {
      "email": "info@glifico.com"
    },
    "content": [
      {
        "type": "text/plain",
        "value": "Use this link to reset your password: '.$link.'"
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
  exit($result);
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

if(isset($_GET["user"])){
  $user=$_GET["user"];
}else{
  exit (json_encode(array("message"=>"error: user not found", "statuscode"=>400)));
}


$query="SELECT USERNAME, PASSWORD, EMAIL FROM traduttore WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

if(strlen(htmlspecialchars($row["username"]))<2){
	//translator not found look for agency
	$query="SELECT USERNAME, PASSWORD, EMAIL FROM agenzia WHERE username='$user';";
	$result = $db->query($query);
	$row = $result->fetch(PDO::FETCH_ASSOC);
}

$str=htmlspecialchars($row["password"]).$user."glifico";
$token=hash('sha256',$str);
$link="https://glifico.herokuapp.com/changePassword.html?token=".$token."&user=".$user;
$result->CloseCursor();

sendMail(htmlspecialchars($row["email"]),$link);

exit(json_encode(array("statuscode"=>200)));
?>
