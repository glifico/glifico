<?php
$dbopts = parse_url(getenv('DATABASE_URL'));
$dsn = "pgsql:"
."host=".$dbopts["host"].";"
. "dbname=".ltrim($dbopts["path"],'/').";"
. "user=".$dbopts["user"].";"
. "port=5432;"
. "sslmode=require;"
. "password=".$dbopts["pass"];
$db = new PDO($dsn);
if(!$db) exit;

$query="
CREATE TABLE IF NOT EXISTS `TRADUTTORE` (
  `ID` int(11) NOT NULL,
  `NOME` varchar(100) DEFAULT NULL,
  `COGNOME` varchar(100) DEFAULT NULL,
  `DATA_NASCITA` date DEFAULT NULL,
  `MADRELINGUA` varchar(100) DEFAULT NULL,
  `PASSWORD` varchar(50) DEFULT NULL,
  `HAS_NEW_MESSAGE` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
  ";

  $db->query($query);

  if(isset($_GET["user"])&&isset($_GET["password"])){
    $user=$_GET["user"];
    $password=$_GET["password"];
  }else{
    exit (json_encode(array("message"=>"error: user not found", "statuscode"=>400)));
  }


  $query="SELECT NOME, PASSWORD FROM traduttore WHERE nome='$nome'";
  $result = $db->query($query);
  $row = $result->fetch(PDO::FETCH_ASSOC);
  if($row["password"]==$password){
    echo json_encode(array("statuscode"=>200));
  }else{
    exit (json_encode(array("message"=>"error: wrong password", "statuscode"=>400)));
  }

  $result->CloseCursor();
  ?>
