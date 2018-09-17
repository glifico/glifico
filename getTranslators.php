<?php
include_once 'functions.php';
include_once 'searchParams.php';
include_once 'updatePrices.php';

function doTheGaussian($prT, $Avg, $sigma)
{
    if ($sigma != 0) {
        $normPrice = (float) ($prT - $Avg) / $sigma;
        $C = getCoefficients();
        
        if ($normPrice < $C['A']) {
            return 1;
        } else if ($normPrice < $C['B']) {
            return 2;
        } else if ($normPrice < $C['C']) {
            return 3;
        }
    } else {
        $normPrice = $prT;
    }
    // just in case be safe and use class C
    return 3;
}

function getInfo($user)
{
    $db = getDB();
    if (! $db)
        exit();
    $toexit = [];
    $query = "select * from languages WHERE username='$user';";
    $result = $db->query($query);
    try {
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        array_push($toexit, array("language"=>$row['language'], "rating"=>$row['tottest']));
    }
    }catch (Exception $e){
        
    }
    $result->CloseCursor();
    return $toexit;
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

updateCurrencies();

$user = $data['user'];
$token = $data['token'];
$langFrom = $data['from'];
$langTo = $data['to'];
$reqRating = $data['rating'];
$reqPrice = $data['price'];
$field = $data['field'];
if (!certTokenA($db, $user, $token))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

$query = "SELECT username, from_l, to_l";

if (strcmp($field, "select all") !== 0) {
    $query = $query . ", field, price_euro FROM language_pair WHERE field LIKE '$field' AND ";
}else{
    $query = $query . ", min(price_euro) as price_euro FROM language_pair WHERE";
    }

$query = $query . " from_l LIKE '$langFrom' AND to_l LIKE '$langTo'";

if (strcmp($field, "select all") !== 0) {
}else{
    $query = $query." GROUP BY username, from_l, to_l";
}

$result = $db->query($query . ";");

$pricequery = "SELECT avg(price_euro) FROM($query) sub;";
$priceRes = $db->query($pricequery);
$priceRow = $priceRes->fetch(PDO::FETCH_ASSOC);
$priceAvg = $priceRow['avg'];

$sigmaquery = "SELECT stddev_samp(price_euro) FROM($query) sub;";
$sigmaRes = $db->query($sigmaquery);
$sigmaRow = $sigmaRes->fetch(PDO::FETCH_ASSOC);
$sigma = $sigmaRow['stddev_samp'];

$toExit = [];
$dataToExit = [];
$maxB = 0;
$NumberOfElementsinB = 0;
$M = getMultipliers();
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    $translator = $row['username'];
    
    $queryUser = "SELECT * FROM traduttore WHERE username='$translator';";
    $resultUser = $db->query($queryUser);
    $rowUser = $resultUser->fetch(PDO::FETCH_ASSOC);
    
    $queryRating = "SELECT * FROM languages WHERE language='$langTo' AND tottest>='$reqRating' AND username='$translator';";
    $resultRating = $db->query($queryRating);
    $rowRating = $resultRating->fetch(PDO::FETCH_ASSOC);
    
    $rating = $rowRating['tottest'];
    if ($rating == NULL){
        $rating = 0;
    }
    $priceTransl = $row['price_euro'];
    $priceClass = doTheGaussian($priceTransl, $priceAvg, $sigma);
    
    if ($priceClass == 2) {
        $NumberOfElementsinB += 1;
        if ($priceTransl >= $maxB) {
            $maxB = $priceTransl;
        }
    }
    
    if ($rating >= $reqRating && $priceClass <= $reqPrice) {
        // add randomnsess to id to avoid identifyng users
        $id = 1000 + 42 * $rowUser['id'];
        // id is to be shown
        // code is app private identifier in the database
        if ($sigma != 0) {
            $normPrice = (float) ($priceTransl - $Avg) / (float) $sigma;
        } else {
            $normPrice = $priceTransl;
        }
        array_push($dataToExit, array(
            "Id" => $id,
            "Code" => $rowUser['id'],
            "Price" => $priceClass,
            "PriceTr" => $priceTransl,
            "NormPrice" => $normPrice,
            "Rating" => $rating,
            "Field" => $row['field'],
            "FirstName" => $rowUser['nome']{0},
            "LastName" => $rowUser['cognome']{0},
            "IdMothertongue" => $rowUser['madrelinguaid'],
            "Mothertongue" => $rowUser['madrelingua'],
            "UserInfo" => getInfo($translator),
        ));
    }
}

$toExit['data'] = $dataToExit;
$toExit['params'] = array(
    "maxB" => $maxB,
    "multA" => $M['multA'],
    "multB" => $M['multB'],
    "multC" => $M['multC']
);
$result->CloseCursor();
exit(json_encode($toExit));
?>
