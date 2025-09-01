<?php
// password_generator.php
// A simple script to generate a new password hash.
// Run this file once in your browser to get a new, valid hash.

$password = "1234";
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

echo "The new password hash for '1234' is: <br><br>";
echo "<strong>" . htmlspecialchars($hashed_password) . "</strong>";

?>