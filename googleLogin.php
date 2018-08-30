<?php
require_once 'vendor/autoload.php';

// Get $id_token via HTTPS POST.

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
    $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
    exit(json_encode(array("message"=>"wrong request","statuscode"=>400)));
}


$id_token = $data['id_token'];
$CLIENT_ID = "743159722110-035bgdjvbtk95e4qo95vdpf1qis80iaj.apps.googleusercontent.com";

$client = new Google_Client([
    'client_id' => $CLIENT_ID
]); // Specify the CLIENT_ID of the app that accesses the backend

$client->setAuthConfigFile("client_secret.json");

$token_data = $client->verifyIdToken($id_token)->getAttributes();
$payload = $token_data['payload'];

if ($payload) {
    $userid = $payload['sub'];
    // If request specified a G Suite domain:
    // $domain = $payload['hd'];
} else {
    // Invalid ID token
}

exit(json_encode($payload));

?>