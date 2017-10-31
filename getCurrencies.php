<?php
include 'functions.php';

$toExit=[];

$db=getDB();
if(!$db) exit;

$query="SELECT * from currencies;";
$result = $db->query($query);

while($row=$result->fetch(PDO::FETCH_ASSOC)) {
  array_push($exit,array("Id"=>$row['currency'],"Currency"=>$row['description']));
  $id+=1;
}

$result->CloseCursor();
exit(json_encode($toExit));
 ?>
