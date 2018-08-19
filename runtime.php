<?php
require_once 'technicalstatus.php';
require_once 'functions.php';

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
$token = $data['token'];

$db = getDB();
if (! $db)
    exit(array(
        "message" => "missing db",
        "statuscode" => 409
    ));

$timestamp = time();
$now = new DateTime("now", new DateTimeZone("Europe/Rome"));
$now->setTimeStamp($timestamp);

$query = "SELECT * FROM payments ORDER BY createdline DESC;";
$result = $db->query($query);
$toExit = [];
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    $element = [];
    $element['job'] = $row['id'];
    $element['object'] = $row;

    $createdTime = new DateTime($row['createdline'], new DateTimeZone("Europe/Rome"));
    $interval = $createdTime->diff($now);
    $minutes = ($interval->i + $interval->h * 60 + $interval->d * 24 * 60);

    $element['interval'] = $interval;
    $element['createdsince'] = $minutes;

    if ($minutes < 180) {
        $status = "new";
    } else if ($minutes < 300) {
        $status = "notify";
    } else {
        $status = "over";
    }

    $first = $row['status'];
    $second = $row['secondstatus'];
    $choice = $row['whoaccepted'];

    $element['status'] = $status;
    $element['first'] = $first;
    $element['second'] = $second;
    $element['choice'] = $choice;

    $advised = $row['firstcall'];
    $alarmed = $row['secondcall'];
    $id = $row['id'];
    
    $runtimeAction = "";

    if ($second == "Refused") {
        if ($first == "Accepted") {
            $query = "UPDATE payments SET status='Assigned', whoaccepted=1  WHERE id='$id';";
            $result = $db->query($query);
            
            $runtimeAction = "first accepted second refused";
            
            array_push($toExit, $element);
            continue;
        }
    }

    if ($first == "Refused") {
        if ($second == "Accepted") {
            $query = "UPDATE payments SET secondstatus='Assigned', whoaccepted=2  WHERE id='$id';";
            $result = $db->query($query);
            
            $runtimeAction = "second accepted first refused";
            
            array_push($toExit, $element);
            continue;
        }
    }

    if ($first == "Accepted") {
        if ($advised == 0) {
            $query = "UPDATE payments SET status='Assigned', secondstatus='Other accepted', whoaccepted=1, firstcall=1  WHERE id='$id';";
            $result = $db->query($query);
            send_email([
                array(
                    // "email" => get_user_email($row['secondtranslator'])
                    "email" => "fvalle.glifico@outlook.com"
                )
            ], "Job notice on Glifico", "We're sorry but translator who was first choice accepted job: " . $row['job']);
        
            $runtimeAction = "first accepted second advised";
        } else {}
    }

    if ($status == "over") {
        if ($advised == 0) {
            if ($row['whoaccepted'] == 0) {
                send_email([
                    array(
                        // "email" => get_user_email($row['secondtranslator'])
                        "email" => "fvalle.glifico@outlook.com"
                    )
                ], "Job on Glifico requires you", "Go to glifico.com, no one of the translators you selected accepted the job " . $row['job'] . ", try search again!");
            }
            
            $query = "UPDATE payments SET firstcall=1  WHERE id='$id';";
            $result = $db->query($query);
            
            $runtimeAction = "nobody accepted, agency allerted";
        }
    } else if ($status == "new") {} else if ($status == "notify") {
        if ($first != "Accepted" && $second != "Accepted") {
            if ($alarmed == 0) {
                send_email([
                    array(
                        // "email" => get_user_email($row['secondtranslator'])
                        "email" => "fvalle.glifico@outlook.com"
                    )
                ], "New Job on Glifico", "Go to glifico.com, there is a new job and you have less than 2h to accept it");

                send_email([
                    array(
                        // "email" => get_user_email($row['secondtranslator'])
                        "email" => "fvalle.glifico@outlook.com"
                    )
                ], "New Job on Glifico", "Go to glifico.com, there is a new job and you have less than 2h to accept it");

                $query = "UPDATE payments SET secondcall=1  WHERE id='$id';";
                $result = $db->query($query);
            
                $runtimeAction = "2h remaining";
            }
        }
    }
    
    $element['runtime'] = $runtimeAction;

    array_push($toExit, $element);
}
$result->CloseCursor();

exit(json_encode($toExit));
?>