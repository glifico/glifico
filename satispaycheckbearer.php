<?php
\SatispayOnline\Api::setSecurityBearer('osh_ea7knn45ljmjon41kbq542jdl7112k928aeddpvlb9o76qh0o6kfe2md7fh3taufj8l67kaforua611clg0b9e1ss90tl073b770l6jpmk4gjp0evvbui4rrdn6ggr2kcpj13nqn36ht88mmoqsujk1q02ojbsqai3klf0s7aqsdd195aa8bin4kvr7vc9ta6cvc8fcg');

try {
  \SatispayOnline\Bearer::check();
  echo 'OK';
} catch(\Exception $ex) {
  echo 'Invalid Security Bearer';
}

exit(0);
?>
