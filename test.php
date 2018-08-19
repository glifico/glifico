<?php
include_once 'functions.php';

function updateTotalTest($db, $user, $languageto, $tot)
{
    $query = "SELECT username, tottest FROM languages WHERE username='$user' AND language='$language' ORDER BY tottest DESC;";
    $result = $db->query($query);

    $row = $result->fetch(PDO::FETCH_ASSOC);
    $oldscore = $row['tottest'];
    $newscore = $tot;
    if ($oldscore != null) {
        $score = intval(($newscore + $oldscore) / 2);
    } else {
        $score = intval($tot);
    }
    if ($score > 5)
        $score = 5;
    
    $timestamp = time();
    $dt = new DateTime("now", new DateTimeZone("Europe/Rome")); // first argument "must" be a string
    $dt->setTimestamp($timestamp); // adjust the object to correct timestamp
    $today = $dt->format('Y-m-d H:i:s');

    $query = "UPDATE languages SET tottest='$score', datatest='$today' WHERE username='$user' and language='$languageto';";
    $result = $db->query($query);
    $result->CloseCursor();
}

?>
