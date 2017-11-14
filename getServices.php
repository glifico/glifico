<?php
$currencies=array("Translations","Interpretations");


$exit=[];
$id=0;
foreach ($currencies as $value) {
  array_push($exit,array("Id"=>$id,"Service"=>$value));
  $id+=1;
}
exit(json_encode($exit));
 ?>
