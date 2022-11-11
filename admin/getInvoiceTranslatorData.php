<?php
include '../functions.php';



$db=getDB();
if(!$db) exit;


$id=$_GET['id'];
$query="SELECT invoices.id as id_invoice, tp.whoaccepted, tp.translator, tp.secondtranslator, tp.languagefrom, tp.languageto, tp.ncharacters, tp.field, tp.description, tp.job, invoices.date, tp.createdline, tp.urgency FROM payments tp JOIN invoices ON invoices.job=tp.id WHERE tp.id='$id';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

if($row['whoaccepted']==1){
    $user=$row['translator'];
}else if($row['whoaccepted']==2){
    $user=$row['secondtranslator'];
}

$price = (float) getLanguagePrice($user, $row['languagefrom'], $row['languageto'], $row['field']);
$price = (float) $price * $row['ncharacters'];

$result->CloseCursor();
exit (json_encode(array("id"=>$row['id_invoice'], "Translator"=>$user, "Price"=>$price, "Description"=>$row['description'], "Job"=>$row['job'], "Date"=>$row['date'], "jobDate"=>$row['createdline'], "ncharacters"=> $row['ncharacters'], "languages"=>array("from"=>$row['languagefrom'],"to"=>$row['languageto']), "urgency"=>$row['urgency'])));
?>
