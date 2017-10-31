<?php
include 'functions.php';

$db=getDB();
if(!$db) exit;

$query="SELECT currency, conversion from currencies;";
$result = $db->query($query);

$toExit=[];
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  array_push($toExit,array("Id"=>$row['currency']{3},"Currency"=>$row['currency']));
}


$result->CloseCursor();
exit(json_encode($toExit));
 ?>
