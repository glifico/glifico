<?php
require_once 'vendor/autoload.php';
require_once 'functions.php';

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
    $email = $payload['email'];
    
    $db = getDB();
    if(!$db){
        exit(json_encode(array(
            "message" => "error: app not running properly",
            "statuscode" => 505
        )));
    }
    
    $query = "SELECT USERNAME, PASSWORD FROM traduttore WHERE email='$email';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);
    $type = "T";
    $user = $row['username'];
   
    if ($payload['email_verified']) {
        $token = tokenize($user, $pwd);
        exit (json_encode(array(
            "payload" => $payload,
            "user" => $user,
            "token" => $token,
            "type" => $type,
            "statuscode" => 200
        )));
    } else {
        exit(json_encode(array(
            "message" => "error: no account with your email",
            "statuscode" => 400
        )));
    }
    
    $result->CloseCursor();
    
} else {
    // Invalid ID token
    exit(json_encode(array(
        "message" => "error on Google server",
        "statuscode" => 401
    )));
}

?>