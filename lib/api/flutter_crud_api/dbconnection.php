<?php

$hostname = "localhost";
$username = "root123";
$password = "root123";
try {
    $pdo = new PDO("mysql:host=$hostname;dbname=flutter_crud", $username, $password);
    }
catch(PDOException $e)
    {
    echo $e->getMessage();
    }

?>