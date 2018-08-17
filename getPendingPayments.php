<?php
include 'functions.php';

$db = getDB();
if (! $db)
    exit();

$user = $_GET['user'];
if (! certTokenA($db, $user, $_GET['token']))
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));

$query = "SELECT * FROM payments WHERE username='$user' ORDER BY status DESC;";
$result = $db->query($query);
$toExit = [];
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    if ($row['whoaccepted'] == 1) {
        if ($row['status'] == "Paid") {
            array_push($toExit, array(
                "id" => $row['id'],
                "job" => $row['job'],
                "price" => $row['price'],
                "currency" => $row['currency'],
                "status" => $row['status'],
                "document" => $row['translated'],
                "description" => $row['description'],
                "deadline" => $row['deadline'],
                "createdline" => $row['createdline'],
                "ncharacters" => $row['ncharacters'],
                "choice"=>1
            ));
        } else {
            array_push($toExit, array(
                "id" => $row['id'],
                "job" => $row['job'],
                "price" => $row['price'],
                "currency" => $row['currency'],
                "status" => $row['status'],
                "document" => $row['preview'],
                "description" => $row['description'],
                "deadline" => $row['deadline'],
                "createdline" => $row['createdline'],
                "ncharacters" => $row['ncharacters'],
                "choice"=>1
            ));
        }
    } else if ($row['whoaccepted'] == 2) {
        if ($row['status'] == "Paid") {
            array_push($toExit, array(
                "id" => $row['id'],
                "job" => $row['job'],
                "price" => $row['secondprice'],
                "currency" => $row['secondcurrency'],
                "status" => $row['secondstatus'],
                "document" => $row['translated'],
                "description" => $row['description'],
                "deadline" => $row['deadline'],
                "createdline" => $row['createdline'],
                "ncharacters" => $row['ncharacters'],
                "choice"=>2
            ));
        } else {
            array_push($toExit, array(
                "id" => $row['id'],
                "job" => $row['job'],
                "price" => $row['secondprice'],
                "currency" => $row['secondcurrency'],
                "status" => $row['secondstatus'],
                "document" => $row['preview'],
                "description" => $row['description'],
                "deadline" => $row['deadline'],
                "createdline" => $row['createdline'],
                "ncharacters" => $row['ncharacters'],
                "choice"=>2
            ));
        }
    } else if ($row['whoaccepted'] == 0) {
        array_push($toExit, array(
            "id" => $row['id'],
            "job" => $row['job'],
            "price" => [$row['price'], $row['secondprice']],
            "currency" => [$row['currency'],$row['secondcurrency']],
            "status" => "To Be Assigned",
            "document" => $row['preview'],
            "description" => $row['description'],
            "deadline" => $row['deadline'],
            "createdline" => $row['createdline'],
            "ncharacters" => $row['ncharacters'],
            "choice"=>0
        ));
    }
}


$result->CloseCursor();

exit(json_encode($toExit));

?>
