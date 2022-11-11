<?php
include 'fields.php';

$exit = [];
$id = 0;
foreach ($fields as $value) {
    array_push($exit, array(
        "Id" => $id,
        "Field" => $value
    ));
    $id += 1;
}
exit(json_encode($exit));
?>
