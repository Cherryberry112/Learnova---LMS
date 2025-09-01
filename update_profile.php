<?php
// update_profile.php
require_once 'session_check.php';
validateSession();

// Include the database connection file
require_once 'dbconnection.php';

// Get current user data from the database
$userId = $_SESSION['user_id'];
$errorMessage = '';

try {
    $stmt = $conn->prepare("SELECT fullname, email FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        $errorMessage = "User not found.";
    }

} catch (PDOException $e) {
    $errorMessage = "Database error: " . $e->getMessage();
}

// Handle form submission for profile update
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sanitize user inputs
    $newFullname = trim($_POST['fullname'] ?? '');
    $newEmail = trim($_POST['email'] ?? '');
    $currentPassword = $_POST['current_password'] ?? '';
    $newPassword = $_POST['new_password'] ?? '';
    $confirmPassword = $_POST['confirm_password'] ?? '';
    
    // Server-side validation
    if (empty($newFullname) || empty($newEmail)) {
        $errorMessage = "Full Name and Email are required.";
    } elseif (!filter_var($newEmail, FILTER_VALIDATE_EMAIL)) {
        $errorMessage = "Invalid email format.";
    } else {
        // Check if the new email is already in use by another user
        $stmtCheckEmail = $conn->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
        $stmtCheckEmail->execute([$newEmail, $userId]);
        if ($stmtCheckEmail->fetch()) {
            $errorMessage = "This email is already taken. Please use a different one.";
        } else {
            // Check for password update
            $passwordUpdate = false;
            if (!empty($newPassword) || !empty($currentPassword)) {
                if (empty($currentPassword)) {
                    $errorMessage = "Please enter your current password to change it.";
                } elseif ($newPassword !== $confirmPassword) {
                    $errorMessage = "New password and confirm password do not match.";
                } elseif (strlen($newPassword) < 6) {
                    $errorMessage = "Password must be at least 6 characters long.";
                } else {
                    // Verify current password
                    $stmtPassCheck = $conn->prepare("SELECT password_hash FROM users WHERE id = ?");
                    $stmtPassCheck->execute([$userId]);
                    $userPass = $stmtPassCheck->fetch(PDO::FETCH_ASSOC);

                    if ($userPass && password_verify($currentPassword, $userPass['password_hash'])) {
                        $passwordUpdate = true;
                        $hashedNewPassword = password_hash($newPassword, PASSWORD_DEFAULT);
                    } else {
                        $errorMessage = "Incorrect current password.";
                    }
                }
            }

            // If there are no errors, proceed with the update
            if (empty($errorMessage)) {
                $sql = "UPDATE users SET fullname = ?, email = ?";
                $params = [$newFullname, $newEmail];

                if ($passwordUpdate) {
                    $sql .= ", password_hash = ?";
                    $params[] = $hashedNewPassword;
                }
                
                $sql .= " WHERE id = ?";
                $params[] = $userId;

                $stmtUpdate = $conn->prepare($sql);

                if ($stmtUpdate->execute($params)) {
                    // Update session variables
                    $_SESSION['fullname'] = $newFullname;
                    
                    // Redirect back to dashboard with a success message
                    header("Location: dashboard.php?status=success");
                    exit();
                } else {
                    $errorMessage = "Failed to update profile. Please try again.";
                }
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <link rel="stylesheet" href="style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: var(--gray-light);
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .update-form-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        .update-form-container h1 {
            text-align: center;
            color: var(--green-dark);
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #4169e1;
        }

        .form-group input[type="password"] {
            margin-top: 5px;
        }
        
        .form-group .password-note {
            font-size: 0.8rem;
            color: #888;
            margin-top: 5px;
        }

        .form-group .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-update {
            background-color: var(--green-dark);
            color: #fff;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        .btn-update:hover {
            background-color: #126b3a;
        }

        .btn-back {
            color: var(--green-dark);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .btn-back:hover {
            color: #126b3a;
        }

        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }

        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="update-form-container">
        <h1>Update Profile</h1>
        
        <?php if (!empty($errorMessage)): ?>
            <div class="message error"><?php echo htmlspecialchars($errorMessage); ?></div>
        <?php endif; ?>

        <?php if ($user): ?>
        <form action="update_profile.php" method="post">
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="fullname" value="<?php echo htmlspecialchars($user['fullname']); ?>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" required>
            </div>
            <hr style="margin: 30px 0; border: 0; border-top: 1px solid #eee;">
            <div class="form-group">
                <p class="password-note">Leave password fields blank if you don't want to change it.</p>
                <label for="current_password">Current Password</label>
                <input type="password" id="current_password" name="current_password">
            </div>
            <div class="form-group">
                <label for="new_password">New Password</label>
                <input type="password" id="new_password" name="new_password">
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm New Password</label>
                <input type="password" id="confirm_password" name="confirm_password">
            </div>
            <div class="form-group form-actions">
                <a href="dashboard.php" class="btn-back">Cancel</a>
                <button type="submit" class="btn-update">Update Profile</button>
            </div>
        </form>
        <?php endif; ?>
    </div>
</body>
</html>