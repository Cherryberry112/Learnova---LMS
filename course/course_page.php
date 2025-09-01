<?php
// course_page.php
// This is the single dynamic page that displays details for a specific course, fetching data from the database.
session_start();

// Include the database connection and header files
require_once '../dbconnection.php';
$pathPrefix = '../';
require_once '../header.php';

// Get the course ID from the URL
$courseId = isset($_GET['id']) ? htmlspecialchars($_GET['id']) : null;
$isLoggedIn = isset($_SESSION['user_id']);
$userId = $isLoggedIn ? $_SESSION['user_id'] : null;
$message = isset($_SESSION['enroll_message']) ? $_SESSION['enroll_message'] : null;
unset($_SESSION['enroll_message']); // Clear the message after displaying it

// Function to fetch a single course and its modules from the database
function getCourseDetails($conn, $courseId, $userId) {
    if (!$courseId) {
        return null;
    }

    try {
        // Fetch course details
        $stmt = $conn->prepare("SELECT id, name, title, summary, thumbnail FROM courses WHERE id = ?");
        $stmt->execute([$courseId]);
        $course = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($course) {
            // Check if the current user is already enrolled
            $stmt = $conn->prepare("SELECT COUNT(*) FROM enrollments WHERE user_id = ? AND course_id = ?");
            $stmt->execute([$userId, $courseId]);
            $course['isEnrolled'] = $stmt->fetchColumn() > 0;

            // Fetch modules for the course
            $stmt = $conn->prepare("SELECT module_name FROM modules WHERE course_id = ? ORDER BY module_order ASC");
            $stmt->execute([$courseId]);
            $modules = $stmt->fetchAll(PDO::FETCH_COLUMN);
            $course['modules'] = $modules;

            $course['instructions'] = [
                'Watch the video lectures in order.',
                'Complete all quizzes for each module.',
                'Submit your final project for review.',
                'Use the forum to ask questions and interact with other students.'
            ];
        }

        return $course;

    } catch(PDOException $e) {
        error_log("Database Error: " . $e->getMessage());
        return null;
    }
}

$course = getCourseDetails($conn, $courseId, $userId);

?>
<style>
/* CSS fix to remove the black border from the button when a user is logged in */
.btn-cta {
    border: none !important;
}
</style>

<main>
    <section class="course-details-section">
        <div class="container">
            <?php if ($course): ?>
                <?php if ($message): ?>
                    <div class="alert alert-info"><?php echo htmlspecialchars($message); ?></div>
                <?php endif; ?>
                <div class="course-header">
                    <img src="<?php echo htmlspecialchars($course['thumbnail']); ?>" alt="<?php echo htmlspecialchars($course['name']); ?> Thumbnail" class="course-thumbnail">
                    <div class="course-info">
                        <h1 id="course-main-title"><?php echo htmlspecialchars($course['name']); ?></h1>
                        <p id="course-summary"><?php echo htmlspecialchars($course['summary']); ?></p>
                        <?php if ($course['isEnrolled']): ?>
                            <a href="<?php echo $pathPrefix; ?>course/course.php?id=<?php echo htmlspecialchars($course['id']); ?>" class="btn btn-enrolled">Already Enrolled</a>
                        <?php else: ?>
                            <?php if ($isLoggedIn): ?>
                                <form action="enroll_process.php" method="POST">
                                    <input type="hidden" name="course_id" value="<?php echo htmlspecialchars($course['id']); ?>">
                                    <button type="submit" class="btn btn-cta">Enroll Now</button>
                                </form>
                            <?php else: ?>
                                <a href="<?php echo $pathPrefix; ?>login.php" class="btn btn-cta">Enroll Now</a>
                            <?php endif; ?>
                        <?php endif; ?>
                    </div>
                </div>

                <div class="course-sections-grid">
                    <div class="course-timeline">
                        <h2 class="section-title">Course Timeline</h2>
                        <ul id="course-timeline-list">
                            <?php foreach ($course['modules'] as $moduleName): ?>
                                <li><?php echo htmlspecialchars($moduleName); ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                    <div class="course-instructions">
                        <h2 class="section-title">Instructions</h2>
                        <ul id="course-instructions-list">
                            <?php foreach ($course['instructions'] as $instruction): ?>
                                <li><?php echo htmlspecialchars($instruction); ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                </div>
            <?php else: ?>
                <div class="course-header">
                    <div class="course-info">
                        <h1 id="course-main-title">Course Not Found</h1>
                        <p>The course you are looking for does not exist.</p>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </section>
</main>

<?php
// Include the footer file, which contains the closing HTML tags.
require_once '../footer.php';
?>