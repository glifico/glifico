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
if ($count < 1) {
    $count = 1;
}

$selected = $data['translators'];
$jobTitle = $data['job'];
if (strlen($jobTitle) < 1)
    $jobTitle = "Agency job";

$jobDescr = $data['description'];
if (strlen($jobDescr) < 1)
    $jobDescr = "Job without description";

$deadline = $data['deadline'];
$timestamp = time();
$dt = new DateTime("now", new DateTimeZone("Europe/Rome")); // first argument "must" be a string
$dt->setTimestamp($timestamp); // adjust the object to correct timestamp
$createdline = $dt->format('Y-m-d H:i:s');

$fiesibility = $data['feasibility'];
if ($fiesibility == 1) {
    $urgency = 'yes';
} else {
    $urgency = "no";
}

$field = $data['field'];

$translator = get_username($selected[0]['id']);

$firstPrice = $selected[0]['total'];
$firstCurrency = $selected[0]['currency'];
if ($count > 0) {
    $secondtranslator = get_username($selected[1]['id']);
    $secondPrice = $selected[1]['total'];
    $secondCurrency = $selected[1]['currency'];
} else {
    $secondtranslator = "";
    $secondPrice = - 1;
    $secondCurrency = "-EUR";
}
$n_characters = $data['ncharacters'];
$languagefrom = $data['languagefrom'];
$languageto = $data['languageto'];

if (! certTokenA($db, $user, $data['token']))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

 $mailStatus = [];
    
if ($count == 1) {
    $query = "INSERT INTO payments (job, description, field, status, username, document, languagefrom, languageto, ncharacters, translator, currency, deadline, price, whoaccepted, createdline, urgency) VALUES ('$jobTitle','$jobDescr', '$field', 'To Be Assigned', '$user', '$url', '$languagefrom', '$languageto', '$n_characters', '$translator', '$firstCurrency','$deadline','$firstPrice','0', '$createdline', '$urgency');";
} else {
    $query = "INSERT INTO payments (job, description, field, status, username, document, languagefrom, languageto, ncharacters, translator, secondtranslator, secondstatus, currency, secondcurrency, deadline, price, secondprice, whoaccepted, createdline, urgency) VALUES ('$jobTitle','$jobDescr', '$field', 'To Be Assigned', '$user', '$url', '$languagefrom', '$languageto', '$n_characters', '$translator', '$secondtranslator', 'To Be Assigned', '$firstCurrency', '$secondCurrency' ,'$deadline','$firstPrice', '$secondPrice','0', '$createdline', '$urgency');";
    $mailStatus['first'] = send_email([
        array(
            "email" => get_user_email($secondtranslator)
        )
    ], "There is a new job on glifico", "You have a new job on glifico, go to https://glifico.com/pendingJobs.html to look it out! You have 5h to accept it! You are the second choice, so if first choice will accept job will not be yours.");
}

$mailStatus['second']=send_email([
    array(
        "email" => get_user_email($translator)
    )
], "There is a new job on glifico", "You have a new job on glifico, go to https://glifico.com/pendingJobs.html to look it out! You have 5 h to accept it!");

$result = $db->query($query);
$result->CloseCursor();

$retCurrencies = updateCurrencies();

exit(json_encode(array(
    "message" => "job created",
    "currencies" => $retCurrencies,
    "statuscode" => 200,
    "selected" => json_encode($selected),
    "email_status" => $mailStatus
)));
?>
