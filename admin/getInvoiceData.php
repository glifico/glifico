<?php
include '../functions.php';



$db=getDB();
if(!$db) exit;


$id=$_GET['id'];
$query="SELECT * FROM payments WHERE id='$id';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

if ($row['whoaccepted'] == 1) {
    $price = (float) $row['price'];
} else {
    $price = (float) $row['secondprice'];
}

$query="SELECT * FROM invoices WHERE job='$id';";
$result = $db->query($query);
$invoice = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
exit (json_encode(array("id"=>$invoice['id'], "agency"=>$row['username'], "Price"=>$price, "Description"=>$row['description'], "Job"=>$row['job'], "Date"=>$invoice['date'], "jobDate"=>$row['createdline'], "ncharacters"=> $row['ncharacters'], "languages"=>array("from"=>$row['languagefrom'],"to"=>$row['languageto']), "urgency"=>$row['urgency'])));
?>
