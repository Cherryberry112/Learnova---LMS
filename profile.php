<?php
// profile.php
require_once 'session_check.php';
validateSession();

require_once 'dbconnection.php';
require_once 'header.php';

$userId = $_SESSION['user_id'];
$message = '';

// Handle form submission for updating profile
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $fullname = trim($_POST['fullname']);
    $email = trim($_POST['email']);
    $password = $_POST['password'];

    try {
        // Build the update query based on provided fields
        $sql = "UPDATE users SET fullname = ?, email = ? WHERE id = ?";
        $params = [$fullname, $email, $userId];

        // Check if password is provided and update it
        if (!empty($password)) {
            $password_hash = password_hash($password, PASSWORD_DEFAULT);
            $sql = "UPDATE users SET fullname = ?, email = ?, password_hash = ? WHERE id = ?";
            $params = [$fullname, $email, $password_hash, $userId];
        }

        $stmt = $conn->prepare($sql);
        $stmt->execute($params);

        // Update session variables
        $_SESSION['username'] = $fullname;
        $message = "Profile updated successfully!";

    } catch (PDOException $e) {
        $message = "Error updating profile: " . $e->getMessage();
    }
}

// Fetch current user data to pre-fill the form
try {
    $stmt = $conn->prepare("SELECT fullname, email, profile_image_url FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    echo "Error fetching user data: " . $e->getMessage();
    $user = false;
}

?>
<main>
    <section class="profile-section">
        <div class="container">
            <h2>Update Profile</h2>
            <?php if ($message): ?>
                <p><?php echo $message; ?></p>
            <?php endif; ?>
            <form action="profile.php" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="fullname">Full Name:</label>
                    <input type="text" id="fullname" name="fullname" value="<?php echo htmlspecialchars($user['fullname']); ?>" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" required>
                </div>
                <div class="form-group">
                    <label for="password">Change Password:</label>
                    <input type="password" id="password" name="password" placeholder="Leave blank to keep current password">
                </div>
                <button type="submit" class="btn">Update Profile</button>
            </form>
        </div>
    </section>
</main>
<?php
require_once 'footer.php';
?>