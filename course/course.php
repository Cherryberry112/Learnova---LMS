<?php
// course.php
// This is the dynamic course dashboard for a logged-in user.
require_once '../session_check.php'; // For course/course.php
validateSession();

// Include the database connection and header files
require_once '../dbconnection.php';
$pathPrefix = '../';
require_once '../header.php';

// Get the course ID from the URL
$courseId = isset($_GET['id']) ? htmlspecialchars($_GET['id']) : null;
$userId = $_SESSION['user_id'];

// Function to fetch all course data (details, modules, and quizzes)
function getFullCourseData($conn, $courseId) {
    try {
        // Fetch course details
        $stmt = $conn->prepare("SELECT * FROM courses WHERE id = ?");
        $stmt->execute([$courseId]);
        $course = $stmt->fetch(PDO::FETCH_ASSOC);

        // Fetch modules
        $stmt = $conn->prepare("SELECT id, module_name, module_order FROM modules WHERE course_id = ? ORDER BY module_order ASC");
        $stmt->execute([$courseId]);
        $modules = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Fetch quizzes for each module
        foreach ($modules as $moduleIndex => &$module) {
            $stmt = $conn->prepare("SELECT id, question, correct_answer, options FROM quizzes WHERE module_id = ? ORDER BY id ASC");
            $stmt->execute([$module['id']]);
            $quizzes = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Process quiz options
            foreach($quizzes as $quizIndex => &$quiz) {
                if ($quiz['options']) {
                    $decodedOptions = json_decode($quiz['options'], true);
                    if (json_last_error() === JSON_ERROR_NONE && is_array($decodedOptions)) {
                        $quiz['options'] = $decodedOptions;
                    } else {
                        // Try to handle common JSON issues
                        $cleanedOptions = trim($quiz['options']);
                        if (strpos($cleanedOptions, '[') !== 0) {
                            $cleanedOptions = '[' . $cleanedOptions . ']';
                        }
                        $decodedOptions = json_decode($cleanedOptions, true);
                        if (json_last_error() === JSON_ERROR_NONE && is_array($decodedOptions)) {
                            $quiz['options'] = $decodedOptions;
                        } else {
                            $quiz['options'] = ['Option 1', 'Option 2', 'Option 3', 'Option 4']; // Fallback
                        }
                    }
                } else {
                    $quiz['options'] = ['Option 1', 'Option 2', 'Option 3', 'Option 4']; // Fallback
                }
            }

            $module['quizzes'] = $quizzes;
        }

        $course['modules'] = $modules;
        return $course;

    } catch(PDOException $e) {
        return null;
    }
}

// Fetch user's enrollment and progress
function getUserProgress($conn, $userId, $courseId) {
    try {
        $stmt = $conn->prepare("SELECT completed_modules_json, progress_percentage FROM enrollments WHERE user_id = ? AND course_id = ?");
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
        error_log('getUserProgress error in course.php: ' . $e->getMessage());
        return ['completedModules' => [], 'progressPercentage' => 0];
    }
}

// Get course and user data
$course = getFullCourseData($conn, $courseId);
$userProgress = getUserProgress($conn, $userId, $courseId);

$totalModules = $course ? count($course['modules']) : 0;
$completedModulesCount = count($userProgress['completedModules']);
$progressPercentage = $userProgress['progressPercentage'];

// Prepare JavaScript data safely
$jsData = [
    'courseId' => $courseId,
    'completedModules' => $userProgress['completedModules']
];

// Convert to JSON and ensure it's valid
$jsDataJson = json_encode($jsData, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP);
if (json_last_error() !== JSON_ERROR_NONE) {
    $jsDataJson = '{"courseId":"","completedModules":[]}';
}
?>

<main>
    <section class="course-details-section">
        <div class="container">
            <?php if ($course): ?>
                <div class="course-header">
                    <img src="<?php echo htmlspecialchars($course['thumbnail']); ?>" alt="<?php echo htmlspecialchars($course['name']); ?> Thumbnail" class="course-thumbnail">
                    <div class="course-info">
                        <h1 id="course-title"><?php echo htmlspecialchars($course['name']); ?></h1>
                        <p id="course-summary"><?php echo htmlspecialchars($course['summary']); ?></p>
                        <div class="progress-bar-container">
                            <div id="progress-bar" class="progress-bar" style="width: <?php echo $progressPercentage; ?>%;">
                                <span id="progress-text"><?php echo round($progressPercentage); ?>%</span>
                            </div>
                        </div>
                        <p class="progress-status">
                            <span id="completed-modules"><?php echo $completedModulesCount; ?></span> / <span id="total-modules"><?php echo $totalModules; ?></span> Modules Completed
                        </p>
                    </div>
                </div>
                <div id="modules-container" class="course-sections-grid">
                    <?php foreach ($course['modules'] as $index => $module): ?>
                        <div class="module-section faq-item" data-module-id="<?php echo $module['id']; ?>">
                            <button type="button" class="section-title faq-question" data-module-index="<?php echo $index; ?>">
                                <span class="module-title">
                                    <?php echo htmlspecialchars($module['module_name']); ?>
                                    <?php if (in_array($module['id'], $userProgress['completedModules'])): ?>
                                        <span style="color: green; font-weight: bold;"> ✓ Completed</span>
                                    <?php endif; ?>
                                </span>
                                <span class="accordion-icon">▼</span>
                            </button>
                            <div class="module-content faq-answer">
                            <video class="w-full" controls style="max-width: 1000px; border-radius: 8px;">
                                <source src="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4">
                            </video>
                                <?php if (isset($module['quizzes']) && !empty($module['quizzes'])): ?>
                                    <div class="quiz-section">
                                        <h3>Quiz: Check Your Understanding</h3>
                                        <form class="quiz-form" data-module-id="<?php echo htmlspecialchars($module['id']); ?>">
                                            <?php foreach ($module['quizzes'] as $quizIndex => $quiz): ?>
                                                <div class="quiz-item" data-quiz-id="<?php echo htmlspecialchars($quiz['id']); ?>">
                                                    <p class="quiz-question"><strong>Question <?php echo ($quizIndex + 1); ?>:</strong> <?php echo htmlspecialchars($quiz['question']); ?></p>
                                                    <div class="quiz-options">
                                                        <?php if (is_array($quiz['options']) && !empty($quiz['options'])): ?>
                                                            <?php foreach ($quiz['options'] as $optionIndex => $option): ?>
                                                                <label class="quiz-option">
                                                                    <input type="radio" name="quiz_<?php echo htmlspecialchars($quiz['id']); ?>" value="<?php echo htmlspecialchars($option); ?>" data-quiz-id="<?php echo htmlspecialchars($quiz['id']); ?>" required>
                                                                    <span><?php echo htmlspecialchars($option); ?></span>
                                                                </label>
                                                            <?php endforeach; ?>
                                                        <?php else: ?>
                                                            <p style="color: red; background: #f8d7da; padding: 10px; border-radius: 4px;">
                                                                Quiz options could not be loaded properly.
                                                            </p>
                                                        <?php endif; ?>
                                                    </div>
                                                </div>
                                            <?php endforeach; ?>
                                            <button type="submit" class="btn btn-submit" disabled>Submit Answers</button>
                                        </form>
                                        <div class="feedback-message" id="feedback-module-<?php echo htmlspecialchars($module['id']); ?>" style="display: none;"></div>
                                    </div>
                                <?php else: ?>
                                    <div style="background: #f8d7da; padding: 15px; margin: 10px 0; border-radius: 4px; color: #721c24;">
                                        <strong>No quizzes available for this module.</strong>
                                    </div>
                                <?php endif; ?>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>

                <button id="download-certificate-btn" class="btn btn-primary mt-4" style="display: <?php echo ($progressPercentage == 100) ? 'block' : 'none'; ?>;">
                    Download Certificate
                </button>

            <?php else: ?>
                <div class="course-header">
                    <div class="course-info">
                        <h1 id="course-title">Course Not Found</h1>
                        <p>The course you are looking for does not exist or you are not enrolled.</p>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </section>
</main>

<style>
/* CSS for accordion functionality */
.course-sections-grid {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.module-section {
    border: 1px solid #ddd;
    border-radius: 8px;
    margin-bottom: 1rem;
    overflow: hidden;
    background: #fff;
}

.section-title {
    margin: 0;
}

.faq-question {
    width: 100%;
    text-align: left;
    background: #f7f7f7;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    padding: 1.25rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #333;
    transition: background-color 0.3s ease;
    outline: none;
}

.faq-question:hover {
    background: #e9e9e9;
}

.faq-question:focus {
    background: #e9e9e9;
    outline: 2px solid #007bff;
}

.module-title {
    flex-grow: 1;
    text-align: left;
}

.accordion-icon {
    font-size: 1.2rem;
    line-height: 1;
    transition: transform 0.3s ease-in-out;
    color: #666;
    margin-left: 1rem;
}

.faq-item.active .accordion-icon {
    transform: rotate(180deg);
}

.faq-answer {
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.3s ease, padding 0.3s ease;
    padding: 0 1.25rem;
}

.faq-item.active .faq-answer {
    max-height: 2000px;
    padding: 1.25rem;
}

/* Quiz styling */
.quiz-section {
    margin-top: 1.5rem;
    padding: 1rem;
    background: #f9f9f9;
    border-radius: 6px;
}

.quiz-question {
    font-weight: bold;
    margin-bottom: 1rem;
    color: #333;
}

.quiz-options {
    margin-bottom: 1.5rem;
}

.quiz-option {
    display: block;
    margin-bottom: 0.5rem;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 4px;
    transition: background-color 0.2s ease;
}

.quiz-option:hover {
    background: #fff;
}

.quiz-option input[type="radio"] {
    margin-right: 0.5rem;
}

.btn {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    font-size: 1rem;
}

.btn-submit {
    background: #007bff;
    color: white;
}

.btn-submit:hover:not(:disabled) {
    background: #0056b3;
}

.btn-submit:disabled {
    background: #ccc;
    cursor: not-allowed;
}

.btn-primary {
    background: #28a745;
    color: white;
}

.btn-primary:hover {
    background: #218838;
}

.feedback-message {
    margin-top: 1rem;
    padding: 0.75rem;
    border-radius: 4px;
    font-weight: bold;
    font-size: 1rem;
    border: 2px solid transparent;
    animation: fadeIn 0.3s ease-in;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

.feedback-correct {
    background: #d4edda;
    color: #155724;
    border-color: #c3e6cb;
}

.feedback-incorrect {
    background: #f8d7da;
    color: #721c24;
    border-color: #f5c6cb;
}

.progress-bar-container {
    width: 100%;
    height: 20px;
    background: #f0f0f0;
    border-radius: 10px;
    margin: 1rem 0;
    overflow: hidden;
}

.progress-bar {
    height: 100%;
    background: linear-gradient(90deg, #28a745, #20c997);
    transition: width 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    font-size: 0.8rem;
}

.mt-4 {
    margin-top: 1.5rem;
}

/* Loading state for submit button */
.btn-submit.loading {
    background: #6c757d;
    cursor: not-allowed;
}

.btn-submit.loading::after {
    content: " ⏳";
}
</style>

<script type="text/javascript">
(function() {
    'use strict';

    // Safely embed PHP data
    let jsData;
    try {
        jsData = <?php echo $jsDataJson; ?>;
    } catch (e) {
        jsData = {courseId: '', completedModules: []};
    }

    function initializeAccordion() {
        const faqQuestions = document.querySelectorAll('.faq-question');

        faqQuestions.forEach((question) => {
            question.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();

                const parentItem = this.closest('.faq-item');
                if (!parentItem) return;

                const isCurrentlyActive = parentItem.classList.contains('active');

                // Close all accordion items
                document.querySelectorAll('.faq-item').forEach((item) => {
                    item.classList.remove('active');
                });

                // If this item wasn't active, open it
                if (!isCurrentlyActive) {
                    parentItem.classList.add('active');
                }
            });
        });
    }

    function initializeQuizzes() {
        const quizForms = document.querySelectorAll('.quiz-form');
        const completedModules = jsData.completedModules || [];

        quizForms.forEach((form) => {
            const moduleId = parseInt(form.dataset.moduleId);
            const submitBtn = form.querySelector('.btn-submit');
            const feedbackDiv = document.getElementById(`feedback-module-${moduleId}`); // Use unique ID
            const radioInputs = form.querySelectorAll('input[type="radio"]');

            console.log(`Initializing module ${moduleId}, feedback div:`, feedbackDiv);

            if (completedModules.includes(moduleId)) {
                form.querySelectorAll('input').forEach(input => input.disabled = true);
                if (submitBtn) submitBtn.disabled = true;
                if (feedbackDiv) {
                    feedbackDiv.textContent = 'You have already completed this module.';
                    feedbackDiv.className = 'feedback-message feedback-correct';
                    feedbackDiv.style.display = 'block';
                }
            } else {
                // Enable the submit button when all quizzes are answered
                const updateSubmitButton = () => {
                    const quizItems = form.querySelectorAll('.quiz-item');
                    let allQuizzesAnswered = true;

                    quizItems.forEach((item) => {
                        const checkedOption = item.querySelector('input[type="radio"]:checked');
                        if (!checkedOption) {
                            allQuizzesAnswered = false;
                        }
                    });

                    if (submitBtn) {
                        submitBtn.disabled = !allQuizzesAnswered;
                    }
                };

                // Add change listeners to all radio buttons
                radioInputs.forEach((option) => {
                    option.addEventListener('change', updateSubmitButton);
                });

                // Initial check
                updateSubmitButton();
            }

            // Handle form submission
            form.addEventListener('submit', async function(e) {
                e.preventDefault();

                const moduleId = form.dataset.moduleId;
                const submitBtn = form.querySelector('.btn-submit');
                const feedbackDiv = document.getElementById(`feedback-module-${moduleId}`); // Use unique ID

                console.log('Form element:', form);
                console.log('Submit button:', submitBtn);
                console.log('Looking for feedback div with ID: feedback-module-' + moduleId);
                console.log('Feedback div:', feedbackDiv);

                // Hide previous feedback
                if (feedbackDiv) {
                    feedbackDiv.style.display = 'none';
                } else {
                    console.error('Feedback div not found with ID: feedback-module-' + moduleId);
                }

                // Collect all user answers
                const userAnswers = {};
                const quizItems = form.querySelectorAll('.quiz-item');

                quizItems.forEach((item) => {
                    const quizId = item.dataset.quizId;
                    const selectedRadio = item.querySelector('input[type="radio"]:checked');
                    if (selectedRadio && quizId) {
                        userAnswers[quizId] = selectedRadio.value;
                    }
                });

                if (Object.keys(userAnswers).length === 0) {
                    if (feedbackDiv) {
                        feedbackDiv.textContent = 'Please select answers for all questions.';
                        feedbackDiv.className = 'feedback-message feedback-incorrect';
                        feedbackDiv.style.display = 'block';
                    }
                    return;
                }

                // Set loading state
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.classList.add('loading');
                    submitBtn.textContent = 'Submitting...';
                }

                // Prepare payload
                const payload = {
                    action: 'submit_quiz',
                    moduleId: parseInt(moduleId),
                    courseId: jsData.courseId,
                    userAnswers: userAnswers
                };

                console.log('Submitting quiz with payload:', payload);

                try {
                    // Send to dedicated submission handler
                    const response = await fetch('submit_quiz.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-Requested-With': 'XMLHttpRequest'
                        },
                        body: JSON.stringify(payload)
                    });

                    console.log('Response status:', response.status);
                    console.log('Response headers:', [...response.headers.entries()]);

                    if (!response.ok) {
                        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                    }

                    const contentType = response.headers.get('content-type');
                    if (!contentType || !contentType.includes('application/json')) {
                        const text = await response.text();
                        console.error('Non-JSON response received:', text);
                        throw new Error('Server returned non-JSON response');
                    }

                    const result = await response.json();
                    console.log('Parsed response:', result);

                    if (!result.success) {
                        throw new Error(result.error || 'Unknown server error');
                    }

                    // Find feedback div and log for debugging
                    console.log('Feedback div element:', feedbackDiv);
                    console.log('Message to display:', result.message);

                    // Display feedback
                    if (feedbackDiv) {
                        feedbackDiv.textContent = result.message || 'Quiz submitted successfully';
                        feedbackDiv.className = `feedback-message ${result.isCorrect ? 'feedback-correct' : 'feedback-incorrect'}`;
                        feedbackDiv.style.display = 'block';
                        
                        // Scroll to feedback message so user can see it
                        feedbackDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                        
                        console.log('Feedback message displayed:', feedbackDiv.textContent);
                        console.log('Feedback div classes:', feedbackDiv.className);
                    } else {
                        console.error('Feedback div not found!');
                    }

                    // If correct, update the UI
                    if (result.isCorrect) {
                        // Update progress bar
                        const progressText = document.getElementById('progress-text');
                        const progressBar = document.getElementById('progress-bar');
                        const completedModulesSpan = document.getElementById('completed-modules');

                        if (completedModulesSpan) {
                            completedModulesSpan.textContent = result.completedModules.length;
                        }
                        if (progressBar) {
                            progressBar.style.width = `${result.progressPercentage}%`;
                        }
                        if (progressText) {
                            progressText.textContent = `${Math.round(result.progressPercentage)}%`;
                        }

                        // Disable the form
                        form.querySelectorAll('input').forEach(input => input.disabled = true);
                        if (submitBtn) {
                            submitBtn.disabled = true;
                            submitBtn.textContent = 'Completed';
                            submitBtn.classList.remove('loading');
                        }

                        // Update module title to show completion
                        const moduleSection = form.closest('.module-section');
                        const moduleTitle = moduleSection?.querySelector('.module-title');
                        if (moduleTitle && !moduleTitle.textContent.includes('✓ Completed')) {
                            moduleTitle.innerHTML += ' <span style="color: green; font-weight: bold;"> ✓ Completed</span>';
                        }

                        // Show certificate download if course is complete
                        if (result.progressPercentage === 100) {
                            const downloadBtn = document.getElementById('download-certificate-btn');
                            if (downloadBtn) {
                                downloadBtn.style.display = 'block';
                            }
                        }
                    } else {
                        // Reset submit button for incorrect answers
                        if (submitBtn) {
                            submitBtn.disabled = false;
                            submitBtn.classList.remove('loading');
                            submitBtn.textContent = 'Submit Answers';
                        }
                    }

                } catch (error) {
                    console.error('Quiz submission failed:', error);
                    
                    // Show error message
                    if (feedbackDiv) {
                        feedbackDiv.textContent = 'An error occurred while submitting your answers. Please try again.';
                        feedbackDiv.className = 'feedback-message feedback-incorrect';
                        feedbackDiv.style.display = 'block';
                    }

                    // Reset submit button
                    if (submitBtn) {
                        submitBtn.disabled = false;
                        submitBtn.classList.remove('loading');
                        submitBtn.textContent = 'Submit Answers';
                    }
                }
            });
        });
    }

    function initializeCertificateDownload() {
        const downloadBtn = document.getElementById('download-certificate-btn');
        if (downloadBtn) {
            downloadBtn.addEventListener('click', function() {
                // Redirect to separate certificate generation page
                const certificateUrl = `generate_certificate.php?course_id=${encodeURIComponent(jsData.courseId)}`;
                window.open(certificateUrl, '_blank');
            });
        }
    }

    // Initialize everything when DOM is ready
    function initializeAll() {
        initializeAccordion();
        initializeQuizzes();
        initializeCertificateDownload();
    }

    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initializeAll);
    } else {
        initializeAll();
    }
})();
</script>

<?php
// Include the footer file, which contains the closing HTML tags.
require_once '../footer.php';
?>
