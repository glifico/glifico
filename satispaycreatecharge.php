<?php
include 'fuctions.php'

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>400)));
}

$uid=$data['uuid']

\SatispayOnline\Api::setSecurityBearer('osh_ea7knn45ljmjon41kbq542jdl7112k928aeddpvlb9o76qh0o6kfe2md7fh3taufj8l67kaforua611clg0b9e1ss90tl073b770l6jpmk4gjp0evvbui4rrdn6ggr2kcpj13nqn36ht88mmoqsujk1q02ojbsqai3klf0s7aqsdd195aa8bin4kvr7vc9ta6cvc8fcg');
\SatispayOnline\Api::setSandbox(true);

$charge = \SatispayOnline\Charge::create([
  'user_id' => $uid,
  'currency' => 'EUR',
  'amount' => 10,
  'callback_url' => 'http://test.glifico.com/payDocument.html?token=12&charge_id={uuid}',
  'metadata' => [
    'orderid' => '1'
  ]
]);

notifySlack($data['uuid']);

exit(0);
?>
