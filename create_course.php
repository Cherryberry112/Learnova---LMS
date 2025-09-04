<?php
// create_course.php
require_once 'session_check.php';
validateSession();

require_once 'dbconnection.php';

$errorMessage = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sanitize and validate course data
    $courseName = trim($_POST['course_name'] ?? '');
    $courseTitle = trim($_POST['course_title'] ?? '');
    $courseSummary = trim($_POST['course_summary'] ?? '');
    $courseThumbnail = trim($_POST['course_thumbnail'] ?? '');
    
    // Generate a simple URL-friendly ID
    $courseId = strtolower(str_replace(' ', '', $courseName));
    
    // Modules and Quizzes data from form
    $modules = $_POST['modules'] ?? [];

    if (empty($courseName) || empty($courseTitle) || empty($courseSummary)) {
        $errorMessage = "Course Name, Title, and Summary are required.";
    } else {
        // Assume user is logged in and their ID is in the session
        $userId = $_SESSION['user_id'] ?? null;
        if (!$userId) {
            $errorMessage = "User not logged in. Please log in to create a course.";
        } else {
            try {
                // Check if course ID already exists
                $stmtCheck = $conn->prepare("SELECT COUNT(*) FROM courses WHERE id = ?");
                $stmtCheck->execute([$courseId]);
                if ($stmtCheck->fetchColumn() > 0) {
                    $errorMessage = "A course with this name already exists. Please choose a different name.";
                } else {
                    // Begin a transaction
                    $conn->beginTransaction();

                    // 1. Insert into courses table
                    $stmtCourse = $conn->prepare("INSERT INTO courses (id, name, title, summary, thumbnail) VALUES (?, ?, ?, ?, ?)");
                    $stmtCourse->execute([$courseId, $courseName, $courseTitle, $courseSummary, $courseThumbnail]);
                    
                    // 2. Insert into modules and quizzes tables
                    $moduleOrder = 1;
                    foreach ($modules as $module) {
                        $moduleName = trim($module['module_name'] ?? '');
                        $quizzes = $module['quizzes'] ?? [];

                        if (!empty($moduleName)) { 
                            $stmtModule = $conn->prepare("INSERT INTO modules (course_id, module_name, module_order) VALUES (?, ?, ?)");
                            $stmtModule->execute([$courseId, $moduleName, $moduleOrder]);
                            $moduleId = $conn->lastInsertId();

                            // Insert quizzes for the current module
                            foreach ($quizzes as $quiz) {
                                $question = trim($quiz['question'] ?? '');
                                $correctAnswer = trim($quiz['correct_answer'] ?? '');
                                $options = array_map('trim', explode(',', $quiz['options'] ?? ''));
                                
                                if (!empty($question) && !empty($correctAnswer) && !empty($options)) {
                                    // Add correct answer to options if not present
                                    if (!in_array($correctAnswer, $options)) {
                                        $options[] = $correctAnswer;
                                    }
                                    shuffle($options); // Shuffle options
                                    $optionsJson = json_encode($options);

                                    $stmtQuiz = $conn->prepare("INSERT INTO quizzes (module_id, question, correct_answer, options) VALUES (?, ?, ?, ?)");
                                    $stmtQuiz->execute([$moduleId, $question, $correctAnswer, $optionsJson]);
                                }
                            }
                        }
                        $moduleOrder++;
                    }

                    // 3. Insert into enrollments table for the user
                    $stmtEnrollment = $conn->prepare("INSERT INTO enrollments (user_id, course_id) VALUES (?, ?)");
                    $stmtEnrollment->execute([$userId, $courseId]);

                    // Commit the transaction
                    $conn->commit();
                    
                    // Redirect on success
                    header("Location: dashboard.php?course_status=success");
                    exit();
                }
            } catch (PDOException $e) {
                $conn->rollBack();
                $errorMessage = "Database error: " . $e->getMessage();
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
    <title>Create a New Course</title>
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
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
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

        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus, .form-group textarea:focus, .form-group select:focus {
            outline: none;
            border-color: #4169e1;
        }

        .module-section, .quiz-section {
            border: 1px solid #eee;
            padding: 20px;
            margin-top: 20px;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        .module-section h3, .quiz-section h4 {
            margin-top: 0;
            margin-bottom: 15px;
            color: #444;
        }

        .module-buttons, .quiz-buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 15px;
        }

        .btn-add-module, .btn-add-quiz {
            background-color: #4169e1;
            color: #fff;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s;
        }

        .btn-add-module:hover, .btn-add-quiz:hover {
            background-color: #3158c9;
        }

        .btn-remove {
            background-color: #dc3545;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 0.8rem;
            margin-left: 10px;
            transition: background-color 0.3s;
        }
        
        .btn-remove:hover {
            background-color: #c82333;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
        }

        .btn-submit {
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

        .btn-submit:hover {
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
    <div class="container">
        <h1>Create a New Course</h1>
        
        <?php if (!empty($errorMessage)): ?>
            <div class="message error"><?php echo htmlspecialchars($errorMessage); ?></div>
        <?php endif; ?>

        <form action="create_course.php" method="post">
            <div class="form-group">
                <label for="course_name">Course Name</label>
                <input type="text" id="course_name" name="course_name" required>
            </div>
            <div class="form-group">
                <label for="course_title">Course Title</label>
                <input type="text" id="course_title" name="course_title" required>
            </div>
            <div class="form-group">
                <label for="course_summary">Course Summary</label>
                <textarea id="course_summary" name="course_summary" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="course_thumbnail">Thumbnail URL</label>
                <input type="url" id="course_thumbnail" name="course_thumbnail" placeholder="https://example.com/image.jpg">
            </div>

            <hr style="margin: 30px 0; border: 0; border-top: 1px solid #eee;">

            <h2>Course Modules</h2>
            <div id="modules-container">
                </div>
            <div style="text-align: right; margin-top: 20px;">
                <button type="button" class="btn-add-module">Add Module</button>
            </div>

            <div class="form-actions">
                <a href="dashboard.php" class="btn-back">Back to Dashboard</a>
                <button type="submit" class="btn-submit">Create Course</button>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const modulesContainer = document.getElementById('modules-container');
            const addModuleBtn = document.querySelector('.btn-add-module');
            let moduleCount = 0;

            const addQuiz = (moduleIndex, quizIndex) => {
                const quizSection = document.getElementById(`quizzes-container-${moduleIndex}`);
                const quizHtml = `
                    <div class="quiz-section" data-quiz-index="${quizIndex}">
                        <h4>Quiz Question ${quizIndex + 1}</h4>
                        <div class="form-group">
                            <label>Question</label>
                            <input type="text" name="modules[${moduleIndex}][quizzes][${quizIndex}][question]" required>
                        </div>
                        <div class="form-group">
                            <label>Correct Answer</label>
                            <input type="text" name="modules[${moduleIndex}][quizzes][${quizIndex}][correct_answer]" required>
                        </div>
                        <div class="form-group">
                            <label>Options (comma-separated)</label>
                            <input type="text" name="modules[${moduleIndex}][quizzes][${quizIndex}][options]" placeholder="Option A, Option B, Option C, Option D" required>
                        </div>
                        <button type="button" class="btn-remove btn-remove-quiz">Remove Quiz</button>
                    </div>
                `;
                quizSection.insertAdjacentHTML('beforeend', quizHtml);
            };

            const addModule = () => {
                const moduleIndex = moduleCount++;
                const moduleHtml = `
                    <div class="module-section" data-module-index="${moduleIndex}">
                        <h3>Module ${moduleIndex + 1}</h3>
                        <div class="form-group">
                            <label>Module Name</label>
                            <input type="text" name="modules[${moduleIndex}][module_name]" required>
                        </div>
                        
                        <h4>Quizzes</h4>
                        <div id="quizzes-container-${moduleIndex}">
                            </div>
                        <div style="text-align: right; margin-top: 10px;">
                            <button type="button" class="btn-add-quiz">Add Quiz</button>
                        </div>
                        <div style="text-align: right; margin-top: 15px;">
                            <button type="button" class="btn-remove btn-remove-module">Remove Module</button>
                        </div>
                    </div>
                `;
                modulesContainer.insertAdjacentHTML('beforeend', moduleHtml);
            };

            // Add initial module
            addModule();

            // Event listener for adding modules
            addModuleBtn.addEventListener('click', addModule);

            // Event listener for removing modules and adding/removing quizzes
            modulesContainer.addEventListener('click', (e) => {
                if (e.target.classList.contains('btn-remove-module')) {
                    e.target.closest('.module-section').remove();
                }

                if (e.target.classList.contains('btn-add-quiz')) {
                    const moduleSection = e.target.closest('.module-section');
                    const moduleIndex = moduleSection.dataset.moduleIndex;
                    const quizzesContainer = document.getElementById(`quizzes-container-${moduleIndex}`);
                    const quizCount = quizzesContainer.querySelectorAll('.quiz-section').length;
                    addQuiz(moduleIndex, quizCount);
                }

                if (e.target.classList.contains('btn-remove-quiz')) {
                    e.target.closest('.quiz-section').remove();
                }
            });
        });
    </script>
</body>
</html>
