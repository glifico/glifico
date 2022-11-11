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

$query = "SELECT username, language, datatest, skilltest FROM languages WHERE username='$user' ORDER BY tottest DESC;";
$result = $db->query($query);
$toExit = [];
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    $querytr = "SELECT nome, cognome FROM traduttore WHERE username='$user';";
    $resultTr = $db->query($querytr);
    $rowTr = $resultTr->fetch(PDO::FETCH_ASSOC);
    
    $transaltor = array(
        "Name"->$rowTr['nome'],
        "Surname"->$rowTr['cognome']
    );
 
    array_push($toExit, array(
        "Translator"=>$rowTr,
        "Language" => $row['language'],
        "TotTest" => $row['skilltest'],
        "DataTest" => $row['datatest']
    ));
}

$result->CloseCursor();

exit(json_encode($toExit));
?>
