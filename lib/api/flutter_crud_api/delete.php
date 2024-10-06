<?php

require_once('dbconnection.php');

if(isset($_POST['id'])) {

    $id = $_POST['id'];
    try {
        $query = "DELETE FROM users WHERE id='$id'";
        $stmt = $pdo->prepare($query);
        
        $array = [];
        if ($stmt->execute()) {
            $array['success'] = true;
        } else {
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