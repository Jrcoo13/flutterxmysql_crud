<?php

require_once('dbconnection.php');
if(isset($_POST['name'])) {
    $name = $_POST['name'];
} else return;

if(isset($_POST['email'])) {
    $email = $_POST['email'];
} else return;


if(isset($_POST['id'])) {

    $id = $_POST['id'];

    try {
        $query = "UPDATE users SET name = :name, email = :email WHERE id = :id";
        $stmt = $pdo->prepare($query);

        $stmt->bindParam(':id', $id);
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':email', $email);

        $array = [];
        if($stmt->execute()) {
            $array['success'] = true;
        }
        else {
            $array['success'] = false;
        }
        print(json_encode($array));
    }
    catch(Exception $ex) {
        $ex->getMessage();
    }
}
else return;
?>