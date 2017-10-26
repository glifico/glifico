<?php
include 'functions.php';
include 'searchParams.php';

function doTheGaussian($prT, $Avg, $sigma)
{
  $normPrice=($prT-$Avg)/$sigma;
  $C=getCoefficients();

  if($normPrice<$C['A']){
    return 1;
  }
  else if($normPrice<$C['B']){
    return 2;
  }
  else if($normPrice<$C['C']) {
    return 3;
  }
//just in case be safe and use class C
  return 3;
}

$db=getDB();
if(!$db) exit;


if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
  $data = json_decode(file_get_contents("php://input"),true);
}

if(!$data){
  exit(json_encode(array("message"=>"wrong request","statuscode"=>400)));
}

$user=$data['user'];
$token=$data['token'];
$langFrom=$data['from'];
$langTo=$data['to'];
$reqRating=$data['rating'];
$reqPrice=$data['price'];
if(!certTokenA($db, $user, $token)) exit(json_encode(array("message"=>"wrong token", "statuscode"=>400)));

$query="SELECT username, from_l, to_l, price_euro from language_pair WHERE from_l LIKE '$langFrom' AND to_l LIKE '$langTo'";
$result = $db->query($query.";");


$pricequery="SELECT avg(price_euro) FROM($query) sub;";
$priceRes=$db->query($pricequery);
$priceRow=$priceRes->fetch(PDO::FETCH_ASSOC);
$priceAvg=$priceRow['avg'];

$sigmaquery="SELECT stddev_samp(price_euro) FROM($query) sub;";
$sigmaRes=$db->query($sigmaquery);
$sigmaRow=$sigmaRes->fetch(PDO::FETCH_ASSOC);
$sigma=$sigmaRow['stddev_samp'];



$toExit=[];
$dataToExit=[];
$maxB=0;
$NB=0;
$M=getMultipliers();
while($row = $result->fetch(PDO::FETCH_ASSOC)){
  $translator=$row['username'];

  $queryUser="SELECT * FROM traduttore WHERE username='$translator';";
  $resultUser = $db->query($queryUser);
  $rowUser=$resultUser->fetch(PDO::FETCH_ASSOC);


  $queryRating="SELECT * FROM languages WHERE language='$langTo' AND tottest>='$reqRating' AND username='$translator';";
  $resultRating = $db->query($queryRating);
  $rowRating=$resultRating->fetch(PDO::FETCH_ASSOC);


  $rating=$rowRating['tottest'];
  if($rating==NULL) $rating=0;

  $priceTransl=$row['price_euro'];
  $price=doTheGaussian($priceTransl,$priceAvg, $sigma);

  if($price==2){
    $NB+=1;
    if($priceTransl>=$maxB){
      $maxB=$priceTransl;
    }
  }

  if($rating>=$reqRating&&$price<=$reqPrice){
    array_push($dataToExit,array("Price"=>$price, "PriceTr"=>$priceTransl,"NormPrice"=>($priceTransl-$priceAvg)/$sigma, "Rating"=>$rating, "Field"=>"traduzioni", "FirstName"=>$rowUser['nome']{0},"LastName"=>$rowUser['cognome']{0}, "IdMothertongue"=>$rowUser['madrelinguaid'],"Mothertongue"=>$rowUser['madrelingua']));
  }
}

$toExit['data']=$dataToExit;
$toExit['params']=array("maxB"=>$maxB,"multA"=>$M['multA'],"multB"=>$M['multB'],"multC"=>$M['multC']);
$result->CloseCursor();
exit (json_encode($toExit));
?>
