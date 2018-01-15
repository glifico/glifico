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

\SatispayOnline\Api::setSecurityBearer('osh_...');
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
