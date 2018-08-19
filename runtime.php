<?php 
require_once 'technicalstatus.php';
require_once 'functions.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
    $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
    exit(json_encode(array("message"=>"wrong request","statuscode"=>500)));
}

$user=$data['user'];
$token=$data['token'];

$db = getDB();
if (! $db) exit(array("message"=>"missing db", "statuscode"=> 409));


    
$timestamp = time();
$now = new DateTime("now", new DateTimeZone("Europe/Rome"));
$now->setTimeStamp($timestamp);

$query = "SELECT * FROM payments ORDER BY creationline DESC;";
$result = $db->query($query);
$toExit = [];
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
   $element = [];
   $element['job'] = $row;
   
   $createdTime = new DateTime($row['createdline'], new DateTimeZone("Europe/Rome"));
   $interval = $now->diff($createdTime);
   
   
   $element['createdsince'] = $interval->format("i");
   array_push($toExit, $element);
}
$result->CloseCursor();

exit(json_encode($toExit));
?>