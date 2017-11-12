<?php
include 'functions.php';

function checkPresence($user){
  $db=getDB();
  if(!$db) exit;

  $query="SELECT username FROM agenzia WHERE username='$user';";
  $result=$db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);

  if(strlen(htmlspecialchars($row["username"]))>2) exit(json_encode(array("message"=>"username already present", "statuscode"=>408)));
  $result->CloseCursor();
}


$name=$_GET['name'];
$password=$_GET['password'];
$email=$_GET['email'];
$user=$_GET['user'];
$vat=$_GET['VAT'];

checkPresence($user);

$object=array("user"=>$user, "password"=>$password, "name"=>$name, "email"=>$email, "vat"=>$vat);
$jsonarray=json_encode($object);
$link="https://glifico.com/confirmAgency.html?token=".base64_encode($jsonarray);


$to=[array("email"=>$email)];
$subject="Thank you for sign up on Glifico!";
$content="To complete registration on Glifico open or copy this link in a browser:'.$link.'";
send_email($to,$subject,$content);

exit (json_encode(array("message"=>"mail sent", "statuscode"=>200)));

?>
