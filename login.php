<?php
include 'functions.php';

$db = getDB();
if (! $db)
    exit();

// tables are traduttere and agenzia
// select * from traduttore,agenzia;
// use that for more information

if (isset($_GET["user"]) && isset($_GET["password"])) {
    $user = $_GET["user"];
    $password = $_GET["password"];
    $salted = $user . "startup" . $password;
    $pwd = hash('sha256', $salted);
} else {
    exit(json_encode(array(
        "message" => "error: user not found",
        "statuscode" => 400
    )));
}

$query = "SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
$type = "T";

if (strlen(htmlspecialchars($row["username"])) < 2) {
    // translator not found look for agency
    $query = "SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);
    $type = "A";
}

if (htmlspecialchars($row["password"]) == $pwd) {
    $token = tokenize($user, $pwd);
    exit (json_encode(array(
        "user" => $user,
        "token" => $token,
        "type" => $type,
        "statuscode" => 200
    )));
} else {
    exit(json_encode(array(
        "message" => "error: wrong password",
        "statuscode" => 400
    )));
}

$result->CloseCursor();
?>
