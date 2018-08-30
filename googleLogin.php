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
$CLIENT_ID = "814902183251-ctp5kv30jdl5vah5m35ni396e420ls4q.apps.googleusercontent.com";

$client = new Google_Client([
    'client_id' => $CLIENT_ID
]); // Specify the CLIENT_ID of the app that accesses the backend
$payload = $client->verifyIdToken($id_token);
if ($payload) {
    $userid = $payload['sub'];
    // If request specified a G Suite domain:
    // $domain = $payload['hd'];
} else {
    // Invalid ID token
}

exit($payload);

?>