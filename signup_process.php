<?php
// signup_process.php
session_start();

// Include the database connection file
require_once 'dbconnection.php';

// Include the PHPMailer library files
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

require 'mail/PHPMailer.php';
require 'mail/SMTP.php';
require 'mail/Exception.php';

// Check if the form was submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $fullname = trim($_POST['fullname']);
    $email = trim($_POST['email']);
    $password = trim($_POST['password']);
    $role = trim($_POST['role']);
    $profileImageName = null;

    if (empty($fullname) || empty($email) || empty($password) || empty($role)) {
        $_SESSION['error_message'] = "Please fill in all required fields.";
        header("Location: signup.php");
        exit();
    }

    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $_SESSION['error_message'] = "Invalid email format.";
        header("Location: signup.php");
        exit();
    }

    // Check if email already exists
    try {
        $stmt = $conn->prepare("SELECT COUNT(*) FROM users WHERE email = ?");
        $stmt->execute([$email]);
        if ($stmt->fetchColumn() > 0) {
            $_SESSION['error_message'] = "This email is already registered.";
            header("Location: signup.php");
            exit();
        }
    } catch(PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header("Location: signup.php");
        exit();
    }

    // Hash the password for security
    $password_hash = password_hash($password, PASSWORD_DEFAULT);
    
    // Handle profile image upload
    if (isset($_FILES['profile-image']) && $_FILES['profile-image']['error'] == 0) {
        $target_dir = "uploads/";
        $file_name = uniqid() . '-' . basename($_FILES["profile-image"]["name"]);
        $target_file = $target_dir . $file_name;
        $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

        // Check if image file is a actual image or fake image
        $check = getimagesize($_FILES["profile-image"]["tmp_name"]);
        if ($check !== false) {
            // Check file size
            if ($_FILES["profile-image"]["size"] > 500000) { // 500KB limit
                $_SESSION['error_message'] = "Sorry, your file is too large.";
                header("Location: signup.php");
                exit();
            }
            // Allow certain file formats
            if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif") {
                $_SESSION['error_message'] = "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
                header("Location: signup.php");
                exit();
            }
            // Move the file
            if (move_uploaded_file($_FILES["profile-image"]["tmp_name"], $target_file)) {
                $profileImageName = $target_file;
            } else {
                $_SESSION['error_message'] = "Sorry, there was an error uploading your file.";
                header("Location: signup.php");
                exit();
            }
        } else {
            $_SESSION['error_message'] = "File is not an image.";
            header("Location: signup.php");
            exit();
        }
    }

    // Insert user data into the database
    try {
        // ... (your existing database insertion and session code)
        $stmt = $conn->prepare("INSERT INTO users (fullname, email, password_hash, role, profile_image_url) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$fullname, $email, $password_hash, $role, $profileImageName]);

        $userId = $conn->lastInsertId();
        $_SESSION['user_id'] = $userId;
        $_SESSION['fullname'] = $fullname;
        $_SESSION['role'] = $role;
        $_SESSION['profile_image_url'] = $profileImageName;

        // --- Start of new code to send welcome email with PHPMailer ---
        $mail = new PHPMailer(true);

        try {
            // Server settings
            $mail->isSMTP();
            $mail->Host       = 'smtp.gmail.com';
            $mail->SMTPAuth   = true;
            $mail->Username   = 'lernova.official@gmail.com'; // Your Gmail address
            $mail->Password   = 'jcxwjaevtterkuys'; // Use the App Password you generated
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
            $mail->Port       = 465;

            // Recipients
            $mail->setFrom('lernova.official@gmail.com', 'Learnova Team');
            $mail->addAddress($email, $fullname);

            // Content
            $mail->isHTML(true);
            $mail->Subject = 'Welcome to Learnova!';
            $mail->Body    = <<<EOT
<div style="font-family: 'Poppins', Arial, sans-serif; background-color: #f7f9fc; padding: 40px 0; color: #333333;">
  <div style="max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 10px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); overflow: hidden;">
    
    <div style="background: linear-gradient(to right, #4caf50, #8bc34a); padding: 30px; text-align: center; color: #ffffff;">
      <h1 style="margin: 0; font-weight: 600;">Welcome to Learnova!</h1>
      <p style="margin: 10px 0 0; font-size: 14px;">Your learning journey starts now.</p>
    </div>
    
    <div style="padding: 40px;">
      <h2 style="margin-top: 0; color: #4CAF50; font-weight: 500;">Hello, $fullname!</h2>
      <p style="font-size: 16px; line-height: 1.6;">Thank you for joining our community. We are excited to have you on board and help you with your learning journey. You can now access our courses, including Web Development Fundamentals, Data Science for Beginners, and many more. Log in to your dashboard to get started.</p>
      
      <p style="text-align: center; margin-top: 30px;">
        <a href="https://yourlearningplatform.com/dashboard" style="background-color: #4CAF50; color: #ffffff; text-decoration: none; padding: 12px 25px; border-radius: 5px; font-weight: bold; display: inline-block;">
          Go to Your Dashboard
        </a>
      </p>
    </div>
    
    <div style="background-color: #e8f5e9; padding: 20px; text-align: center; font-size: 12px; color: #666666; border-top: 1px solid #dcdcdc;">
      <p style="margin: 0;">&copy; 2025 Learnova. All rights reserved.</p>
      <p style="margin: 5px 0 0;">This email was sent to $email because you signed up on Learnova.</p>
    </div>
  </div>
</div>
EOT;

            $mail->send();
        } catch (Exception $e) {
            // Log the error for debugging purposes
            error_log("Message could not be sent. Mailer Error: {$mail->ErrorInfo}");
        }

        // --- End of new code to send welcome email ---

        // Redirect to the dashboard
        header("Location: dashboard.php");
        exit();

    } catch(PDOException $e) {
        $_SESSION['error_message'] = "Database error: " . $e->getMessage();
        header("Location: signup.php");
        exit();
    }
} else {
    // If the form was not submitted, redirect to the signup page
    header("Location: signup.php");
    exit();
}