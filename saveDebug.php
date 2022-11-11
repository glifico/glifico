<?php


if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"));
  print_r($data);
}

exit(json_encode(array("message"=>"Test submitted","statuscode"=>400,"score"=>$score,"domande"=>$data)));
?>
