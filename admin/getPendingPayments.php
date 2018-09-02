<?php
include '../functions.php';

$db = getDB();
if (! $db)
    exit();

$user = $_GET['user'];
$token = $_GET['token'];
if ($user != 'admin' || $token != 'glifico') {
    exit(json_encode(array(
        "message" => "wrong token",
        "statuscode" => 400
    )));
}

$query = "SELECT tp.*, i.id as invoice_number, i.date as invoice_date  FROM payments tp LEFT JOIN invoices i on tp.id = i.job ORDER BY tp.createdline DESC;";
$result = $db->query($query);
$toExit = [];
while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
    if ($row['whoaccepted'] <= 1) {
        $translator=$row['translator'];
        $price = $row['price'];
        $currency = $row['currency'];
        $status = $row['status'];
        $translator_price = getLanguagePrice($row['translator'], $row['languagefrom'], $row['languageto'], $row['field']);
    } else {
        $translator=$row['secondtranslator'];
        $price = $row['secondprice'];
        $currency = $row['secondcurrency'];
        $status = $row['secondstatus'];
        $translator_price = getLanguagePrice($row['secondtranslator'], $row['languagefrom'], $row['languageto'], $row['field']);
    }

    array_push($toExit, array(
        "id" => $row['id'],
        "job" => $row['job'],
        "price" => $row['price'],
        "currency" => $row['currency'],
        "field" => $row['field'],
        "status" => $row['status'],
        "preview" => $row['preview'],
        "document" => $row['document'], 
        "translated" => $row['translated'],
        "description" => $row['description'],
        "price" => $price,
        "currency" => $currency,
        "deadline" => $row['deadline'],
        "createdline" => $row['createdline'],
        "ncharacters" => $row['ncharacters'],
        "choice" => $row['whoaccepted'],
        "translator"=>$translator,
        "status" => $status,
        "urgency"=>$row['urgency'],
        "price_to_translator" => $translator_price * $row['ncharacters']
    ));
}

$result->CloseCursor();

exit(json_encode($toExit));

?>
