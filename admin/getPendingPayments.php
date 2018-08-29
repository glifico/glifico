<?php
include '../functions.php';

$db = getDB();
if (! $db)
exit();

$user = $_GET['user'];
$token = $_GET['token'];
if ($user=='admin' & $token =='glifico'){
  exit(json_encode(array(
    "message" => "wrong token",
    "statuscode" => 400
  )));
}

$query = "SELECT * FROM payments ORDER BY createdline DESC;";
$result = $db->query($query);
$toExit = [];
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
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
    "translated" => $row['translated'],
    "choice"=>$row['whoaccepted'],
    "price" => [$row['price'], $row['secondprice']],
    "currency" => [$row['currency'],$row['secondcurrency']],
  ));
}


$result->CloseCursor();

exit(json_encode($toExit));

?>
