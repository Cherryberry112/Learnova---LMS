<?php
// dashboard.php
require_once 'session_check.php';
validateSession();

// Include the database connection file
require_once 'dbconnection.php';

// Retrieve user data from the session
$userId = $_SESSION['user_id'];
$fullname = $_SESSION['fullname'];
$role = $_SESSION['role'];
$profileImage = $_SESSION['profile_image_url'] ?? 'https://placehold.co/100x100/A0E7A0/000000?text=User';

$content = '';
$pageTitle = 'Dashboard - Mycourses';
$successMessage = isset($_GET['status']) && $_GET['status'] === 'success' ? 'Profile updated successfully!' : (isset($_GET['course_status']) && $_GET['course_status'] === 'success' ? 'Course created successfully!' : '');

try {
    // Determine content based on user role
    switch ($role) {
        case 'student':
            // Fetch enrolled courses for the logged-in student
            $stmt = $conn->prepare("SELECT e.progress_percentage, c.id, c.name, c.summary, c.thumbnail FROM enrollments e JOIN courses c ON e.course_id = c.id WHERE e.user_id = ?");
            $stmt->execute([$userId]);
            $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

            ob_start(); // Start output buffering
            if (!empty($courses)) {
                echo '<div class="my-courses-grid">';
                foreach ($courses as $course) {
                    echo '<a href="course/course.php?id=' . htmlspecialchars($course['id']) . '" class="course-card-link">';
                    echo '<div class="course-card">';
                    echo '<img src="' . htmlspecialchars($course['thumbnail']) . '" alt="' . htmlspecialchars($course['name']) . ' Thumbnail">';
                    echo '<div class="card-content">';
                    echo '<h3>' . htmlspecialchars($course['name']) . '</h3>';
                    echo '<p>' . htmlspecialchars($course['summary']) . '</p>';
                    echo '<div class="progress-container">';
                    echo '<div class="progress-bar" style="width: ' . htmlspecialchars($course['progress_percentage']) . '%;"></div>';
                    echo '<span class="progress-text">' . htmlspecialchars($course['progress_percentage']) . '%</span>';
                    echo '</div>';
                    echo '</div>';
                    echo '</div>';
                    echo '</a>';
                }
                echo '</div>';
            } else {
                echo '<p>You are not currently enrolled in any courses. Check out to get started!</p>';
                echo '<a href="course/all_courses.php" class="btn btn-create-course">All courses</a>';
            }
            $content = ob_get_clean(); // Get the buffered output
            break;

        case 'instructor':
            // Fetch courses taught by the logged-in instructor
            $stmt = $conn->prepare("SELECT c.id, c.name, c.summary, c.thumbnail FROM enrollments e JOIN courses c ON e.course_id = c.id WHERE e.user_id = ?");
            $stmt->execute([$userId]);
            $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

            ob_start();
            echo '<div class="instructor-actions">';
            
            echo '<a href="create_course.php" class="btn btn-create-course">Create New Course</a>';
            echo '</div>';
            if (!empty($courses)) {
                echo '<div class="my-courses-grid">';
                foreach ($courses as $course) {
                    echo '<a href="course/course.php?id=' . htmlspecialchars($course['id']) . '" class="course-card-link">';
                    echo '<div class="course-card">';
                    echo '<img src="' . htmlspecialchars($course['thumbnail']) . '" alt="' . htmlspecialchars($course['name']) . ' Thumbnail">';
                    echo '<div class="card-content">';
                    echo '<h3>' . htmlspecialchars($course['name']) . '</h3>';
                    echo '<p>' . htmlspecialchars($course['summary']) . '</p>';
                    echo '</div>';
                    echo '</div>';
                    echo '</a>';
                }
                echo '</div>';
            } else {
                echo '<p>You have not created any courses yet.</p>';
            }
            $content = ob_get_clean();
            $pageTitle = 'Dashboard - Instructor';
            break;

        case 'admin':
            // Fetch all users with optional sorting by role
            $sortRole = $_GET['sort_role'] ?? 'all';
            $sqlUsers = "SELECT id, fullname, email, role FROM users";
            if ($sortRole !== 'all') {
                $sqlUsers .= " WHERE role = ?";
                $stmtUsers = $conn->prepare($sqlUsers);
                $stmtUsers->execute([$sortRole]);
            } else {
                $stmtUsers = $conn->query($sqlUsers);
            }
            $users = $stmtUsers->fetchAll(PDO::FETCH_ASSOC);

            // Fetch data for the enrollment graph
            $stmtGraph = $conn->query("SELECT c.name, COUNT(e.user_id) as student_count FROM courses c LEFT JOIN enrollments e ON c.id = e.course_id GROUP BY c.id ORDER BY student_count DESC");
            $graphData = $stmtGraph->fetchAll(PDO::FETCH_ASSOC);
            $courseLabels = json_encode(array_column($graphData, 'name'));
            $studentCounts = json_encode(array_column($graphData, 'student_count'));

            ob_start();
            echo '<h2>Admin Dashboard</h2>';
            echo '<div class="admin-stats">';
            echo '<h3>Enrollment Statistics</h3>';
            echo '<canvas id="enrollmentChart"></canvas>';
            echo '</div>';
            echo '<div class="user-list-header">';
            echo '<h3>All Users</h3>';
            echo '<div class="sort-options">';
            echo '<label for="sortRole">Sort by Role:</label>';
            echo '<select id="sortRole" onchange="window.location.href=\'dashboard.php?sort_role=\' + this.value">';
            echo '<option value="all" ' . ($sortRole === 'all' ? 'selected' : '') . '>All</option>';
            echo '<option value="student" ' . ($sortRole === 'student' ? 'selected' : '') . '>Students</option>';
            echo '<option value="instructor" ' . ($sortRole === 'instructor' ? 'selected' : '') . '>Instructors</option>';
            echo '<option value="admin" ' . ($sortRole === 'admin' ? 'selected' : '') . '>Admins</option>';
            echo '</select>';
            echo '</div>';
            echo '</div>';
            echo '<table class="user-table">';
            echo '<thead><tr><th>Full Name</th><th>Email</th><th>Role</th></tr></thead>';
            echo '<tbody>';
            foreach ($users as $user) {
                echo '<tr>';
                echo '<td>' . htmlspecialchars($user['fullname']) . '</td>';
                echo '<td>' . htmlspecialchars($user['email']) . '</td>';
                echo '<td>' . htmlspecialchars(ucfirst($user['role'])) . '</td>';
                echo '</tr>';
            }
            echo '</tbody>';
            echo '</table>';
            $content = ob_get_clean();
            $pageTitle = 'Dashboard - Admin';
            break;

        default:
            $content = '<p>Your role is not recognized. Please contact support.</p>';
            break;
    }
} catch (PDOException $e) {
    $content = "<p>Database error: " . $e->getMessage() . "</p>";
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $pageTitle; ?></title>
    <link rel="stylesheet" href="style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <?php if ($role === 'admin'): ?>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <?php endif; ?>
    <style>
        body {
            background-color: var(--gray-light);
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }

        .dashboard-wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: #e6f2e6;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            border-radius: 0 15px 15px 0;
        }

        .sidebar .sidebar-logo {
            text-decoration: none;
            color: var(--green-dark);
            font-size: 1.8rem;
            font-weight: 700;
            display: block;
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar .user-info {
            text-align: center;
            margin-bottom: 40px;
        }

        .sidebar .profile-image-container {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            overflow: hidden;
            background-color: #d1e7d1;
            margin: 0 auto 10px;
        }

        .sidebar .profile-image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .sidebar .user-info h4 {
            font-size: 1.2rem;
            color: #333;
            margin: 0;
        }

        .sidebar nav ul {
            list-style: none;
            padding: 0;
        }

        .sidebar nav ul li {
            margin-bottom: 20px;
        }

        .sidebar nav ul li a {
            text-decoration: none;
            color: #555;
            font-size: 1.1rem;
            display: block;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .sidebar nav ul li a:hover {
            background-color: #d1e7d1;
        }

        .main-content {
            flex-grow: 1;
            padding: 40px;
        }

        .header-title {
            text-align: center;
            font-size: 2.5rem;
            color: #006400;
            margin-bottom: 50px;
        }
        
        
        .course-card-link {
            text-decoration: none;
            color: inherit;
        }

                /* Update the course card style directly */
        .course-card {
            background-color: #f9f9f9;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            /* Add these two new lines to your existing .course-card CSS */
            max-width: 500px; 
            margin: 0 auto;
        }

        /* You can remove the .my-courses-grid block from your CSS */
        .my-courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }
        
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .course-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
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
            margin-bottom: 15px;
        }

        /* Progress Bar Styling */
        .progress-container {
            background-color: #e0e0e0;
            border-radius: 15px;
            height: 20px;
            overflow: hidden;
            position: relative;
            margin-top: 10px;
        }
        
        .progress-bar {
            background-color: #3d9547ff;
            height: 100%;
            text-align: right;
            line-height: 20px;
            color: white;
            font-size: 0.8rem;
            padding-right: 10px;
            transition: width 0.4s ease;
        }
        
        .progress-text {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            color: #fff;
            font-weight: 600;
        }
        
        /* Admin-specific styles */
        .admin-stats {
            background-color: #f0f8ff;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .user-list-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .user-table th, .user-table td {
            border: 1px solid #8bd16bff;
            padding: 12px;
            text-align: left;
        }
        
        .user-table th {
            background-color: #f2f2f2;
            font-weight: 600;
        }
        
        /* Success message style */
        .message.success {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            transition: opacity 0.5s ease;
        }

        /* Instructor-specific styles */
        .instructor-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .btn-create-course {
            background-color: var(--green-dark);
            color: var(--white);
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn-create-course:hover {
            background-color: #126b3a;
        }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <aside class="sidebar">
            <a href="index.php" class="sidebar-logo">Learnova</a>
            <div class="user-info">
                <div class="profile-image-container">
                    <img src="<?php echo htmlspecialchars($profileImage); ?>" alt="Profile Image">
                </div>
                <h4>Hi, <?php echo htmlspecialchars($fullname); ?>!</h4>
                <p>Role: <?php echo htmlspecialchars(ucfirst($role)); ?></p>
            </div>
            <nav>
                <ul>
                    <li><a href="update_profile.php">Update profile</a></li>
                    <li><a href="course/all_courses.php">Courses</a></li>
                    <li><a href="logout.php">Logout</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <h1 class="header-title">
                <?php
                if ($role === 'student') {
                    echo 'My Courses';
                } elseif ($role === 'instructor') {
                    echo 'My Courses as Instructor';
                } elseif ($role === 'admin') {
                    echo 'Admin Dashboard';
                }
                ?>
            </h1>
            <section class="dashboard-section">
                <?php if (!empty($successMessage)): ?>
                    <div id="successMessage" class="message success"><?php echo htmlspecialchars($successMessage); ?></div>
                <?php endif; ?>
                <?php echo $content; ?>
            </section>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            const successMessage = document.getElementById('successMessage');
            if (successMessage) {
                setTimeout(() => {
                    successMessage.style.opacity = '0';
                    setTimeout(() => {
                        successMessage.remove();
                    }, 500); // Wait for the transition to finish before removing from DOM
                }, 3000); // Message will be visible for 3 seconds
            }

            <?php if ($role === 'admin'): ?>
            // Chart.js for Admin Dashboard
            const ctx = document.getElementById('enrollmentChart').getContext('2d');
            const gradient = ctx.createLinearGradient(0, 0, 0, 400);
            gradient.addColorStop(0, 'rgba(22, 138, 72, 0.8)'); // Green-dark
            gradient.addColorStop(1, 'rgba(198, 244, 210, 0.8)'); // Green-light

            const enrollmentChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: <?php echo $courseLabels; ?>,
                    datasets: [{
                        label: 'Number of Students',
                        data: <?php echo $studentCounts; ?>,
                        backgroundColor: gradient,
                        borderColor: '#168A48',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Number of Students'
                            },
                            ticks: {
                                precision: 0
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Courses'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
            <?php endif; ?>
        });
    
    </script>
</body>
</html>