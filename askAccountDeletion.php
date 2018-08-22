<?php
include 'functions.php';

if(isset($_GET["user"])){
  $user=$_GET["user"];
}else{
  exit (json_encode(array("message"=>"error: user not found", "statuscode"=>400)));
}

$db = getDB();
if (! $db) exit();
    
$user = $_GET['user'];
if (!(certToken($db, $user, $_GET['token']) || certTokenA($db, $user, $_GET['token'])) )
exit(json_encode(array(
    "message" => "wrong token",
    "statuscode" => 400
    )));

$to=[array("email"=>"info@glifico.com", "name"=>"Glifico")];
$mailStatus = send_email($to,"!!ACCOUNT DELETION",$user." voule eliminare l'account, controlla ed eliminalo, 30 giorni da oggi");

$to=[array("email"=>"fvalle.glifico@outlook.com", "name"=>"Filippo")];
$mailStatus = send_email($to,"!!ACCOUNT DELETION",$user." vuole eliminare l'account, controlla ed eliminalo, 30 giorni da oggi");


exit(json_encode(array("statuscode"=>200, "mail code"=>$mailStatus)));
?>
