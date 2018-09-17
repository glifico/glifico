<?php
include 'functions.php';

$db = getDB();
if (! $db)
    exit();

$user = $_GET['user'];
$id = $_GET['id'];
if (! certToken($db, $user, $_GET['token']))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

$query = "SELECT * FROM payments WHERE translator='$user' and id='$id' LIMIT 1;";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$choice = $row['whoaccepted'];
if ($choice == 1) {
    $price = $row['price'];
    $currency = $row['currency'];
    $status = $row['status'];
} else if ($choice == 2) {
    $price = $row['secondprice'];
    $currency = $row['secondcurrency'];
    $status = $row['secondstatus'];
}

$result->CloseCursor();

exit(json_encode(array(
    "id" => $row['id'],
    "job" => $row['job'],
    "price" => $price,
    "currency" => $currency,
    "status" => $status,
    "link" => $row['translated'],
    "description" => $row['description']
)));
?>
