<?php
include 'functions.php';

$dir="/vendor/satispay/online-api-php-sdk/";

require(dirname(__FILE__) . $dir. '/lib/Api.php');

require(dirname(__FILE__) . $dir. '/lib/Bearer.php');
require(dirname(__FILE__) . $dir. '/lib/Charge.php');
require(dirname(__FILE__) . $dir. '/lib/Checkout.php');
require(dirname(__FILE__) . $dir. '/lib/Refund.php');
require(dirname(__FILE__) . $dir. '/lib/User.php');

$data=$_GET['charge_id'];

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>400)));
}

\SatispayOnline\Api::setSecurityBearer('osh_ea7knn45ljmjon41kbq542jdl7112k928aeddpvlb9o76qh0o6kfe2md7fh3taufj8l67kaforua611clg0b9e1ss90tl073b770l6jpmk4gjp0evvbui4rrdn6ggr2kcpj13nqn36ht88mmoqsujk1q02ojbsqai3klf0s7aqsdd195aa8bin4kvr7vc9ta6cvc8fcg');
\SatispayOnline\Api::setSandbox(true);
$charge = \SatispayOnline\Charge::get($data);

if($charge['status']=="SUCCESS"){
    $db=getDB();
    if(!$db) exit;
    
    $user=$_GET['user'];
    $id=$_GET['id'];
    
    $query="UPDATE payments SET status='Paid' WHERE id='$id';";
    $result = $db->query($query);
    
    $result->CloseCursor();
    notifySlack("#payments",$user." paid Glifico".json_encode($charge),":heavy_dollar_sign:");
    exit(json_encode(array("message"=>"payment updated", "statuscode"=>200)));
}

exit(json_encode(array("message"=>"wrong payment","statuscode"=>400)));
?>
