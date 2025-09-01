<?php
// generate_certificate.php
require_once '../session_check.php'; // For course/course.php
validateSession();

// Get parameters from URL
$courseId = isset($_GET['course_id']) ? htmlspecialchars($_GET['course_id']) : '';
$currentDate = date('F j, Y');

// Get data from database
require_once '../dbconnection.php';
$userId = $_SESSION['user_id'];

try {
    // First verify user has completed the course
    $stmt = $conn->prepare("SELECT progress_percentage FROM enrollments WHERE user_id = ? AND course_id = ?");
    $stmt->execute([$userId, $courseId]);
    $progress = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$progress || $progress['progress_percentage'] < 100) {
        echo "<h1>Access Denied</h1><p>You must complete the course to download the certificate.</p>";
        exit();
    }

    // Get user information using fullname column
    $stmt = $conn->prepare("SELECT fullname FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // Get course information
    $stmt = $conn->prepare("SELECT name FROM courses WHERE id = ?");
    $stmt->execute([$courseId]);
    $course = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user || !$course) {
        echo "<h1>Error</h1><p>Unable to load user or course information.</p>";
        exit();
    }

    // Use fullname directly
    $displayName = $user['fullname'];
    $courseName = $course['name'];

} catch (PDOException $e) {
    echo "<h1>Database Error</h1><p>Error details: " . htmlspecialchars($e->getMessage()) . "</p>";
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate Generator</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&family=Playfair+Display:wght@700&family=Great+Vibes&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
            background: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .certificate-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 900px;
            max-width: 100%;
        }

        .download-btn {
            background: #28a745;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            margin: 20px;
            transition: background 0.3s ease;
        }

        .download-btn:hover {
            background: #218838;
        }

        .download-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        #certificate-template {
            width: 800px;
            height: 600px;
            margin: 30px auto;
            position: relative;
            box-sizing: border-box;
            background: #ffffff;
            border: 1px solid #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            background-image: linear-gradient(135deg, #f5f5f5 0%, #ffffff 100%);
        }

        .cert-border {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .cert-border .green-shape {
            position: absolute;
            background: linear-gradient(135deg, #aed581 0%, #6b8e23 100%);
        }
        
        /* New green gradient shapes */
        .cert-border .green-shape.bottom-right-large {
            width: 500px;
            height: 500px;
            border-top-left-radius: 100%;
            bottom: -250px;
            right: -250px;
            transform: rotate(45deg);
        }

        .cert-border .green-shape.bottom-right-medium {
            width: 480px;
            height: 480px;
            border-top-left-radius: 100%;
            bottom: -240px;
            right: -240px;
            transform: rotate(45deg);
        }

        .cert-border .green-shape.top-left-small {
            width: 250px;
            height: 250px;
            border-bottom-right-radius: 100%;
            top: -125px;
            left: -125px;
            transform: rotate(45deg);
        }

        .cert-border .green-shape.top-left-smaller {
            width: 230px;
            height: 230px;
            border-bottom-right-radius: 100%;
            top: -115px;
            left: -115px;
            transform: rotate(45deg);
        }
        
        .cert-main-content {
            position: relative;
            z-index: 2;
            text-align: center;
            padding: 40px;
        }
        
        .cert-logo {
            width: 200px;
            margin-bottom: 20px;
        }

        .cert-title {
            font-family: 'Playfair Display', serif;
            font-size: 50px;
            font-weight: 700;
            color: #333;
            margin: 0;
            padding: 0;
            text-transform: uppercase;
        }

        .cert-subtitle {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            color: #666;
            margin-top: 10px;
        }

        .cert-proudly-presented {
            font-size: 20px;
            color: #555;
            margin: 40px 0 10px;
            font-weight: bold;
        }

        .cert-username {
            font-family: 'Great Vibes', cursive;
            font-size: 60px;
            color: #4CAF50;
            margin: 0;
            line-height: 1;
        }
        
        .cert-body-text {
            font-size: 16px;
            color: #303030ff;
            max-width: 500px;
            margin: 20px auto 40px;
            line-height: 1.5;
        }
        
        .cert-course-name {
            font-size: 32px; /* Increased font size */
            color: #2E8B57; /* A darker, richer green */
            font-weight: bold;
            margin: 20px 0;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2); /* Added text shadow for pop effect */
            text-transform: uppercase;
        }

        .cert-signatures {
            display: flex;
            justify-content: center;
            width: 100%;
            max-width: 600px;
            margin-top: 50px;
        }

        .cert-signature-block {
            text-align: center;
        }

        .cert-signature-line {
            width: 200px;
            height: 1px;
            background-color: #000;
            margin: 10px auto;
        }

        .cert-signature-label {
            font-size: 14px;
            color: #333;
            text-transform: uppercase;
            font-weight: bold;
        }

        .loading {
            display: none;
            color: #007bff;
            font-size: 16px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="certificate-container">
        <h1>Certificate Generator</h1>
        <p>Generate and download your course completion certificate</p>

        <button id="generate-btn" class="download-btn">Generate & Download Certificate</button>
        <div id="loading" class="loading">Generating certificate...</div>

        <div id="certificate-template">
            <div class="cert-border">
                <div class="green-shape top-left-small"></div>
                <div class="green-shape top-left-smaller"></div>
                <div class="green-shape bottom-right-large"></div>
                <div class="green-shape bottom-right-medium"></div>
            </div>

            <div class="cert-main-content">
                <h1 class="cert-title">Certificate of Completion</h1>
                <p class="cert-proudly-presented">THIS CERTIFICATE IS PROUDLY PRESENTED TO</p>
                <h2 class="cert-username"><?php echo ucwords($displayName); ?></h2>
                <p class="cert-body-text">
                    For successfully completing the online course<br>
                    <span class="cert-course-name"><?php echo $courseName; ?></span><br>
                    This is an acknowledgement of your dedication and hard work.
                </p>
                <p class="cert-signature-label">DATE: <?php echo strtoupper($currentDate); ?></p>
                
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

    <script>
        document.getElementById('generate-btn').addEventListener('click', function() {
            const btn = this;
            const loading = document.getElementById('loading');
            const certTemplate = document.getElementById('certificate-template');

            // Show loading state
            btn.disabled = true;
            loading.style.display = 'block';
            btn.textContent = 'Generating...';

            setTimeout(() => {
                html2canvas(certTemplate, {
                    scale: 2,
                    useCORS: true,
                    allowTaint: true,
                    backgroundColor: '#ffffff'
                }).then(canvas => {
                    try {
                        const imgData = canvas.toDataURL('image/jpeg', 1.0);
                        const { jsPDF } = window.jspdf;

                        // Create PDF in landscape orientation
                        const pdf = new jsPDF({
                            orientation: 'landscape',
                            unit: 'px',
                            format: [800, 600]
                        });

                        // Add the image to PDF
                        pdf.addImage(imgData, 'JPEG', 0, 0, 800, 600);

                        // Generate filename
                        const displayName = '<?php echo addslashes($displayName); ?>';
                        const courseName = '<?php echo addslashes($courseName); ?>';
                        const filename = `${displayName.replace(/[^a-zA-Z0-9\s]/g, '')}_${courseName.replace(/[^a-zA-Z0-9\s]/g, '')}_Certificate.pdf`.replace(/\s/g, '_');

                        // Download the PDF
                        pdf.save(filename);

                        // Reset button state
                        btn.disabled = false;
                        loading.style.display = 'none';
                        btn.textContent = 'Generate & Download Certificate';

                        const successMsg = document.createElement('div');
                        successMsg.style.cssText = 'color: green; margin: 10px 0; font-weight: bold;';
                        successMsg.textContent = 'Certificate downloaded successfully!';
                        btn.parentNode.insertBefore(successMsg, btn.nextSibling);

                        setTimeout(() => {
                            if (successMsg.parentNode) {
                                successMsg.parentNode.removeChild(successMsg);
                            }
                        }, 3000);

                    } catch (pdfError) {
                        throw new Error('PDF generation failed: ' + pdfError.message);
                    }
                }).catch(error => {
                    btn.disabled = false;
                    loading.style.display = 'none';
                    btn.textContent = 'Generate & Download Certificate';

                    const errorMsg = document.createElement('div');
                    errorMsg.style.cssText = 'color: red; margin: 10px 0; font-weight: bold;';
                    errorMsg.textContent = 'Failed to generate certificate. Please try again.';
                    btn.parentNode.insertBefore(errorMsg, btn.nextSibling);

                    setTimeout(() => {
                        if (errorMsg.parentNode) {
                            errorMsg.parentNode.removeChild(errorMsg);
                        }
                    }, 5000);
                });
            }, 500);
        });
    </script>
</body>
</html>