<?php
// all_courses.php
// This page lists all available courses on the platform, fetching data from the database.
session_start();

// Include the database connection and header files
require_once '../dbconnection.php';
$pathPrefix = '../';
require_once '../header.php';

$isLoggedIn = isset($_SESSION['user_id']);
$userId = $isLoggedIn ? $_SESSION['user_id'] : null;

// Prepare and execute the query to get all courses
try {
    $stmt = $conn->prepare("SELECT id, name, summary, thumbnail FROM courses ORDER BY created_at DESC");
    $stmt->execute();
    $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch(PDOException $e) {
    echo "<p>Error fetching courses: " . $e->getMessage() . "</p>";
    $courses = []; // Fallback to an empty array
}

?>

<style>
/* All Courses Page Grid Layout */
.all-courses-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
    margin-top: 30px;
}

/* Make sure the grid is responsive on smaller screens */
@media (max-width: 992px) {
    .all-courses-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 576px) {
    .all-courses-grid {
        grid-template-columns: 1fr;
    }
}
.course-card-link {
    /* Ensures the card itself is the clickable area, not just the text */
    text-decoration: none;
    color: inherit; /* Inherit color from the parent */
    display: block;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.course-card-link:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.course-card {
    background-color: #fff;
    height: 100%;
}

.course-card img {
    width: 100%;
    height: auto;
    display: block;
}

.card-content {
    padding: 20px;
}

.card-content h3 {
    font-size: 1.3rem;
    font-weight: 600;
    color: var(--green-dark);
    margin-bottom: 10px;
}

.card-content p {
    font-size: 0.9rem;
    color: #6c757d;
}

</style>
<section class="all-courses-section">
    <div class="container">
        <h2 class="section-title">All Courses</h2>
        <div class="all-courses-grid">
            <?php if (!empty($courses)): ?>
                <?php foreach ($courses as $course): ?>
                    <?php
                        // Determine the correct link for the course card
                        $isEnrolled = false;
                        if ($isLoggedIn) {
                            $stmt = $conn->prepare("SELECT COUNT(*) FROM enrollments WHERE user_id = ? AND course_id = ?");
                            $stmt->execute([$userId, $course['id']]);
                            $isEnrolled = $stmt->fetchColumn() > 0;
                        }
                        
                        $linkUrl = $isEnrolled ? "course.php?id=" . urlencode($course['id']) : "course_page.php?id=" . urlencode($course['id']);
                    ?>
                    <a href="<?php echo htmlspecialchars($linkUrl); ?>" class="course-card-link">
                        <div class="course-card">
                            <img src="<?php echo htmlspecialchars($course['thumbnail']); ?>" alt="<?php echo htmlspecialchars($course['name']); ?> Course Image">
                            <div class="card-content">
                                <h3><?php echo htmlspecialchars($course['name']); ?></h3>
                                <p><?php echo htmlspecialchars($course['summary']); ?></p>
                            </div>
                        </div>
                    </a>
                <?php endforeach; ?>
            <?php else: ?>
                <p>No courses are currently available. Please check back later!</p>
            <?php endif; ?>
        </div>
    </div>
</section>

<?php
// Include the footer file, which contains the closing HTML tags.
require_once '../footer.php';
?>