<?php
// submit_quiz.php
// Dedicated AJAX handler for quiz submissions
require_once '../session_check.php'; // For course/course.php
validateSession();

// Enable error reporting for debugging (remove in production)
error_reporting(E_ALL);
ini_set('display_errors', 0); // Don't display errors in output
ini_set('log_errors', 1);

// Set JSON content type immediately
header('Content-Type: application/json');

// Function to send JSON response and exit
function sendJsonResponse($data) {
    echo json_encode($data);
    exit();
}

// Function to log errors safely
function logError($message, $data = null) {
    $logMessage = '[QUIZ_SUBMIT] ' . $message;
    if ($data) {
        $logMessage .= ' | Data: ' . print_r($data, true);
    }
    error_log($logMessage);
}

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    logError('User not logged in', $_SESSION);
    sendJsonResponse(['success' => false, 'error' => 'User not logged in']);
}

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    logError('Invalid request method', $_SERVER['REQUEST_METHOD']);
    sendJsonResponse(['success' => false, 'error' => 'Only POST requests allowed']);
}

// Include database connection with better error handling
try {
    require_once '../dbconnection.php';
    
    // Test database connection
    if (!isset($conn) || !$conn) {
        throw new Exception('Database connection object not available');
    }
    
    // Test connection with a simple query
    $testStmt = $conn->query("SELECT 1");
    if (!$testStmt) {
        throw new Exception('Database connection test failed');
    }
    
    logError('Database connection successful');
    
} catch (Exception $e) {
    logError('Database connection failed', $e->getMessage());
    sendJsonResponse(['success' => false, 'error' => 'Database connection failed: ' . $e->getMessage()]);
}

// Get and validate input data
$input = file_get_contents('php://input');
logError('Received input', $input);

$postData = json_decode($input, true);

if (json_last_error() !== JSON_ERROR_NONE) {
    logError('JSON decode error', json_last_error_msg());
    sendJsonResponse(['success' => false, 'error' => 'Invalid JSON data: ' . json_last_error_msg()]);
}

logError('Decoded POST data', $postData);

$action = isset($postData['action']) ? $postData['action'] : '';
$moduleId = isset($postData['moduleId']) ? intval($postData['moduleId']) : 0;
$courseId = isset($postData['courseId']) ? $postData['courseId'] : '';
$userAnswers = isset($postData['userAnswers']) ? $postData['userAnswers'] : [];
$userId = $_SESSION['user_id'];

logError('Extracted values', [
    'action' => $action,
    'moduleId' => $moduleId,
    'courseId' => $courseId,
    'userId' => $userId,
    'userAnswers' => $userAnswers
]);

// Validate required data
if ($action !== 'submit_quiz') {
    sendJsonResponse(['success' => false, 'error' => 'Invalid action']);
}

if (!$moduleId || !$courseId || empty($userAnswers)) {
    sendJsonResponse(['success' => false, 'error' => 'Missing required data']);
}

// Function to get user progress
function getUserProgress($conn, $userId, $courseId) {
    try {
        $stmt = $conn->prepare("SELECT completed_modules_json, progress_percentage FROM enrollments WHERE user_id = ? AND course_id = ?");
        if (!$stmt) {
            throw new Exception('Failed to prepare progress query: ' . implode(', ', $conn->errorInfo()));
        }
        
        $stmt->execute([$userId, $courseId]);
        $progress = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($progress && $progress['completed_modules_json']) {
            // Handle both JSON string and array types
            if (is_string($progress['completed_modules_json'])) {
                $completedModules = json_decode($progress['completed_modules_json'], true);
            } else {
                $completedModules = $progress['completed_modules_json'];
            }
            
            if (!is_array($completedModules)) {
                $completedModules = [];
            }
        } else {
            $completedModules = [];
        }

        return [
            'completedModules' => $completedModules,
            'progressPercentage' => $progress ? floatval($progress['progress_percentage']) : 0,
        ];
    } catch(PDOException $e) {
        error_log('getUserProgress error: ' . $e->getMessage());
        return ['completedModules' => [], 'progressPercentage' => 0];
    }
}

try {
    logError('Starting quiz submission process');
    
    // Verify user is enrolled in the course
    $stmt = $conn->prepare("SELECT enrollment_id FROM enrollments WHERE user_id = ? AND course_id = ?");
    if (!$stmt) {
        throw new Exception('Failed to prepare enrollment check query: ' . implode(', ', $conn->errorInfo()));
    }
    
    $stmt->execute([$userId, $courseId]);
    $enrollment = $stmt->fetch();
    
    if (!$enrollment) {
        logError('User enrollment check failed', ['userId' => $userId, 'courseId' => $courseId]);
        sendJsonResponse(['success' => false, 'error' => 'User not enrolled in this course']);
    }
    
    logError('Enrollment verified');

    // Verify module belongs to the course
    $stmt = $conn->prepare("SELECT id FROM modules WHERE id = ? AND course_id = ?");
    if (!$stmt) {
        throw new Exception('Failed to prepare module check query: ' . implode(', ', $conn->errorInfo()));
    }
    
    $stmt->execute([$moduleId, $courseId]);
    $module = $stmt->fetch();
    
    if (!$module) {
        logError('Module verification failed', ['moduleId' => $moduleId, 'courseId' => $courseId]);
        sendJsonResponse(['success' => false, 'error' => 'Invalid module for this course']);
    }
    
    logError('Module verified');

    // Fetch all quizzes for the module
    $stmt = $conn->prepare("SELECT id, correct_answer FROM quizzes WHERE module_id = ? ORDER BY id ASC");
    if (!$stmt) {
        throw new Exception('Failed to prepare quiz fetch query: ' . implode(', ', $conn->errorInfo()));
    }
    
    $stmt->execute([$moduleId]);
    $quizzes = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (empty($quizzes)) {
        logError('No quizzes found', ['moduleId' => $moduleId]);
        sendJsonResponse(['success' => false, 'error' => 'No quizzes found for this module']);
    }
    
    logError('Quizzes fetched', ['count' => count($quizzes)]);

    $totalQuizzes = count($quizzes);
    $correctCount = 0;

    // Map correct answers for easy lookup
    $correctAnswers = [];
    foreach ($quizzes as $quiz) {
        $correctAnswers[$quiz['id']] = trim($quiz['correct_answer']);
    }
    
    logError('Correct answers mapped', $correctAnswers);

    // Check each submitted answer
    foreach ($userAnswers as $quizId => $userAnswer) {
        $quizId = intval($quizId);
        if (isset($correctAnswers[$quizId])) {
            if (trim($userAnswer) === $correctAnswers[$quizId]) {
                $correctCount++;
            }
        }
    }
    
    logError('Answer checking complete', ['correctCount' => $correctCount, 'totalQuizzes' => $totalQuizzes]);

    // Check if all answers are correct
    $isCorrect = ($correctCount === $totalQuizzes);

    // If all correct, update progress
    if ($isCorrect) {
        logError('All answers correct, updating progress');
        
        $userProgress = getUserProgress($conn, $userId, $courseId);
        $completedModules = $userProgress['completedModules'];

        // Add module to completed list if not already there
        if (!in_array($moduleId, $completedModules)) {
            $completedModules[] = $moduleId;

            // Get total modules count for progress calculation
            $stmt = $conn->prepare("SELECT COUNT(*) FROM modules WHERE course_id = ?");
            if (!$stmt) {
                throw new Exception('Failed to prepare module count query: ' . implode(', ', $conn->errorInfo()));
            }
            
            $stmt->execute([$courseId]);
            $totalModules = $stmt->fetchColumn();
            
            logError('Total modules count', $totalModules);

            // Calculate new progress percentage
            $newProgressPercentage = ($totalModules > 0) ? (count($completedModules) / $totalModules) * 100 : 0;

            // Update enrollment record
            $newCompletedModulesJson = json_encode($completedModules);
            $stmt = $conn->prepare("UPDATE enrollments SET completed_modules_json = ?, progress_percentage = ? WHERE user_id = ? AND course_id = ?");
            
            if (!$stmt) {
                throw new Exception('Failed to prepare enrollment update query: ' . implode(', ', $conn->errorInfo()));
            }
            
            $updateResult = $stmt->execute([$newCompletedModulesJson, $newProgressPercentage, $userId, $courseId]);
            
            if (!$updateResult) {
                throw new Exception('Failed to execute enrollment update: ' . implode(', ', $stmt->errorInfo()));
            }
            
            logError('Progress updated successfully', [
                'newProgressPercentage' => $newProgressPercentage,
                'completedModules' => $completedModules
            ]);

            // Get updated progress
            $updatedProgress = getUserProgress($conn, $userId, $courseId);
        } else {
            logError('Module already completed');
            // Module already completed
            $updatedProgress = $userProgress;
        }
    } else {
        logError('Some answers incorrect, not updating progress');
        // Get current progress for response
        $updatedProgress = getUserProgress($conn, $userId, $courseId);
    }

    // Send success response
    $response = [
        'success' => true,
        'isCorrect' => $isCorrect,
        'message' => $isCorrect 
            ? 'Congratulations! Module completed successfully.' 
            : "You got $correctCount out of $totalQuizzes questions correct. Please review and try again.",
        'correctAnswersCount' => $correctCount,
        'totalQuizzes' => $totalQuizzes,
        'progressPercentage' => $updatedProgress['progressPercentage'],
        'completedModules' => $updatedProgress['completedModules']
    ];
    
    logError('Sending success response', $response);
    sendJsonResponse($response);

} catch (PDOException $e) {
    logError('PDO Database error', [
        'message' => $e->getMessage(),
        'code' => $e->getCode(),
        'file' => $e->getFile(),
        'line' => $e->getLine()
    ]);
    sendJsonResponse(['success' => false, 'error' => 'Database error: ' . $e->getMessage()]);
} catch (Exception $e) {
    logError('General error', [
        'message' => $e->getMessage(),
        'code' => $e->getCode(),
        'file' => $e->getFile(),
        'line' => $e->getLine()
    ]);
    sendJsonResponse(['success' => false, 'error' => 'Error: ' . $e->getMessage()]);
}