<?php

include('dbconnection.php');

if (isset($_POST['name'], $_POST['email'], $_POST['password'])) {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    try {
        $query = "INSERT INTO users (name, email, password) VALUES (:name, :email, :password)";
        $stmt = $pdo->prepare($query);

        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':password', $password);

        $arr = [];
        if ($stmt->execute()) {
            $arr['success'] = true;
        } else {
            $arr['success'] = false;
        }

        print(json_encode($arr));
    } catch (Exception $ex) {
        echo json_encode(['success' => false, 'error' => $ex->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid input']);
}
?>
