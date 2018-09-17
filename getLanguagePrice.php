<?php
include 'functions.php';

function getLanguagePrice($user, $language)
{
    $db = getDB();
    if (! $db)
        exit();
    
    $user = $_GET['user'];
    if (! certToken($db, $user, $_GET['token']))
        exit(json_encode(array(
            "message" => "wrong token",
            "statuscode" => 400
        )));
    
    $language = $_GET['language'];
    
    $query = "select * from language_pair where username='$user' and from_l='$language' limit 1;";
    $result = $db->query($query);
    $result->CloseCursor();
    
    $toExit = array(
        "LanguageFrom" => $row['from_l'],
        "Price" => $row['price'],
        "Currency" => $row['currency'],
        "Price_euro" => $row['price_euro']
    );
    return (json_encode($toExit));
}
?>
