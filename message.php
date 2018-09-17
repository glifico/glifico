<?php

function NotifySlack($subject, $name, $email, $body)
{
  $url="https://hooks.slack.com/services/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";
  $handle = curl_init($url);
  curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($handle, CURLOPT_CONNECTTIMEOUT, 5);
  curl_setopt($handle, CURLOPT_TIMEOUT, 60);
  curl_setopt($handle, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/json'
  ));
  $data='{
    "channel": "#customerservice",
    "username": "GlificoForm",
    "text": "'.$name.' ('.$email.') wrote to Glifico: '.$body.'",
    "icon_emoji": ":email:"
  }
';
  curl_setopt($handle,CURLOPT_POSTFIELDS, $data);

  curl_exec($handle);
}


$name=$_GET['name'];
$subject="Messaggio da un utente";

if(isset($_GET['subject'])){
  if(strlen($_GET['subject'])>2){
    $subject=$_GET['subject'];
  }
}
$email=$_GET['email'];
$body=$_GET['message'];

$customerService="fvalle.glifico@outlook.com";

$url="https://api.sendgrid.com/v3/mail/send";
$handle = curl_init($url);
$data='{
  "personalizations": [
    {
      "to": [
        {
          "email": "'.$customerService.'"
        },
        {
          "email": "info@glifico.com"
        },
        {
          "email": "info.startupproject@gmail.com"
        }
      ],
      "subject": "'.$subject.'"
    }
  ],
  "from": {
    "email": "info@glifico.com"
  },
  "content": [
    {
      "type": "text/plain",
      "value": "'.$name.' ('.$email.') wrote to Glifico: '.$body.'"
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

NotifySlack($subject,$email,$name,$body);

$result = curl_exec($handle);
exit($result);
