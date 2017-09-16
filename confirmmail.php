<?php

require 'vendor/autoload.php';

$apiKey="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";
$from = new SendGrid\Email("Glifico", "info@glifico.com");
$subject = "Account created on Glifico";
$dest=$_GET["to"];
$to = new SendGrid\Email("Translator", "$dest");
$content = new SendGrid\Content("text/html", "Thank you for registrating on <b>Glifico</b>");
$mail = new SendGrid\Mail($from, $subject, $to, $content);
$sg = new \SendGrid($apiKey);
$response = $sg->client->mail()->send()->post($mail);
echo $response->statusCode();
print_r($response->headers());
echo $response->body();

?>
