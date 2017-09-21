<?php

$name=$_GET['name'];
$password=$_GET['password'];
$email=$_GET['email'];
$user=$_GET['user'];
$vat=$_GET['VAT'];

$object=array("user"=>$user, "password"=>$password, "name"=>$name, "email"=>$email, "vat"=>$vat);
$jsonarray=json_encode($object);
$link="https://glifico.herokuapp.com/confirmAgency.html?token=".base64_encode($jsonarray);

$url="https://api.sendgrid.com/v3/mail/send";
$handle = curl_init($url);
$data='{
  "personalizations": [
    {
      "to": [
        {
          "email": "'.$email.'"
        }
      ],
      "subject": "Thank you for sign up on Glifico!"
    }
  ],
  "from": {
    "email": "info@glifico.com"
  },
  "content": [
    {
      "type": "text/plain",
      "value": "To complete registration on Glifico open or copy this link in a browser:'.$link.'"
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
