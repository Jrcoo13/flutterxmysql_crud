<?php

require_once('dbconnection.php');

try {
    // Prepare the SQL query
    $query = "SELECT id, name, email, join_date FROM users";
    $stmt = $pdo->prepare($query);

    // Execute the query
    if ($stmt->execute()) {
        // Fetch all results as an associative array
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Set header for JSON response
        // header('Content-Type: application/json');

        // Output the JSON-encoded data
        // echo json_encode($result);
        print(json_encode($result));
    } else {
        echo json_encode(['error' => 'Something went wrong']);
    }
} catch (Exception $ex) {
    // Log the error message
    error_log($ex->getMessage());

    // Output a generic error message
    echo json_encode(['error' => 'An error occurred. Please try again later.']);
}
?>