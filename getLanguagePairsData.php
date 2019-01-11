<?php
include 'functions.php';

$db = getDB();
if (! $db)
    exit();

$user = $_GET['user'];
if (! certToken($db, $user, $_GET['token']))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

$query = "SELECT username, from_l, to_l, price, currency, field, service from language_pair WHERE username='$user';";
$result = $db->query($query);

$toExit = [];
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    $price = round($row['price'], 4) / 6.;
    array_push($toExit, array(
        "LanguageFrom" => $row['from_l'],
        "LanguageTo" => $row['to_l'],
        "Price" => $price,
        "Currency" => $row['currency'],
        "Field" => $row['field'],
        "Service" => $row['service']
    ));
}

exit(json_encode($toExit));
?>
