<?php
include 'functions.php';



$db=getDB();
if(!$db) exit;


$user=$_GET['user'];
if(!certTokenA($db, $user, $_GET['token'])) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$id=$_GET['id'];
$query="SELECT * FROM payments WHERE id='$id' and username='$user';";
$result = $db->query($query);
$row = $result->fetch(PDO::FETCH_ASSOC);

$result->CloseCursor();
exit (json_encode(array("id"=>$row['id'], "Price"=>$row['price'], "Description"=>$row['description'], "Job"=>$row['job'], "Date"=>$row['deadline'])));
?>
