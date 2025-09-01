<?php
// index.php
session_start(); // Start the session at the very beginning of the file

// Include the database connection file.
// This allows you to use the $conn variable on this page.
require_once 'dbconnection.php';

// Include the header file, which contains the navigation and the opening HTML tags.
$pathPrefix = '';
require_once 'header.php';

// =========================================================================
// Main Page Content
// This content is taken directly from the original index.html.
// =========================================================================
?>

    <section class="hero-section">
        <div class="animated-circle"></div>
        <div class="container">
            <div class="hero-content">
                <h1>Welcome to Learnova!</h1>
                <p>"Where knowledge meets opportunity, and your passion finds its purpose."</p>
                <div class="hero-buttons">
                    <a href="course\all_courses.php" class="btn btn-cta">Get Started</a>
                </div>
            </div>
            <div class="hero-image">
                <img src="image/w1.png" alt="A smiling student" class="hero-image-circle">
                <div class="info-card card-top">
                    <div class="info-card-icon">
                        <span>50</span>
                    </div>
                    <div class="info-card-text">
                        <strong>50+</strong>
                        <span>Video Courses</span>
                    </div>
                </div>
                <div class="info-card card-bottom">
                    <div class="info-card-icon">
                        <span>20</span>
                    </div>
                    <div class="info-card-text">
                        <strong>20+</strong>
                        <span>Tutors</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about-us-section" id="about-us">
        <div class="container">
            <h2 class="section-title">Our Story</h2>
            <div class="about-content">
                <img src="image\story.png" alt="Our Story Image" class="about-image">
                <p>Learnova was founded with a simple idea: to make high-quality education accessible to everyone, everywhere. Our journey began with a small team of educators and developers who believed that technology could break down traditional barriers to learning. From a handful of pilot courses, we've grown into a global community, helping thousands of students achieve their goals and discover their passions. We are committed to providing an enriching and empowering learning experience that adapts to your needs and helps you thrive in a changing world.</p>
            </div>
        </div>
    </section>

    <section class="features-section" id="features">
        <div class="container">
            <h2 class="section-title">What We Offer</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <img src="image\1.png" alt="Interactive Learning Icon">
                    <h3>Interactive Learning</h3>
                    <p>Engage with dynamic lessons, hands-on labs, and real-time feedback to solidify your knowledge.</p>
                </div>
                <div class="feature-card">
                    <img src="image\2.png" alt="Quizzes Icon">
                    <h3>Quizzes & Assessments</h3>
                    <p>Test your understanding with regular quizzes and get instant results to track your progress.</p>
                </div>
                <div class="feature-card">
                    <img src="image\3.png" alt="Support Icon">
                    <h3>Expert Support</h3>
                    <p>Connect with expert tutors and a supportive community to get help whenever you need it.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="courses-section">
        <div class="container">
            <h2 class="section-title">Popular Courses</h2>
            <div class="course-grid">
                <a href="course/course_page.php?id=webdev" class="course-card-link">
                    <div class="course-card">
                        <img src="image\web.png" alt="Web Development Course Image">
                        <div class="card-content">
                            <h3>Web Development Fundamentals</h3>
                            <p>Master the basics of HTML, CSS, and JavaScript to build your first websites.</p>
                        </div>
                    </div>
                </a>
                <a href="course/course_page.php?id=datascience" class="course-card-link">
                    <div class="course-card">
                        <img src="image\DATA.png" alt="Data Science Course Image">
                        <div class="card-content">
                            <h3>Data Science for Beginners</h3>
                            <p>An introduction to data analysis and machine learning.</p>
                        </div>
                    </div>
                </a>
                <a href="course/course_page.php?id=ai" class="course-card-link">
                    <div class="course-card">
                        <img src="image\AI.png" alt="AI ML Course Image">
                        <div class="card-content">
                            <h3>AI and Machine Learning</h3>
                            <p>An in-depth look into the world of artificial intelligence and machine learning.</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </section>

    <section class="contact-us-section" id="contact-us">
        <div class="container">
            <h2 class="section-title">Contact Us</h2>
            <p>You can add a contact form, email address, or phone number here for your users to get in touch with you.</p>
            <div class="hero-buttons" style="margin-top: 20px;">
                <a href="mailto:lernova.official@gmail.com" class="btn btn-cta">Mail Us</a>
            </div>
        </div>
    </section>

<?php
// Include the footer file, which contains the closing HTML tags.
require_once 'footer.php';
?>