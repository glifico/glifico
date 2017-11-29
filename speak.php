<?php
include 'functions.php'

function user_speak_lang($user, $lang)
{
  $db=getDB();
  if(!$db) exit;

  $query="SELECT username, language FROM languages WHERE username='$user';";
  $result = $db->query($query);
  $speak=False;
  while($row = $result->fetch(PDO::FETCH_ASSOC)){
    if($row['language']==$lang) $speak=True;
  }
  $result->CloseCursor();
  return $speak;
}

function user_add_lang($user, $lang){
  $db=getDB();
  if(!$db) exit;

  $query="INSERT INTO languages (username, language) VALUES('$user','$lang');";
  $result = $db->query($query);

  $result->CloseCursor();
}

function user_try_add_lang($user,$lang){
  if(!user_speak_lang($user,$lang)) user_add_lang($user,$lang);
}

?>
