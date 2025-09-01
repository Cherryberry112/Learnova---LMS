<?php
// course/enroll_process.php
require_once '../session_check.php'; // For course/course.php
validateSession();
require_once '../dbconnection.php';

// Check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    $_SESSION['enroll_message'] = "You must be logged in to enroll in a course.";
    header("Location: ../login.php");
    exit();
}

// Get user ID and course ID from the form submission
$userId = $_SESSION['user_id'];
$courseId = isset($_POST['course_id']) ? htmlspecialchars($_POST['course_id']) : null;

if (!$courseId) {
    $_SESSION['enroll_message'] = "Invalid course. Please try again.";
    header("Location: all_courses.php");
    exit();
}

try {
    // Check if the user is already enrolled
    $stmt = $conn->prepare("SELECT COUNT(*) FROM enrollments WHERE user_id = ? AND course_id = ?");
    $stmt->execute([$userId, $courseId]);
    $isEnrolled = $stmt->fetchColumn() > 0;

    if ($isEnrolled) {
        $_SESSION['enroll_message'] = "You are already enrolled in this course!";
    } else {
        // Insert a new enrollment record with 0 progress
        $stmt = $conn->prepare("INSERT INTO enrollments (user_id, course_id, progress_percentage) VALUES (?, ?, 0)");
        $stmt->execute([$userId, $courseId]);

        $_SESSION['enroll_message'] = "You have successfully enrolled in the course!";
    }
    
    // REDIRECT TO THE USER'S PERSONAL COURSE DASHBOARD
    header("Location: course.php?id=" . $courseId);
    exit();

} catch(PDOException $e) {
    $_SESSION['enroll_message'] = "Database error: " . $e->getMessage();
    header("Location: course_page.php?id=" . $courseId);
    exit();
}
?>