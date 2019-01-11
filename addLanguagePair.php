<?php
require_once 'functions.php';
require_once 'languages.php';
require_once 'fields.php';
require_once 'speak.php';

$db = getDB();
if (! $db)
    exit();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
}

if (! $data) {
    exit(json_encode(array(
        "message" => "wrong request",
        "statuscode" => 500
    )));
}

$user = $data['user'];
$pair = $data['values'];
$from = $language_codes[$pair['IdLanguageFrom']];
$to = $language_codes[$pair['IdLanguageTo']];
$price = $pair['PricePerWord'] / 6.;

if ($price == 0) {
    $price = 0.001;
}

$price_euro = convert_to_euro($price, $pair['IdCurrency']);
$currency = get_currency_description($pair['IdCurrency']);
$idField = $pair['IdParametro_Field'];
$idService = $pair['IdParametro_Service'];
$field = $fields[$idField];
$service = "translations";

if (! certToken($db, $user, $data['token']))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

$query = "Select username, from_l, to_l, field from language_pair where username='$user' and from_l='$from' and to_l='$to' and field='$field';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
if (strlen(htmlspecialchars($row["username"])) > 2) {
    exit(json_encode(array(
        "message" => "language pair already present",
        "statuscode" => 305
    )));
}

$query = "INSERT INTO language_pair (username,from_l,to_l,price,price_euro,field,service,currency) VALUES ('$user','$from','$to','$price','$price_euro','$field','$service','$currency');";
$result = $db->query($query);

user_try_add_lang($user, $from);
user_try_add_lang($user, $to);

exit(json_encode(array(
    "message" => "language added",
    "statuscode" => 200
)));
?>
