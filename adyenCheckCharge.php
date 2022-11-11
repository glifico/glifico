<?php
include 'functions.php';

$data=$_GET['chargeId'];

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>400)));
}

$url = "https://checkout-test.adyen.com/v37/payments/result";
$handle = curl_init($url);
curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
curl_setopt($handle, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($handle, CURLOPT_TIMEOUT, 60);
curl_setopt($handle, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/json',
    'X-API-Key: AQEihmfuXNWTK0Qc+iSXnm0+rueUOF1iKKKvCE/VorPIxub3sBDBXVsNvuR83LVYjEgiTGAH-6EiUQbmzWwSaT0whVih5rYhPFoq2aHB7nlPgWeqPJEY=-FUeqXm5EmPfAcv5Q '
));
$data = '{
       "payload":'.$data.'
    }
  ';
curl_setopt($handle, CURLOPT_POSTFIELDS, $data);

$result=curl_exec($handle);
curl_close($handle);

exit(json_encode(array("message"=>"satispay charge", "resultCode"=>$result["resultCode"], "statuscode"=>400, "adyen"=>$result)));
?>
