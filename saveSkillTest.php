<?php
include_once 'functions.php';
include_once 'test.php';

function search($db, $id)
{
    $query = "SELECT id, scelta FROM skilltest WHERE id='$id';";

    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);

    return $row['scelta'];
}

function updateTest($db, $user, $languageto, $tot)
{
    $timestamp = time();
    $dt = new DateTime("now", new DateTimeZone("Europe/Rome")); // first argument "must" be a string
    $dt->setTimestamp($timestamp); // adjust the object to correct timestamp
    $today = $dt->format('Y-m-d H:i:s');
    $query = "UPDATE languages SET skilltest='$tot', datatest='$today' WHERE username='$user' and language='$languageto';";
    $result = $db->query($query);
}

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
$domande = $data['document'];
if (! certToken($db, $user, $token))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

$currentscore = 0;

foreach ($domande as $domanda) {
    $id = $domanda['id'];
    $risposta = search($db, $id);
    if ($risposta == $domanda['scelta'])
        $currentscore += 1;
}

$newscore = 5 * (float) $currentscore / count($domande);

// get old data to make a mean
$language = $domande[0]['language'];
$query = "SELECT username, skilltest FROM languages WHERE username='$user' AND language='$language' ORDER BY skilltest DESC;";
$result = $db->query($query);

$row = $result->fetch(PDO::FETCH_ASSOC);
$oldscore = $row['skilltest'];
if ($oldscore != null) {
    $score = intval(($newscore + $oldscore) / 2);
} else {
    $score = intval($newscore);
}
if ($score > 5)
    $score = 5;

updateTest($db, $user, $language, $score);
updateTotalTest($db, $user, $language, $newscore);

$result->CloseCursor();
exit(json_encode(array(
    "message" => "test submitted",
    "statuscode" => 200,
    "score" => $currentscore
)));
?>
