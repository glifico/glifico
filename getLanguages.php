<?php
include 'languages.php';

asort($language_codes);


$exit=[];
array_push($exit,array("Id"=>"en","Language"=>"English"));

foreach ($language_codes as $key => $value) {
  array_push($exit,array("Id"=>$key,"Language"=>$value));
}
exit(json_encode($exit));
?>
