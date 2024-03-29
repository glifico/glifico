<?php
include_once 'functions.php';
include_once 'test.php';

$db = getDB();
if (! $db)
    exit();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
}

if (! $data) {
    exit(json_encode(array(
        "message" => "wrong request",
        "statuscode" => 400
    )));
}

$user = $data['user'];
$token = $data['token'];
$idrating = $data['downloadeddata']['idrating'];
$grammarmark = $data['ratings']['grammar'];
$stylemark = $data['ratings']['style'];
$languageto = $data['downloadeddata']['languageto'];
$languagefrom = $data['downloadeddata']['languagefrom'];

if (! certToken($db, $user, $token))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

$query = "SELECT username, grammarmark, stylemark from languagerating where id='$idrating';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);
$evaluatedUser = $row['username'];
$oldgrammar = $row['grammarmark'];
$oldstyle = $row['stylemark'];

if ($oldgrammar != null & $oldstyle != null) {
    $grammarmark = round(($grammarmark + $oldgrammar) / 2.);
    $stylemark = round(($oldstyle + $stylemark) / 2.);
}

$query = "UPDATE languagerating SET grammarmark = '$grammarmark' , stylemark = '$stylemark' where id='$idrating';";
$result = $db->query($query);

error_log("saving rating data: ".$query);


$tot = ($grammarmark + $stylemark) / 2;
updateTotalTest($db, $evaluatedUser, $languageto, $tot);
updateTotalTest($db, $evaluatedUser, $languagefrom, $tot);
exit(json_encode(array(
    "message" => "test submitted",
    "statuscode" => 200
)));
?>
