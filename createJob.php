<?php
include_once 'functions.php';
include_once 'updatePrices.php';

$db = getDB();
if (! $db)
    exit();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
}

if (! $data) {
    exit(json_encode(array(
        "message" => "wrong request",
        "statuscode" => 500
    )));
}

$user = $data['user'];
$url = $data['url'];
$count = $data['count'];
if($count < 1) $count=1;

$selected = $data['translators'];
$jobTitle = $data['job'];
if(strlen($jobTitle) < 1) $jobTitle="Agency job";

$jobDescr = $data['description'];
if(strlen($jobDescr) < 1) $jobDescr="Job without desciprion";


$deadline = $data['deadline'];
$createdline = date('Y-m-d H:i:s');
$translator = get_username($selected[0]['id']);
$firstPrice = $selected[0]['total'];
$firstCurrency = $selected[0]['currency'];
if ($count > 0) {
    $secondtranslator = get_username($selected[1]['id']);
    $secondPrice = $selected[1]['total'];
    $secondCurrency = $selected[1]['currency'];
}else{
    $secondtranslator = "";
    $secondPrice = "-1";
    $secondCurrency = "-1";
}
$n_characters = $data['ncharacters'];
$languagefrom = $data['languagefrom'];

if (! certTokenA($db, $user, $data['token']))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

$query = "INSERT INTO payments (job, description, status, username, document, languagefrom, ncharacters, translator, secondtranslator, secondstatus, currency, secondcurrency, deadline, price, secondprice, whoaccepted, createdline) VALUES ('$jobTitle','$jobDescr','To Be Assigned', '$user', '$url', '$languagefrom', '$n_characters', '$translator', '$secondtranslator', 'To Be Assigned', '$firstCurrency', '$secondCurrency' ,'$deadline','$firstPrice', '$secondPrice','0', '$createdline');";
$db->query($query);

// send_email([array("email"=>get_user_email($translator))],"There is a new job on glifico","You have a new job on glifico, go to https://glifico.com/pendingJobs.html to look it out!");
send_email([
    array(
        "email" => "fvalle.glifico@outlook.com"
    )
], "There is a new job on glifico", get_user_email($translator));

$retCurrencies = updateCurrencies();

exit(json_encode(array(
    "message" => "job created",
    "currencies"=> $retCurrencies,
    "statuscode" => 200,
    "selected" => json_encode($selected)
)));
?>
