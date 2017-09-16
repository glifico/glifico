<?php

$url="https://api.sendgrid.com/v3/mail/send";
$handle = curl_init($url);

$data='{
  "personalizations": [
    {
      "to": [
        {
          "email": "fili27182@gmail.com"
        }
      ],
      "subject": "Hello, World!"
    }
  ],
  "from": {
    "email": "from_address@example.com"
  },
  "content": [
    {
      "type": "text/plain",
      "value": "Hello, World!"
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
$result= json_decode($result,true);
echo("$data");
exit($result);
