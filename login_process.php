<?php
// login_process.php
session_start();

// Include the database connection file
require_once 'dbconnection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = trim($_POST['email']);
    $password = trim($_POST['password']);
    $role = trim($_POST['role']);

    if (empty($email) || empty($password) || empty($role)) {
        $_SESSION['error_message'] = "Please fill in all fields.";
        header("Location: login.php");
        exit();
    }

    try {
        // Use a prepared statement to prevent SQL injection and fetch user data
        $stmt = $conn->prepare("SELECT id, fullname, password_hash, role, profile_image_url FROM users WHERE email = ?");
        $stmt->execute([$email]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        // Verify the user exists, the password is correct, and the roles match
        if ($user && password_verify($password, $user['password_hash']) && $user['role'] === $role) {
            // Login successful, create session variables
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['fullname'] = $user['fullname'];
            $_SESSION['role'] = $user['role'];
            $_SESSION['profile_image_url'] = $user['profile_image_url'];

            // Redirect to the dashboard
            header("Location: dashboard.php");
            exit();

        } else {
            // Invalid email, password, or role
            $_SESSION['error_message'] = "Invalid email, password, or role.";
            header("Location: login.php");
            exit();
        }
    } catch(PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header("Location: login.php");
        exit();
    }
} else {
    header("Location: login.php");
    exit();
}
?>
