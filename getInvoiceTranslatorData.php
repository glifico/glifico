<?php
include 'functions.php';



$db=getDB();
if(!$db) exit;


$user=$_GET['user'];
if(!certToken($db, $user, $_GET['token'])) {
    exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));
}

$id=$_GET['id'];
$query="SELECT *, invoices.id as id_invoice FROM payments JOIN invoices ON invoices.job=payments.id WHERE payments.id='$id';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$price = (float) getLanguagePrice($user, $row['languagefrom'], $row['languageto'], $row['field']);
$price = (float) $price * $row['ncharacters'];

$result->CloseCursor();
exit (json_encode(array("id"=>$row['id_invoice'], "Price"=>$price, "Description"=>$row['description'], "Job"=>$row['job'], "Date"=>$row['date'], "jobDate"=>$row['createdline'], "ncharacters"=> $row['ncharacters'], "languages"=>array("from"=>$row['languagefrom'],"to"=>$row['languageto']), "urgency"=>$row['urgency'])));
?>
