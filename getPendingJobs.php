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

$query = "SELECT * FROM payments WHERE translator='$user' ORDER BY status DESC;";
$result = $db->query($query);
$toExit = [];

while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    $today = date("Y-m-d");
    $expire = $row['deadline']; //from database
    
    $today_time = strtotime($today);
    $expire_time = strtotime($expire);
    
    if ($expire_time < $today_time) { continue; }
    
    $language = $row['languagefrom'];
    $price = getLanguagePrice($user, $language) * $row['ncharacters'];
    array_push($toExit, array(
        "id" => $row['id'],
        "job" => $row['job'],
        "price" => $price,
        "ncharacters" => $row['ncharacters'],
        "currency" => $row['currency'],
        "status" => $row['status'],
        "document" => $row['document'],
        "description" => $row['description'],
        "deadline" => $row['deadline'],
        "choice" => 1
    ));
}

$query = "SELECT * FROM payments WHERE secondTranslator='$user' ORDER BY status DESC;";
$result = $db->query($query);
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    $today = date("Y-m-d");
    $expire = $row['deadline']; //from database
    
    $today_time = strtotime($today);
    $expire_time = strtotime($expire);
    
    if ($expire_time < $today_time) { continue; }
    
    $language = $row['languagefrom'];
    $price = getLanguagePrice($user, $language);
    array_push($toExit, array(
        "id" => $row['id'],
        "job" => $row['job'],
        "price" => $price,
        "currency" => $row['currency'],
        "status" => $row['secondstatus'],
        "ncharacters" => $row['ncharacters'],
        "document" => $row['document'],
        "description" => $row['description'],
        "deadline" => $row['deadline'],
        "choice" => 2
    ));
}

$result->CloseCursor();

exit(json_encode($toExit));

?>
