<?php
// header.php
// This file contains the HTML head section and the dynamic header.
// It relies on session variables to determine the user's login status.

// This variable will be defined in the pages that include this header
// and used to create dynamic paths.
if (!isset($pathPrefix)) {
    $pathPrefix = '';
}

$isLoggedIn = isset($_SESSION['user_id']);

// FIX: Check if the specific session keys are set to prevent warnings.
$userRole = isset($_SESSION['role']) ? $_SESSION['role'] : null;
$userName = isset($_SESSION['username']) ? $_SESSION['username'] : null;
$profileImageUrl = isset($_SESSION['profile_image_url']) ? $_SESSION['profile_image_url'] : null;

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learnova - Online Learning Platform</title>
    <link rel="stylesheet" href="<?php echo $pathPrefix; ?>style.css">
    <link rel="stylesheet" href="<?php echo $pathPrefix; ?>course/course_page.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* Additional styling for the profile dropdown */
        .user-profile-dropdown {
            position: relative;
            display: inline-block;
            cursor: pointer;
        }

        .profile-name {
            display: flex;
            align-items: center;
            font-size: 1rem;
            font-weight: 600;
            color: var(--green-dark);
            transition: color 0.3s ease;
        }

        .profile-name:hover {
            color: #116834;
        }

        .profile-name img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 8px;
            object-fit: cover;
        }

        .profile-name i {
            margin-right: 8px;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            right: 0;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 10px;
        }

        .dropdown-content a {
            color: var(--green-dark);
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-weight: 500;
            transition: background-color 0.2s ease;
        }

        .dropdown-content a:hover {
            background-color: var(--green-light);
        }

        .user-profile-dropdown:hover .dropdown-content {
            display: block;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="container">
            <div class="logo">
                <a href="<?php echo $pathPrefix; ?>index.php">Learnova</a>
            </div>
            <nav class="nav">
                <a href="<?php echo $pathPrefix; ?>course/all_courses.php">Courses</a>
                <a href="<?php echo $pathPrefix; ?>#about-us">About us</a>
                <a href="<?php echo $pathPrefix; ?>faq.php">FAQ's</a>
                <a href="<?php echo $pathPrefix; ?>#contact-us">Contact us</a>

                <?php if ($isLoggedIn): ?>
                    <div class="user-profile-dropdown">
                        <span class="profile-name">
                            <?php if ($profileImageUrl): ?>
                                <img src="<?php echo htmlspecialchars($profileImageUrl); ?>" alt="Profile Image">
                            <?php else: ?>
                                <i class="fa-solid fa-user-circle"></i>
                            <?php endif; ?>
                            <?php echo htmlspecialchars($userName); ?>
                        </span>
                        <div class="dropdown-content">
                            <?php if ($userRole == 'student'): ?>
                                <a href="<?php echo $pathPrefix; ?>dashboard.php" class="btn btn-logout">My dashboard</a>
                            <?php elseif ($userRole == 'instructor'): ?>
                                <a href="<?php echo $pathPrefix; ?>dashboard.php" class="btn btn-logout">My dashboard</a>
                            <?php elseif ($userRole == 'admin'): ?>
                                <a href="<?php echo $pathPrefix; ?>dashboard.php" class="btn btn-logout">My dashboard</a>
                            <?php endif; ?>
                            <a href="<?php echo $pathPrefix; ?>logout.php" class="btn btn-logout">Logout</a>
                        </div>
                    </div>
                <?php else: ?>
                    <a href="<?php echo $pathPrefix; ?>login.php" class="btn btn-login">Login</a>
                    <a href="<?php echo $pathPrefix; ?>signup.php" class="btn btn-signup">Sign Up</a>
                <?php endif; ?>
            </nav>
        </div>
    </header>