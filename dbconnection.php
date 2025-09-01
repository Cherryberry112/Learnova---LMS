<?php
// dbconnection.php
// This file handles the database connection using PDO.
// It is designed to be included at the top of other PHP files.

$servername = "localhost";
$username = "root"; // Your database username
$password = ""; // Your database password
$dbname = "learnovaDB";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    // Set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // You can now use the $conn object for database operations in files that include this one.
} catch(PDOException $e) {
    // In a production environment, you would log this error and show a user-friendly message.
    echo "Connection failed: " . $e->getMessage();
    exit(); // Stop script execution on a database connection error
}

?>
