<?php
include 'functions.php';

$db=getDB();
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
$link="https://test.glifico.com/changePassword.html?token=".$token."&user=".$user;
$result->CloseCursor();

$to=[array("email"=>htmlspecialchars($row["email"]))];
$mailStatus = send_email($to,"Glifico password reset","Use this link to reset your password: '.$link.'");

exit(json_encode(array("statuscode"=>200, "mail code"=>$mailStatus)));
?>
