
<?php
function validateSession() {
    session_start();
    
    header("Cache-Control: no-cache, no-store, must-revalidate, private");
    header("Pragma: no-cache");
    header("Expires: 0");
    
    if (!isset($_SESSION['user_id']) || empty($_SESSION['user_id']) || 
        !isset($_SESSION['fullname']) || !isset($_SESSION['role'])) {
        session_unset();
        session_destroy();
        header("Location: index.php");
        exit();
    }
}
?>