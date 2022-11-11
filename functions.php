<?php

function getDB()
{
    $dbopts = parse_url(getenv('DATABASE_URL'));
    $dsn = "pgsql:" . "host=" . $dbopts["host"] . ";" . "dbname=" . ltrim($dbopts["path"], '/') . ";" . "user=" . $dbopts["user"] . ";" . "port=5432;" . "sslmode=require;" . "password=" . $dbopts["pass"];
    $db = new PDO($dsn);
    return $db;
}

function tokenize($user, $password)
{
    return hash('crc32', $user . "tokenize" . $password);
}

function certToken($db, $user, $token)
{
    $query = "SELECT USERNAME, PASSWORD FROM traduttore WHERE username='$user';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);

    $password = htmlspecialchars($row['password']);
    $result->CloseCursor();
    return $token == hash('crc32', $user . "tokenize" . $password);
}

function certTokenA($db, $user, $token)
{
    $query = "SELECT USERNAME, PASSWORD FROM agenzia WHERE username='$user';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);

    $password = htmlspecialchars($row['password']);
    $result->CloseCursor();
    return $token == hash('crc32', $user . "tokenize" . $password);
}

function getLanguagePrice($user, $from, $to, $field = 'select all')
{
    $db = getDB();
    if (! $db){
        return;
    }
    if ($field = 'select all') {
        $query = "SELECT USERNAME, from_l, to_l, price_euro from language_pair WHERE username='$user' and from_l='$from' and to_l='$to' order by price_euro ASC;";
        $result = $db->query($query);
        $row = $result->fetch(PDO::FETCH_ASSOC);
    } else {
        $query = "SELECT USERNAME, from_l,  to_l, field, price_euro from language_pair WHERE username='$user' and from_l='$from' and to_l='$to' and field='$field';";
        $result = $db->query($query);
        $row = $result->fetch(PDO::FETCH_ASSOC);
    }
    
    $price = $row['price_euro'];
    $result->CloseCursor();
    return $price;
}

function get_user_email($user)
{
    $db = getDB();
    if (! $db)
        return;
    $query = "SELECT USERNAME, EMAIL FROM traduttore WHERE username='$user';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);

    $email = htmlspecialchars($row['email']);
    $result->CloseCursor();
    return $email;
}

function get_agency_email($user)
{
    $db = getDB();
    if (! $db)
        return;
        $query = "SELECT USERNAME, EMAIL FROM agenzia WHERE username='$user';";
        $result = $db->query($query);
        $row = $result->fetch(PDO::FETCH_ASSOC);
        
        $email = htmlspecialchars($row['email']);
        $result->CloseCursor();
        return $email;
}

function check_email_presence($email)
{
    $db = getDB();
    if (! $db)
        exit();

    $query = "SELECT email FROM agenzia WHERE email='$email';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);

    if (strlen(htmlspecialchars($row["email"])) > 2)
        exit(json_encode(array(
            "message" => "email already present",
            "statuscode" => 409
        )));
    $result->CloseCursor();

    $query = "SELECT email FROM traduttore WHERE email='$email';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);

    if (strlen(htmlspecialchars($row["email"])) > 2)
        exit(json_encode(array(
            "message" => "email already present",
            "statuscode" => 410
        )));
    $result->CloseCursor();
}

function get_currency_description($cur)
{
    $db = getDB();
    if (! $db)
        return;
    $query = "SELECT description FROM currencies WHERE currency='$cur';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);

    $descr = htmlspecialchars($row['description']);
    $result->CloseCursor();
    return $descr;
}

function convert_to_euro($price, $cur)
{
    $db = getDB();
    if (! $db)
        return;
    $query = "SELECT currency, conversion from currencies where currency='$cur';";
    $convResult = $db->query($query);
    $convRow = $convResult->fetch(PDO::FETCH_ASSOC);
    $priceEuro = round((float) $price / $convRow['conversion'], 2);
    if ($priceEuro < 0.01) {
        $priceEuro = 0.01;
    }
    $convResult->CloseCursor();
    return $priceEuro;
}

function get_username($id)
{
    $db = getDB();
    if (! $db)
        return;
    $query = "SELECT id, USERNAME FROM traduttore WHERE id='$id';";
    $result = $db->query($query);
    $row = $result->fetch(PDO::FETCH_ASSOC);

    $user = htmlspecialchars($row['username']);
    $result->CloseCursor();
    return $user;
}

function send_email($to, $subject, $body)
{
    $url = "https://api.sendgrid.com/v3/mail/send";
    $handle = curl_init($url);
    $data = '{
    "personalizations": [
      {
        "to": ' . json_encode($to) . ',
        "subject": "' . $subject . '"
      }
    ],
    "from": {
      "email": "info@glifico.com"
    },
    "content": [
      {
        "type": "text/plain",
        "value": "' . $body . '"
      }
    ]
  }';

    curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($handle, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($handle, CURLOPT_TIMEOUT, 60);
    curl_setopt($handle, CURLOPT_HTTPHEADER, array(
        'Authorization: Bearer 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',
        'Content-Type: application/json'
    ));
    curl_setopt($handle, CURLOPT_POSTFIELDS, $data);
    $result = curl_exec($handle);
    return $result;
}

function notifySlack($channel, $text, $emoji = "::")
{
    $url = "https://hooks.slack.com/services/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";
    $handle = curl_init($url);
    curl_setopt($handle, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($handle, CURLOPT_CONNECTTIMEOUT, 5);
    curl_setopt($handle, CURLOPT_TIMEOUT, 60);
    curl_setopt($handle, CURLOPT_HTTPHEADER, array(
        'Content-Type: application/json'
    ));
    $data = '{
    "channel": "' . $channel . '",
    "username": "Glifico server",
    "text": "' . $text . '",
    "icon_emoji": "' . $emoji . '"
  }
  ';
    curl_setopt($handle, CURLOPT_POSTFIELDS, $data);

    curl_exec($handle);
}
?>
