-- learnovaDB.sql

-- --------------------------------------------------------
-- This script creates the 'learnovaDB' database and the 'users' table.
-- It also populates the table with 20 dummy users for testing purposes.
-- The password for all dummy users is '1234'.
-- The password is securely stored as a hash: '$2y$10$t3Xh9V.QoD4z2m.n.hE.j.uW1T7eWlY'
-- --------------------------------------------------------

-- Drop the database if it already exists to ensure a clean slate
DROP DATABASE IF EXISTS `learnovaDB`;

-- Create the database
CREATE DATABASE `learnovaDB`;

-- Use the newly created database
USE `learnovaDB`;

-- --------------------------------------------------------
-- Table structure for `users`
-- --------------------------------------------------------
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL UNIQUE,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('student','instructor','admin') NOT NULL,
  `profile_image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Dummy data for the `users` table
-- --------------------------------------------------------
INSERT INTO `users` (`fullname`, `email`, `password_hash`, `role`, `profile_image_url`) VALUES
('Alice Johnson', 'alice.j@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Bob Williams', 'bob.w@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Charlie Brown', 'charlie.b@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', 'https://i.imgur.com/9tQrEKw.png'),
('Diana Miller', 'diana.m@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Ethan Davis', 'ethan.d@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Frank White', 'frank.w@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'instructor', NULL),
('Grace Taylor', 'grace.t@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'instructor', NULL),
('Hannah Scott', 'hannah.s@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'admin', NULL),
('Ivy Clark', 'ivy.c@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'admin', 'https://i.imgur.com/db2Ctp8.png'),
('Jack Wilson', 'jack.w@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Karen Baker', 'karen.b@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Leo Adams', 'leo.a@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Mia Hall', 'mia.h@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Noah Green', 'noah.g@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Olivia Carter', 'olivia.c@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Peter King', 'peter.k@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'instructor', 'https://i.imgur.com/DriqBNx.png'),
('Quinn Wright', 'quinn.w@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Ryan Cooper', 'ryan.c@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL),
('Sophia Turner', 'sophia.t@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'admin', NULL),
('Tyler Hill', 'tyler.h@example.com', '$2y$10$md9dq4ub7h4OG.OgHwENqOJRb4BDI.GXCNtAAd3FNlANgthVi9Iwa', 'student', NULL);



DROP TABLE IF EXISTS `enrollments`;
DROP TABLE IF EXISTS `quizzes`;
DROP TABLE IF EXISTS `modules`;
DROP TABLE IF EXISTS `courses`;

-- --------------------------------------------------------
-- Table structure for `courses`
-- --------------------------------------------------------
CREATE TABLE `courses` (
  `id` VARCHAR(255) NOT NULL PRIMARY KEY, -- Changed to VARCHAR, matches JS 'id'
  `name` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `summary` TEXT NOT NULL,
  `thumbnail` VARCHAR(255) DEFAULT NULL, -- Changed from thumbnail_url to thumbnail
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for `modules`
-- --------------------------------------------------------
CREATE TABLE `modules` (
  `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `course_id` VARCHAR(255) NOT NULL, -- References courses.id (VARCHAR)
  `module_name` VARCHAR(255) NOT NULL, -- New column name, matches JS timeline items
  `module_order` INT(11) NOT NULL,
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`) ON DELETE CASCADE,
  UNIQUE (`course_id`, `module_order`) -- Ensures unique module order per course
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for `quizzes`
-- --------------------------------------------------------
CREATE TABLE `quizzes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `module_id` INT(11) NOT NULL,
  `question` TEXT NOT NULL,
  `correct_answer` TEXT NOT NULL,
  `options` JSON NOT NULL, -- Store options as a JSON array
  FOREIGN KEY (`module_id`) REFERENCES `modules`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for `enrollments`
-- This table tracks which student is enrolled in which course, and their progress.
-- `completed_modules_json` will store a JSON array of completed module IDs.
-- --------------------------------------------------------
CREATE TABLE `enrollments` (
  `enrollment_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `course_id` VARCHAR(255) NOT NULL, -- References courses.id (VARCHAR)
  `enrollment_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `completion_date` TIMESTAMP NULL DEFAULT NULL,
  `completed_modules_json` JSON DEFAULT '[]', -- Stores a JSON array of module_id values
  `progress_percentage` DECIMAL(5,2) DEFAULT 0.00,
  PRIMARY KEY (`enrollment_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`) ON DELETE CASCADE,
  UNIQUE (`user_id`, `course_id`) -- A student can only enroll in a course once
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- --------------------------------------------------------
-- Data for the `courses` table
-- --------------------------------------------------------
INSERT INTO `courses` (`id`, `name`, `title`, `summary`, `thumbnail`) VALUES
('webdev', 'Web Development Fundamentals', 'Web Development', 'Learn the foundational skills of web development, including HTML, CSS, and JavaScript. Build your first interactive websites from scratch.', 'https://i.imgur.com/XUyBxsB.png'),
('datascience', 'Data Science for Beginners', 'Data Science', 'An introductory course to data analysis and machine learning. Learn to process data, visualize findings, and build predictive models.', 'https://i.imgur.com/m4CSZdm.png'),
('marketing', 'Digital Marketing Mastery', 'Digital Marketing', 'A comprehensive guide to online advertising, social media marketing, and SEO. Drive traffic and grow your brand with proven strategies.', 'https://i.imgur.com/Ix8EYKJ.png'),
('python', 'Python for Everybody', 'Python', 'Learn the basics of Python programming from scratch. This course is perfect for beginners with no prior coding experience.', 'https://i.imgur.com/LiDXcmn.png'),
('graphicdesign', 'Graphic Design Essentials', 'Graphic Design', 'Master the principles of design, color theory, and typography. Learn to use creative software like Adobe Photoshop and Illustrator.', 'https://i.imgur.com/bpSC5Lu.png'),
('mobiledev', 'Mobile App Development', 'Mobile App Development', 'Build your first mobile app for iOS and Android using modern frameworks. Learn about UI/UX design for mobile and app store deployment.', 'https://i.imgur.com/loEHAPU.png'),
('ai', 'AI and Machine Learning', 'AI/ML', 'An in-depth look into the world of artificial intelligence and machine learning. Learn about neural networks, deep learning, and practical applications.', 'https://i.imgur.com/YSAOAOL.png'),
('cybersecurity', 'Cybersecurity Fundamentals', 'Cybersecurity', 'Protecting data and systems from digital threats. This course covers network security, cryptography, and risk management.', 'https://i.imgur.com/djOZIWG.png'),
('uxdesign', 'UX/UI Design Principles', 'UX/UI Design', 'Designing user-friendly interfaces and experiences. Learn about user research, wireframing, prototyping, and usability testing.', 'https://i.imgur.com/M2970Pu.png'),
('blockchain', 'Blockchain Essentials', 'Blockchain', 'Explore the technology behind cryptocurrencies, smart contracts, and decentralized applications. Understand the fundamentals of distributed ledgers.', 'https://i.imgur.com/iK0aX5z.png');
-- --------------------------------------------------------
-- Data for the `modules` table
-- Note: The 'instructions' from the JS course object are not directly mapped to `modules`
-- as the user's new `modules` table structure doesn't include an `instructions` column.
-- The 'timeline' items from JS are used as `module_name`.
-- --------------------------------------------------------

-- Web Development Fundamentals Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('webdev', 1, 'Module 1: Introduction to HTML5'),
('webdev', 2, 'Module 2: CSS3 for Styling'),
('webdev', 3, 'Module 3: JavaScript Basics'),
('webdev', 4, 'Module 4: Responsive Design'),
('webdev', 5, 'Module 5: Project Work');

-- Data Science for Beginners Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('datascience', 1, 'Module 1: Introduction to Data Science'),
('datascience', 2, 'Module 2: Python for Data Analysis (Pandas, NumPy)'),
('datascience', 3, 'Module 3: Data Visualization (Matplotlib, Seaborn)'),
('datascience', 4, 'Module 4: Machine Learning Fundamentals'),
('datascience', 5, 'Module 5: Capstone Project');

-- Digital Marketing Mastery Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('marketing', 1, 'Module 1: Foundations of Digital Marketing'),
('marketing', 2, 'Module 2: Search Engine Optimization (SEO)'),
('marketing', 3, 'Module 3: Social Media Marketing'),
('marketing', 4, 'Module 4: Email Marketing and Analytics'),
('marketing', 5, 'Module 5: Creating a Digital Marketing Plan');

-- Python for Everybody Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('python', 1, 'Module 1: Getting Started with Python'),
('python', 2, 'Module 2: Data Structures and Functions'),
('python', 3, 'Module 3: Object-Oriented Programming'),
('python', 4, 'Module 4: File Handling and APIs'),
('python', 5, 'Module 5: Building a Simple App');

-- Graphic Design Essentials Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('graphicdesign', 1, 'Module 1: Foundations of Design'),
('graphicdesign', 2, 'Module 2: Typography and Layout'),
('graphicdesign', 3, 'Module 3: Color Theory and Branding'),
('graphicdesign', 4, 'Module 4: Software Mastery (Photoshop & Illustrator)'),
('graphicdesign', 5, 'Module 5: Creating a Portfolio');

-- Mobile App Development Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('mobiledev', 1, 'Module 1: Introduction to Mobile Frameworks'),
('mobiledev', 2, 'Module 2: UI/UX for Mobile'),
('mobiledev', 3, 'Module 3: Data Management and APIs'),
('mobiledev', 4, 'Module 4: Testing and Debugging'),
('mobiledev', 5, 'Module 5: App Store Deployment');

-- AI and Machine Learning Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('ai', 1, 'Module 1: Introduction to AI and ML'),
('ai', 2, 'Module 2: Supervised and Unsupervised Learning'),
('ai', 3, 'Module 3: Neural Networks and Deep Learning'),
('ai', 4, 'Module 4: Natural Language Processing (NLP)'),
('ai', 5, 'Module 5: Building an AI Model');

-- Cybersecurity Fundamentals Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('cybersecurity', 1, 'Module 1: Introduction to Cybersecurity'),
('cybersecurity', 2, 'Module 2: Network Security and Firewalls'),
('cybersecurity', 3, 'Module 3: Cryptography and Data Protection'),
('cybersecurity', 4, 'Module 4: Threat Detection and Incident Response'),
('cybersecurity', 5, 'Module 5: Ethical Hacking and Penetration Testing');

-- UX/UI Design Principles Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('uxdesign', 1, 'Module 1: User-Centered Design'),
('uxdesign', 2, 'Module 2: User Research and Personas'),
('uxdesign', 3, 'Module 3: Wireframing and Prototyping'),
('uxdesign', 4, 'Module 4: Usability Testing and Feedback'),
('uxdesign', 5, 'Module 5: Final Portfolio Project');

-- Blockchain Essentials Modules
INSERT INTO `modules` (`course_id`, `module_order`, `module_name`) VALUES
('blockchain', 1, 'Module 1: Introduction to Blockchain'),
('blockchain', 2, 'Module 2: How Cryptocurrencies Work'),
('blockchain', 3, 'Module 3: Smart Contracts'),
('blockchain', 4, 'Module 4: Decentralized Applications (DApps)'),
('blockchain', 5, 'Module 5: The Future of Blockchain');


-- --------------------------------------------------------
-- Data for the `quizzes` table (all 250 quiz sets)
-- --------------------------------------------------------

-- Web Development Fundamentals Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 1), 'What does HTML stand for?', 'Hyper Text Markup Language', JSON_ARRAY('Hyper Trainer Markup Language', 'Hyper Text Markup Language', 'Hyperlink and Text Markup Language', 'Home Tool Markup Language')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 1), 'Which tag is used to define an image?', '<img>', JSON_ARRAY('<image>', '<picture>', '<img>', '<src>')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 1), 'Which HTML tag is used for the largest heading?', '<h1>', JSON_ARRAY('<head>', '<h6>', '<h1>', '<heading>')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 1), 'What is the correct HTML tag for a line break?', '<br>', JSON_ARRAY('<break>', '<br>', '<lb>', '<line>')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 1), 'What is the purpose of the <body> tag?', 'It defines the document''s body, which is visible to the user.', JSON_ARRAY('It contains metadata about the HTML document.', 'It defines the document''s body, which is visible to the user.', 'It links to external style sheets.', 'It creates a hyperlink to another page.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 2), 'What does CSS stand for?', 'Cascading Style Sheets', JSON_ARRAY('Creative Style Sheets', 'Computer Style Sheets', 'Colorful Style Sheets', 'Cascading Style Sheets')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 2), 'Which property is used to change the background color?', 'background-color', JSON_ARRAY('color', 'bgcolor', 'background-color', 'bg-color')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 2), 'Which CSS property controls the text size?', 'font-size', JSON_ARRAY('font-style', 'text-size', 'font-size', 'text-style')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 2), 'How do you select an element with id "demo"?', '#demo', JSON_ARRAY('.demo', 'demo', '#demo', '*demo')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 2), 'Which CSS property is used to make a font bold?', 'font-weight', JSON_ARRAY('font-weight', 'text-bold', 'font-style', 'bold'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 3), 'Where is the correct place to insert a JavaScript?', 'Both the <head> section and the <body> section are correct', JSON_ARRAY('The <head> section', 'The <body> section', 'Both the <head> section and the <body> section are correct', 'The <footer> section')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 3), 'How do you write "Hello World" in an alert box?', 'alert("Hello World");', JSON_ARRAY('msgBox("Hello World");', 'alert("Hello World");', 'msg("Hello World");', 'alertbox("Hello World");')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 3), 'How do you call a function named "myFunction"?', 'myFunction()', JSON_ARRAY('call function myFunction()', 'call myFunction()', 'myFunction()', 'execute myFunction()')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 3), 'How do you create a variable?', 'var carName;', JSON_ARRAY('var carName;', 'variable carName;', 'v carName;', 'string carName;')),
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 3), 'What is the correct syntax for a for loop?', 'for (let i = 0; i < 5; i++)', JSON_ARRAY('for (i <= 5; i++)', 'for (i = 0; i < 5)', 'for (let i = 0; i < 5; i++)', 'for (i = 0; i <= 5)'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 4), 'What is the purpose of a media query?', 'To apply CSS based on device characteristics like screen width.', JSON_ARRAY('To fetch media files from a server.', 'To apply CSS based on device characteristics like screen width.', 'To create video and audio players.', 'To query a database for media content.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 4), 'Which meta tag is crucial for responsive design?', '<meta name="viewport" content="width=device-width, initial-scale=1.0">', JSON_ARRAY('<meta name="viewport" content="initial-scale=1.0">', '<meta name="viewport" content="width=device-width">', '<meta name="viewport" content="width=device-width, initial-scale=1.0">', '<meta name="viewport" content="user-scalable=no">'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 4), 'Which unit is a relative unit of measurement?', 'rem', JSON_ARRAY('px', 'pt', 'cm', 'rem'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 4), 'Which CSS layout system is ideal for creating complex grid-based layouts?', 'Grid', JSON_ARRAY('Flexbox', 'Floats', 'Tables', 'Grid'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 4), 'What is the mobile-first approach?', 'Designing for mobile devices first, then for larger screens.', JSON_ARRAY('Designing for desktop screens first, then for smaller screens.', 'Designing a separate website for mobile devices.', 'Designing for mobile devices first, then for larger screens.', 'Using a fixed-width layout for all devices.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 5), 'Which step is a key part of project planning?', 'Creating a wireframe.', JSON_ARRAY('Submitting your project.', 'Creating a wireframe.', 'Writing code without a plan.', 'Ignoring user feedback.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 5), 'Why is it important to test your project?', 'To find and fix bugs and ensure it works as intended.', JSON_ARRAY('To make it more complicated.', 'To find and fix bugs and ensure it works as intended.', 'To add more features.', 'To get a passing grade.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 5), 'What is the purpose of version control like Git?', 'To track changes to your code and collaborate with others.', JSON_ARRAY('To write code faster.', 'To deploy your website to a server.', 'To track changes to your code and collaborate with others.', 'To automatically generate a portfolio.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 5), 'What is the best practice for naming files and folders in a web project?', 'Use all lowercase letters with hyphens to separate words.', JSON_ARRAY('Use spaces in file names.', 'Use capital letters for all file names.', 'Use all lowercase letters with hyphens to separate words.', 'Use numbers for all file names.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'webdev' AND module_order = 5), 'What is a README file used for in a project?', 'To provide instructions and information about the project.', JSON_ARRAY('To hide your code.', 'To provide instructions and information about the project.', 'To list all the bugs.', 'To store confidential information.'));

-- Data Science for Beginners Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 1), 'What is data science?', 'A field that uses scientific methods, processes, algorithms, and systems to extract knowledge and insights from data.', JSON_ARRAY('A field for building websites.', 'A field that uses scientific methods, processes, algorithms, and systems to extract knowledge and insights from data.', 'A field for analyzing financial markets.', 'A field for creating mobile applications.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 1), 'What does a "dataset" refer to?', 'A collection of data.', JSON_ARRAY('A single piece of data.', 'A type of computer virus.', 'A collection of data.', 'A programming language.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 1), 'Which of these is a common type of data?', 'Numerical', JSON_ARRAY('Emotional', 'Social', 'Numerical', 'Physical'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 1), 'What is the first step in the data science process?', 'Problem formulation', JSON_ARRAY('Problem formulation', 'Data cleaning', 'Model building', 'Data visualization'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 1), 'Why is data cleaning important?', 'To remove or correct inaccurate, incomplete, or irrelevant data.', JSON_ARRAY('To make data more appealing.', 'To organize data alphabetically.', 'To remove or correct inaccurate, incomplete, or irrelevant data.', 'To find more data.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 2), 'What is a "mean"?', 'The average of a set of numbers.', JSON_ARRAY('The middle value in a dataset.', 'The most frequent number in a dataset.', 'The average of a set of numbers.', 'The difference between the highest and lowest values.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 2), 'What is "probability"?', 'A measure of the likelihood that an event will occur.', JSON_ARRAY('A type of data visualization.', 'A programming concept.', 'A measure of the likelihood that an event will occur.', 'A statistical programming tool.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 2), 'What is a "variable"?', 'A characteristic that can be measured or counted.', JSON_ARRAY('A type of algorithm.', 'A characteristic that can be measured or counted.', 'A name given to a dataset.', 'A graph used for plotting data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 2), 'What does "descriptive statistics" do?', 'Summarizes and organizes data.', JSON_ARRAY('Predicts future outcomes.', 'Summarizes and organizes data.', 'Tests hypotheses.', 'Builds machine learning models.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 2), 'What is the "median"?', 'The middle value in a sorted dataset.', JSON_ARRAY('The average of a set of numbers.', 'The highest value in a dataset.', 'The middle value in a sorted dataset.', 'The range of a dataset.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 3), 'What is "machine learning"?', 'A subset of AI that allows machines to learn from data without explicit programming.', JSON_ARRAY('A way to build robots.', 'A field of software engineering.', 'A subset of AI that allows machines to learn from data without explicit programming.', 'A type of database.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 3), 'Which of these is a common type of machine learning?', 'Supervised Learning', JSON_ARRAY('Organic Learning', 'Manual Learning', 'Supervised Learning', 'Theoretical Learning'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 3), 'What is a "training dataset"?', 'The data used to teach a machine learning model.', JSON_ARRAY('The final result of a model.', 'The data used to teach a machine learning model.', 'The data used for visualization.', 'The data used for testing.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 3), 'What is "prediction"?', 'The output of a machine learning model after it has been trained.', JSON_ARRAY('The input data for a model.', 'The output of a machine learning model after it has been trained.', 'The process of cleaning data.', 'The process of visualizing data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 3), 'What does a "model" refer to in machine learning?', 'A program or algorithm that has been trained to recognize patterns.', JSON_ARRAY('A famous person.', 'A program or algorithm that has been trained to recognize patterns.', 'A type of data structure.', 'A type of chart.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 4), 'What is the purpose of data visualization?', 'To communicate information clearly and efficiently through graphical means.', JSON_ARRAY('To hide data.', 'To make data more complex.', 'To communicate information clearly and efficiently through graphical means.', 'To store data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 4), 'Which type of chart is best for showing trends over time?', 'Line chart', JSON_ARRAY('Bar chart', 'Pie chart', 'Line chart', 'Scatter plot'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 4), 'What does a "pie chart" typically show?', 'Proportions of a whole.', JSON_ARRAY('Trends over time.', 'Correlations between two variables.', 'Proportions of a whole.', 'Distribution of data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 4), 'What is a "histogram"?', 'A graph that shows the distribution of a single variable.', JSON_ARRAY('A graph that shows relationships between variables.', 'A graph that shows the distribution of a single variable.', 'A type of data table.', 'A programming function.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 4), 'Why are colors important in data visualization?', 'To highlight key information and make the chart easier to understand.', JSON_ARRAY('To make the chart look pretty.', 'To make the chart more complicated.', 'To highlight key information and make the chart easier to understand.', 'To use up more computer memory.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 5), 'What is the goal of a data project?', 'To solve a specific business or research problem using data.', JSON_ARRAY('To create a new programming language.', 'To solve a specific business or research problem using data.', 'To write a book about data.', 'To collect as much data as possible.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 5), 'What is the purpose of a "Jupyter Notebook"?', 'To create and share documents that contain live code, equations, visualizations, and narrative text.', JSON_ARRAY('To build a website.', 'To send emails.', 'To create and share documents that contain live code, equations, visualizations, and narrative text.', 'To run a social media account.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 5), 'Why is storytelling important in a data project?', 'To present insights in a compelling and understandable way to a non-technical audience.', JSON_ARRAY('To make the project longer.', 'To present insights in a compelling and understandable way to a non-technical audience.', 'To confuse the audience.', 'To impress other data scientists.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 5), 'What is "feature engineering"?', 'The process of using domain knowledge to create new features from raw data.', JSON_ARRAY('A type of software bug.', 'The process of using domain knowledge to create new features from raw data.', 'The process of designing user interfaces.', 'A way to clean data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'datascience' AND module_order = 5), 'What does "model deployment" mean?', 'Putting a trained machine learning model into a production environment.', JSON_ARRAY('Putting a trained machine learning model into a production environment.', 'Starting a new machine learning project.', 'Training a new model.', 'Deleting an old model.'));

-- Digital Marketing Mastery Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 1), 'What is the main goal of digital marketing?', 'To promote products or services using digital channels.', JSON_ARRAY('To sell products in a physical store.', 'To create television ads.', 'To promote products or services using digital channels.', 'To print flyers and brochures.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 1), 'Which of the following is a digital marketing channel?', 'Email marketing', JSON_ARRAY('Radio advertising', 'Email marketing', 'Newspaper ads', 'Billboard advertising'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 1), 'What is a "target audience"?', 'The specific group of people a marketing campaign is aimed at.', JSON_ARRAY('All people in a country.', 'The specific group of people a marketing campaign is aimed at.', 'A list of competitors.', 'A type of search engine.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 1), 'What does "ROI" stand for?', 'Return on Investment', JSON_ARRAY('Return on Interest', 'Revenue of Internet', 'Rate of Income', 'Return on Investment'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 1), 'Which of these is a key benefit of digital marketing?', 'It allows for precise audience targeting.', JSON_ARRAY('It is a traditional form of marketing.', 'It is always cheaper than traditional marketing.', 'It allows for precise audience targeting.', 'It is not measurable.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 2), 'What does SEO stand for?', 'Search Engine Optimization', JSON_ARRAY('Social Engine Optimization', 'Site Engine Optimization', 'Search Engine Organization', 'Search Engine Optimization'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 2), 'What is a "keyword" in SEO?', 'A word or phrase that a user types into a search engine.', JSON_ARRAY('A special code for a website.', 'A word or phrase that a user types into a search engine.', 'A type of advertisement.', 'A website’s title.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 2), 'What is "on-page SEO"?', 'Optimizing elements on your own website, like content and title tags.', JSON_ARRAY('Optimizing a website for mobile devices.', 'Optimizing elements on your own website, like content and title tags.', 'Optimizing links from other websites.', 'Optimizing a website’s speed.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 2), 'What is a "backlink"?', 'An incoming hyperlink from one web page to another website.', JSON_ARRAY('A link that goes to a different page on the same website.', 'A link that is not working.', 'An incoming hyperlink from one web page to another website.', 'A link to a social media page.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 2), 'What is the purpose of an "alt text" on an image?', 'To describe the image to search engines and visually impaired users.', JSON_ARRAY('To add a watermark to an image.', 'To describe the image to search engines and visually impaired users.', 'To make the image load faster.', 'To add a caption to an image.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 3), 'Which of these is a key benefit of social media marketing?', 'Building a community and brand loyalty.', JSON_ARRAY('It is a form of traditional advertising.', 'It is only for B2B businesses.', 'Building a community and brand loyalty.', 'It requires no strategy.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 3), 'What is "engagement" on social media?', 'Likes, comments, shares, and other interactions with a post.', JSON_ARRAY('The number of followers a page has.', 'Likes, comments, shares, and other interactions with a post.', 'The time a user spends on the platform.', 'The number of ads shown to a user.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 3), 'What is an "influencer"?', 'A person with a large following who can influence the purchasing decisions of their audience.', JSON_ARRAY('A famous celebrity.', 'A person with a large following who can influence the purchasing decisions of their audience.', 'A social media algorithm.', 'A type of marketing agency.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 3), 'What is a "call to action" (CTA)?', 'A prompt for a user to take a specific action, like "Shop Now" or "Learn More".', JSON_ARRAY('A social media post that goes viral.', 'A prompt for a user to take a specific action, like "Shop Now" or "Learn More".', 'A type of marketing report.', 'A social media app.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 3), 'Why is it important to have a consistent brand voice on social media?', 'To build a recognizable and trusted brand identity.', JSON_ARRAY('To appeal to all demographics.', 'To build a recognizable and trusted brand identity.', 'To make posts longer.', 'To get more followers.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 4), 'What is content marketing?', 'Creating and distributing valuable, relevant, and consistent content to attract and retain a defined audience.', JSON_ARRAY('Creating paid ads for social media.', 'Writing short articles for a blog.', 'Creating and distributing valuable, relevant, and consistent content to attract and retain a defined audience.', 'Sending spam emails.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 4), 'Which of these is a common type of content?', 'Blog post', JSON_ARRAY('Excel spreadsheet', 'Text message', 'Blog post', 'A phone call'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 4), 'What is a "persona" in content marketing?', 'A fictional representation of your ideal customer.', JSON_ARRAY('A celebrity endorsement.', 'A type of content management system.', 'A fictional representation of your ideal customer.', 'A marketing budget.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 4), 'What is the purpose of a "content calendar"?', 'To plan and organize your content creation and publication schedule.', JSON_ARRAY('To track your budget.', 'To plan and organize your content creation and publication schedule.', 'To monitor your competitors.', 'To measure social media engagement.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 4), 'Why is video content popular in digital marketing?', 'It is highly engaging and can convey information quickly.', JSON_ARRAY('It is the most expensive to produce.', 'It is highly engaging and can convey information quickly.', 'It requires no strategy.', 'It can only be used on YouTube.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 5), 'What is the purpose of marketing analytics?', 'To measure the performance of a marketing campaign.', JSON_ARRAY('To build a website.', 'To measure the performance of a marketing campaign.', 'To write content.', 'To create a budget.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 5), 'What is a "conversion" in digital marketing?', 'When a user completes a desired action, like making a purchase or filling out a form.', JSON_ARRAY('When a visitor leaves a website.', 'When a user completes a desired action, like making a purchase or filling out a form.', 'When a user clicks on an ad.', 'When a user scrolls down a page.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 5), 'What does "bounce rate" measure?', 'The percentage of visitors who leave a website after viewing only one page.', JSON_ARRAY('The number of social media followers.', 'The time a user spends on a website.', 'The percentage of visitors who leave a website after viewing only one page.', 'The number of clicks on an ad.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 5), 'Which tool is commonly used for website analytics?', 'Google Analytics', JSON_ARRAY('Microsoft Word', 'Google Analytics', 'Adobe Photoshop', 'Canva'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'marketing' AND module_order = 5), 'Why is it important to track key performance indicators (KPIs)?', 'To evaluate the success of a marketing campaign and make data-driven decisions.', JSON_ARRAY('To make the campaign more expensive.', 'To evaluate the success of a marketing campaign and make data-driven decisions.', 'To make the project longer.', 'To get more followers.'));


-- Python for Everybody Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 1), 'What is a variable?', 'A container for storing data values.', JSON_ARRAY('A container for storing data values.', 'A type of function.', 'A specific number.', 'A command to print text.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 1), 'How do you print "Hello, World!" in Python?', 'print("Hello, World!")', JSON_ARRAY('echo "Hello, World!"', 'console.log("Hello, World!")', 'print("Hello, World!")', 'display "Hello, World!"'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 1), 'What is an "integer"?', 'A whole number (positive or negative).', JSON_ARRAY('A word or a sentence.', 'A number with a decimal point.', 'A whole number (positive or negative).', 'A type of list.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 1), 'How do you comment a single line in Python?', '# This is a comment', JSON_ARRAY('// This is a comment', '/* This is a comment */', '# This is a comment', '-- This is a comment'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 1), 'What is an "if" statement used for?', 'To perform an action only if a certain condition is true.', JSON_ARRAY('To repeat a block of code.', 'To define a variable.', 'To perform an action only if a certain condition is true.', 'To store a list of items.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 2), 'What is a "list" in Python?', 'An ordered, mutable collection of items.', JSON_ARRAY('An unordered collection of unique items.', 'An ordered, mutable collection of items.', 'A key-value pair.', 'A fixed-size array.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 2), 'What is the key difference between a list and a "tuple"?', 'Lists are mutable, while tuples are immutable.', JSON_ARRAY('Lists can hold different data types, while tuples cannot.', 'Lists are faster than tuples.', 'Lists are mutable, while tuples are immutable.', 'Tuples can only hold numbers.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 2), 'What is a "dictionary"?', 'An unordered collection of key-value pairs.', JSON_ARRAY('An ordered list of items.', 'An unordered collection of key-value pairs.', 'A fixed-size collection of items.', 'A list with unique items.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 2), 'How do you add an item to a list?', 'Using the .append() method.', JSON_ARRAY('Using the .add() method.', 'Using the .new() method.', 'Using the .insert() method.', 'Using the .append() method.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 2), 'What is a "set"?', 'An unordered collection with no duplicate elements.', JSON_ARRAY('An ordered collection with duplicate elements.', 'An unordered collection with no duplicate elements.', 'A fixed-size ordered collection.', 'A key-value pair.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 3), 'What is a function?', 'A block of reusable code that performs a specific task.', JSON_ARRAY('A way to store a single value.', 'A block of reusable code that performs a specific task.', 'A type of data structure.', 'A way to comment on code.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 3), 'How do you define a function in Python?', 'Using the def keyword.', JSON_ARRAY('Using the function keyword.', 'Using the define keyword.', 'Using the def keyword.', 'Using the func keyword.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 3), 'What does the "return" statement do?', 'It exits the function and passes a value back to the caller.', JSON_ARRAY('It prints a value to the console.', 'It exits the function and passes a value back to the caller.', 'It defines a variable.', 'It starts a new loop.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 3), 'What is a "parameter"?', 'A variable listed inside the parentheses in the function definition.', JSON_ARRAY('A value passed to the function when it is called.', 'A variable listed inside the parentheses in the function definition.', 'A type of loop.', 'A comment in the code.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 3), 'What is a "docstring"?', 'A string literal used to document a function, module, or class.', JSON_ARRAY('A type of variable.', 'A type of loop.', 'A string literal used to document a function, module, or class.', 'A function name.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 4), 'What is a "class"?', 'A blueprint for creating objects.', JSON_ARRAY('A type of function.', 'A single piece of data.', 'A blueprint for creating objects.', 'A way to comment code.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 4), 'What is an "object"?', 'An instance of a class.', JSON_ARRAY('A type of variable.', 'An instance of a class.', 'A specific data structure.', 'A way to print to the console.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 4), 'What is "inheritance"?', 'A mechanism that allows a new class to inherit properties and methods from an existing class.', JSON_ARRAY('A way to store a list of items.', 'A way to print text.', 'A mechanism that allows a new class to inherit properties and methods from an existing class.', 'A way to create a function.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 4), 'What is "encapsulation"?', 'The bundling of data and the methods that operate on that data into a single unit.', JSON_ARRAY('The process of hiding data from other parts of the program.', 'The process of creating a new function.', 'The bundling of data and the methods that operate on that data into a single unit.', 'A way to create a loop.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 4), 'What does the `__init__` method do?', 'It is a special method used to initialize an object.', JSON_ARRAY('It prints a message to the console.', 'It is a special method used to initialize an object.', 'It is used to delete an object.', 'It is used to copy an object.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 5), 'What is a "library" in Python?', 'A collection of reusable code that can be imported and used.', JSON_ARRAY('A type of data structure.', 'A collection of reusable code that can be imported and used.', 'A specific function.', 'A type of variable.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 5), 'What is a "framework"?', 'A larger, more structured collection of libraries and tools that provides a foundation for building applications.', JSON_ARRAY('A single function.', 'A type of data structure.', 'A larger, more structured collection of libraries and tools that provides a foundation for building applications.', 'A single piece of code.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 5), 'How do you install a library?', 'Using the pip command.', JSON_ARRAY('Using the install command.', 'Using the include command.', 'Using the pip command.', 'Using the get command.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 5), 'What is "NumPy" used for?', 'Scientific computing and working with arrays.', JSON_ARRAY('Building websites.', 'Scientific computing and working with arrays.', 'Creating games.', 'Analyzing social media data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'python' AND module_order = 5), 'What is "Pandas" primarily used for?', 'Data manipulation and analysis.', JSON_ARRAY('Building websites.', 'Creating games.', 'Data manipulation and analysis.', 'Creating charts.'));

-- Graphic Design Essentials Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 1), 'What is "balance" in design?', 'The visual weight of elements on a page.', JSON_ARRAY('The use of bright colors.', 'The placement of text.', 'The visual weight of elements on a page.', 'The size of an image.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 1), 'What is the purpose of "contrast"?', 'To make elements stand out and create visual interest.', JSON_ARRAY('To make elements blend together.', 'To make elements stand out and create visual interest.', 'To make a design monochromatic.', 'To add more details.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 1), 'What is a "grid" in design?', 'A series of intersecting vertical and horizontal lines used to organize a design.', JSON_ARRAY('A type of font.', 'A series of intersecting vertical and horizontal lines used to organize a design.', 'A tool for drawing lines.', 'A type of color palette.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 1), 'What does "white space" refer to?', 'The empty area around and between design elements.', JSON_ARRAY('The use of only white colors.', 'The empty area around and between design elements.', 'The text on a page.', 'A type of image format.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 1), 'What is "hierarchy" in design?', 'The arrangement of elements to show their order of importance.', JSON_ARRAY('The use of a single font.', 'The arrangement of elements to show their order of importance.', 'The alignment of objects.', 'The color of an object.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 2), 'What is a "serif" font?', 'A font with small decorative lines at the end of some strokes.', JSON_ARRAY('A font with no decorative lines.', 'A font with small decorative lines at the end of some strokes.', 'A font that is handwritten.', 'A font used for headlines.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 2), 'What is a "color palette"?', 'A pre-selected set of colors used in a design.', JSON_ARRAY('A tool for drawing.', 'A pre-selected set of colors used in a design.', 'A type of font.', 'A color from the rainbow.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 2), 'What is the difference between CMYK and RGB color models?', 'CMYK is for print, and RGB is for digital screens.', JSON_ARRAY('CMYK is for digital, and RGB is for print.', 'CMYK is for print, and RGB is for digital screens.', 'CMYK uses more colors than RGB.', 'RGB is only used for black and white designs.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 2), 'What is "kerning"?', 'The space between two individual characters.', JSON_ARRAY('The space between lines of text.', 'The space between words.', 'The space between two individual characters.', 'The thickness of a font.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 2), 'What is a "monochromatic" color scheme?', 'Using different shades and tones of a single color.', JSON_ARRAY('Using a wide variety of colors.', 'Using only black and white.', 'Using different shades and tones of a single color.', 'Using complementary colors.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 3), 'Which Adobe tool is best for creating vector graphics like logos?', 'Illustrator', JSON_ARRAY('Photoshop', 'InDesign', 'Illustrator', 'Premiere Pro'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 3), 'Which Adobe tool is best for photo editing and manipulation?', 'Photoshop', JSON_ARRAY('Illustrator', 'Photoshop', 'XD', 'Lightroom'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 3), 'What is the primary use of Adobe InDesign?', 'Creating layouts for print and digital publications.', JSON_ARRAY('Creating vector logos.', 'Editing videos.', 'Creating layouts for print and digital publications.', 'Editing photos.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 3), 'What is a "layer" in Photoshop?', 'A transparent sheet where you can place an image or object.', JSON_ARRAY('A tool for drawing lines.', 'A transparent sheet where you can place an image or object.', 'A type of filter.', 'A color palette.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 3), 'Which tool would you use to create a website mockup?', 'Adobe XD', JSON_ARRAY('Adobe Premiere Pro', 'Adobe Animate', 'Adobe InDesign', 'Adobe XD'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 4), 'What is a "brand identity"?', 'The visible elements of a brand, such as color, design, and logo.', JSON_ARRAY('The company history.', 'The company mission statement.', 'The visible elements of a brand, such as color, design, and logo.', 'The company marketing strategy.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 4), 'What is a "logo"?', 'A symbol or design that identifies a brand.', JSON_ARRAY('The company’s website.', 'A symbol or design that identifies a brand.', 'The company’s product.', 'A type of font.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 4), 'What is a "style guide"?', 'A set of rules for the use of a brand visual elements.', JSON_ARRAY('A guide for writing a resume.', 'A guide for editing photos.', 'A set of rules for the use of a brand visual elements.', 'A guide for creating a new design.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 4), 'Why is a brand story important?', 'It helps customers connect with the brand on an emotional level.', JSON_ARRAY('It is a legal requirement.', 'It helps customers connect with the brand on an emotional level.', 'It is only for large companies.', 'It is not important.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 4), 'What is a "brandmark"?', 'A logo that consists of a symbol or icon without a name.', JSON_ARRAY('A logo that consists of a name without a symbol.', 'A logo that consists of a symbol or icon without a name.', 'A type of marketing campaign.', 'A type of font.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 5), 'What is the purpose of a design portfolio?', 'To showcase your best work and demonstrate your skills to potential clients or employers.', JSON_ARRAY('To store all of your design files.', 'To showcase your best work and demonstrate your skills to potential clients or employers.', 'To sell your designs online.', 'To get feedback from other designers.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 5), 'What is a "mockup"?', 'A realistic visual representation of a design, often in its intended environment.', JSON_ARRAY('A rough sketch of a design.', 'A realistic visual representation of a design, often in its intended environment.', 'A list of design principles.', 'A type of graphic design software.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 5), 'What is a "case study" in a portfolio?', 'A detailed walkthrough of a design project, explaining the problem, process, and solution.', JSON_ARRAY('A list of all the software used in a project.', 'A detailed walkthrough of a design project, explaining the problem, process, and solution.', 'A list of all the clients you have worked with.', 'A summary of your design skills.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 5), 'Why is it important to get feedback on your portfolio?', 'To identify areas for improvement and ensure your work is presented effectively.', JSON_ARRAY('To get a grade on your work.', 'To identify areas for improvement and ensure your work is presented effectively.', 'To make the portfolio larger.', 'To make the portfolio more colorful.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'graphicdesign' AND module_order = 5), 'What is the best way to present a portfolio?', 'As a clean, easy-to-navigate website with clear descriptions.', JSON_ARRAY('As a large PDF file.', 'As a series of images on a social media page.', 'As a clean, easy-to-navigate website with clear descriptions.', 'As a set of printed documents.'));

-- Mobile App Development Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 1), 'What is the most popular operating system for mobile devices?', 'Android', JSON_ARRAY('Windows', 'Linux', 'Android', 'iOS'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 1), 'What is a key difference between Android and iOS?', 'Android is open source, while iOS is a closed ecosystem.', JSON_ARRAY('Android is only for phones, and iOS is for tablets.', 'Android is open source, while iOS is a closed ecosystem.', 'Android is faster than iOS.', 'iOS has more apps than Android.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 1), 'What is an "APK" file?', 'The file format used by Android for the distribution and installation of mobile apps.', JSON_ARRAY('A type of iOS app.', 'A programming language.', 'A database file.', 'The file format used by Android for the distribution and installation of mobile apps.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 1), 'What is the App Store?', 'The official digital distribution platform for iOS applications.', JSON_ARRAY('A physical store for buying phones.', 'The official digital distribution platform for iOS applications.', 'A place to buy music.', 'A place to download PC software.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 1), 'What is a "widget" on a mobile device?', 'A small application that can be embedded on the home screen.', JSON_ARRAY('A type of app icon.', 'A small application that can be embedded on the home screen.', 'A notification sound.', 'A type of mobile device.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 2), 'What is the main goal of good mobile UI design?', 'To create an app that is visually appealing and easy to navigate.', JSON_ARRAY('To use a lot of bright colors.', 'To make the app very complex.', 'To create an app that is visually appealing and easy to navigate.', 'To add as many features as possible.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 2), 'What is a "wireframe"?', 'A basic visual guide used to lay out the app structure and content.', JSON_ARRAY('A high-fidelity design.', 'A basic visual guide used to lay out the app structure and content.', 'A type of code.', 'A finished app.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 2), 'What is "usability testing"?', 'The process of testing an app with real users to see how easy it is to use.', JSON_ARRAY('The process of testing a phone’s battery life.', 'The process of testing an app with real users to see how easy it is to use.', 'The process of testing an app’s speed.', 'The process of testing a phone’s camera.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 2), 'What is a "prototype"?', 'An interactive model of the app that simulates its functionality.', JSON_ARRAY('A final, ready-to-publish app.', 'An interactive model of the app that simulates its functionality.', 'A type of data file.', 'A type of design software.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 2), 'Why is it important to design for "finger size"?', 'Because users interact with mobile apps using their fingers, so buttons and links need to be large enough.', JSON_ARRAY('Because it is a rule in mobile development.', 'Because it makes the app load faster.', 'Because users interact with mobile apps using their fingers, so buttons and links need to be large enough.', 'Because it makes the app look more modern.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 3), 'What is a "native app"?', 'An app built specifically for a single platform (e.g., iOS or Android) using the native language.', JSON_ARRAY('An app that runs on both iOS and Android.', 'An app that is built using a web browser.', 'An app built specifically for a single platform (e.g., iOS or Android) using the native language.', 'An app that only works offline.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 3), 'Which language is used for native iOS app development?', 'Swift', JSON_ARRAY('Java', 'C#', 'Swift', 'Python'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 3), 'What is a "hybrid app"?', 'An app that is developed using web technologies like HTML, CSS, and JavaScript, and then packaged into a native container.', JSON_ARRAY('An app that is only for desktop devices.', 'An app that is developed using web technologies like HTML, CSS, and JavaScript, and then packaged into a native container.', 'An app that requires a special device.', 'An app that only works with a keyboard.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 3), 'What is a key benefit of building a native app?', 'Access to the full features of the device, such as the camera and GPS.', JSON_ARRAY('Faster development time.', 'Access to the full features of the device, such as the camera and GPS.', 'Cheaper to build.', 'Cross-platform compatibility.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 3), 'Which framework is a popular choice for building hybrid apps?', 'React Native', JSON_ARRAY('Swift', 'Java', 'React Native', 'Kotlin'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 4), 'What is the purpose of app testing?', 'To find and fix bugs and ensure the app works as intended.', JSON_ARRAY('To make the app larger.', 'To find and fix bugs and ensure the app works as intended.', 'To make the app more expensive.', 'To confuse the user.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 4), 'What is "unit testing"?', 'Testing individual, isolated units of code.', JSON_ARRAY('Testing the entire app at once.', 'Testing the app on multiple devices.', 'Testing individual, isolated units of code.', 'Testing the app’s speed.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 4), 'What is "beta testing"?', 'Testing a nearly-finished app with a small group of real users to find remaining bugs.', JSON_ARRAY('Testing an app’s logo.', 'Testing a nearly-finished app with a small group of real users to find remaining bugs.', 'Testing an app’s colors.', 'Testing an app’s marketing.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 4), 'What does "QA" stand for?', 'Quality Assurance', JSON_ARRAY('Quick Application', 'Quality Assessment', 'Quality Assurance', 'Question Answer'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 4), 'What is a "bug report"?', 'A document that describes a bug found in the app, including steps to reproduce it.', JSON_ARRAY('A report on a company financial performance.', 'A document that describes a bug found in the app, including steps to reproduce it.', 'A list of app features.', 'A user comment on an app store.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 5), 'What is the first step to publishing an app to the App Store or Google Play Store?', 'Creating a developer account.', JSON_ARRAY('Making the app free.', 'Creating a developer account.', 'Testing the app again.', 'Changing the app’s icon.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 5), 'What is an "app description"?', 'The text that explains what the app is and what it does.', JSON_ARRAY('A type of ad.', 'The text that explains what the app is and what it does.', 'A type of code.', 'A list of app features.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 5), 'What are "app store screenshots"?', 'Images that show what the app looks like and its key features.', JSON_ARRAY('Images that show the app’s developer.', 'Images that show the app’s code.', 'Images that show what the app looks like and its key features.', 'Images that show the phone’s home screen.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 5), 'Why is it important to respond to user reviews?', 'To show that you care about user feedback and to build a positive reputation.', JSON_ARRAY('To get more downloads.', 'To show that you care about user feedback and to build a positive reputation.', 'To make the app more popular.', 'To make the app more expensive.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'mobiledev' AND module_order = 5), 'What is an "app update"?', 'A new version of the app that includes bug fixes or new features.', JSON_ARRAY('A new phone.', 'A new version of the app that includes bug fixes or new features.', 'A new app.', 'A type of game.'));

-- AI and Machine Learning Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 1), 'What does AI stand for?', 'Artificial Intelligence', JSON_ARRAY('Advanced Information', 'Artificial Information', 'Automated Intelligence', 'Artificial Intelligence'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 1), 'What is the goal of AI?', 'To create systems that can think and act like humans.', JSON_ARRAY('To replace all human jobs.', 'To make computers faster.', 'To create systems that can think and act like humans.', 'To build robots that can walk.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 1), 'Which of these is a type of AI?', 'Narrow AI', JSON_ARRAY('Broad AI', 'Wide AI', 'Narrow AI', 'Deep AI'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 1), 'What is a "neural network"?', 'A computational model inspired by the human brain.', JSON_ARRAY('A network of computers.', 'A network of robots.', 'A computational model inspired by the human brain.', 'A type of database.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 1), 'What is a "chatbot"?', 'An AI program that simulates human conversation through text or voice.', JSON_ARRAY('A type of computer virus.', 'An AI program that simulates human conversation through text or voice.', 'A type of search engine.', 'A type of data analysis.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 2), 'What is a "classification" algorithm used for?', 'To categorize data into a known set of classes.', JSON_ARRAY('To predict a numerical value.', 'To group similar data points.', 'To categorize data into a known set of classes.', 'To generate new data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 2), 'What is a "regression" algorithm used for?', 'To predict a continuous numerical value.', JSON_ARRAY('To categorize data into classes.', 'To group similar data points.', 'To predict a continuous numerical value.', 'To create visualizations.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 2), 'What is a "clustering" algorithm used for?', 'To group similar data points together without a predetermined label.', JSON_ARRAY('To predict a numerical value.', 'To group similar data points together without a predetermined label.', 'To categorize data into classes.', 'To generate new data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 2), 'What is a "decision tree"?', 'A flowchart-like structure used to make predictions based on a series of decisions.', JSON_ARRAY('A type of neural network.', 'A flowchart-like structure used to make predictions based on a series of decisions.', 'A type of data visualization.', 'A type of database.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 2), 'What is "overfitting"?', 'When a model learns the training data too well, failing to generalize to new, unseen data.', JSON_ARRAY('When a model is too simple.', 'When a model learns the training data too well, failing to generalize to new, unseen data.', 'When a model is too fast.', 'When a model is too slow.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 3), 'What is a "neuron" in a neural network?', 'A basic computational unit that takes input, applies a function, and produces an output.', JSON_ARRAY('A type of computer chip.', 'A basic computational unit that takes input, applies a function, and produces an output.', 'A type of data.', 'A type of program.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 3), 'What is a "layer" in a neural network?', 'A group of interconnected neurons.', JSON_ARRAY('A type of computer.', 'A group of interconnected neurons.', 'A type of data.', 'A type of algorithm.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 3), 'What is the purpose of an "activation function"?', 'To determine whether a neuron should be activated.', JSON_ARRAY('To determine the speed of the network.', 'To determine the size of the network.', 'To determine whether a neuron should be activated.', 'To determine the color of a visualization.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 3), 'What is "backpropagation"?', 'An algorithm used to train neural networks by adjusting the weights to minimize error.', JSON_ARRAY('An algorithm used to create new data.', 'An algorithm used to train neural networks by adjusting the weights to minimize error.', 'An algorithm used to make a model faster.', 'An algorithm used to visualize data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 3), 'What is "deep learning"?', 'A subset of machine learning that uses multi-layered neural networks.', JSON_ARRAY('A type of simple algorithm.', 'A subset of machine learning that uses multi-layered neural networks.', 'A way to analyze big data.', 'A type of programming.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 4), 'What is "computer vision"?', 'A field of AI that enables computers to "see" and interpret visual data.', JSON_ARRAY('A field that allows computers to hear.', 'A field of AI that enables computers to "see" and interpret visual data.', 'A field that allows computers to talk.', 'A field that allows computers to write.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 4), 'What is "image classification"?', 'The task of assigning a label or category to an entire image.', JSON_ARRAY('The task of finding objects in an image.', 'The task of assigning a label or category to an entire image.', 'The task of editing an image.', 'The task of creating a new image.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 4), 'What is "object detection"?', 'The task of identifying and locating multiple objects within an image or video.', JSON_ARRAY('The task of assigning a label to an entire image.', 'The task of identifying and locating multiple objects within an image or video.', 'The task of editing an image.', 'The task of creating a new image.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 4), 'What is "image segmentation"?', 'The task of partitioning an image into multiple segments to simplify its representation.', JSON_ARRAY('The task of categorizing images.', 'The task of identifying objects in an image.', 'The task of partitioning an image into multiple segments to simplify its representation.', 'The task of creating a new image.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 4), 'What is "face recognition"?', 'A technology that identifies or verifies a person from a digital image or video frame.', JSON_ARRAY('A type of security camera.', 'A technology that identifies or verifies a person from a digital image or video frame.', 'A type of data analysis.', 'A type of computer chip.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 5), 'What is "AI bias"?', 'When an AI system produces results that are systematically prejudiced.', JSON_ARRAY('When an AI system is too slow.', 'When an AI system produces results that are systematically prejudiced.', 'When an AI system is too fast.', 'When an AI system has too much data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 5), 'What is "data privacy" in AI?', 'Protecting personal and sensitive data from unauthorized access.', JSON_ARRAY('The process of collecting data.', 'The process of sharing data.', 'Protecting personal and sensitive data from unauthorized access.', 'The process of analyzing data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 5), 'Why is "accountability" important in AI?', 'To ensure someone is responsible for the decisions and actions of an AI system.', JSON_ARRAY('To make the AI system more complex.', 'To make the AI system more expensive.', 'To ensure someone is responsible for the decisions and actions of an AI system.', 'To make the AI system more popular.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 5), 'What is a key ethical concern with autonomous weapons?', 'The lack of human control and decision-making.', JSON_ARRAY('They are too expensive.', 'They are too fast.', 'The lack of human control and decision-making.', 'They are not intelligent enough.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'ai' AND module_order = 5), 'What is "explainable AI"?', 'The ability to understand how and why an AI model made a particular decision.', JSON_ARRAY('The ability to make an AI model more accurate.', 'The ability to make an AI model faster.', 'The ability to understand how and why an AI model made a particular decision.', 'The ability to make an AI model more complex.'));

-- Cybersecurity Fundamentals Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 1), 'What does "confidentiality" mean in cybersecurity?', 'Ensuring that data is only accessible to authorized individuals.', JSON_ARRAY('Ensuring data is always available.', 'Ensuring data is not changed.', 'Ensuring that data is only accessible to authorized individuals.', 'Ensuring data can be accessed quickly.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 1), 'What does "integrity" mean in cybersecurity?', 'Ensuring that data has not been altered or tampered with.', JSON_ARRAY('Ensuring data is only available to authorized users.', 'Ensuring that data has not been altered or tampered with.', 'Ensuring data is available at all times.', 'Ensuring data is easily accessible.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 1), 'What does "availability" mean in cybersecurity?', 'Ensuring that systems and data are accessible to authorized users when needed.', JSON_ARRAY('Ensuring that systems and data are only accessible to a select few.', 'Ensuring that systems and data are not changed.', 'Ensuring that systems and data are accessible to authorized users when needed.', 'Ensuring that systems and data are easily copied.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 1), 'What is a "threat"?', 'A potential danger that might exploit a vulnerability.', JSON_ARRAY('A type of computer.', 'A type of firewall.', 'A potential danger that might exploit a vulnerability.', 'A type of anti-virus software.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 1), 'What is a "vulnerability"?', 'A weakness that a threat can exploit.', JSON_ARRAY('A type of firewall.', 'A type of computer.', 'A weakness that a threat can exploit.', 'A type of anti-virus software.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 2), 'What does a "firewall" do?', 'It filters network traffic and blocks unauthorized access.', JSON_ARRAY('It speeds up a computer.', 'It filters network traffic and blocks unauthorized access.', 'It scans for viruses.', 'It backs up data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 2), 'What is a "router"?', 'A device that forwards data packets between computer networks.', JSON_ARRAY('A type of computer virus.', 'A device that forwards data packets between computer networks.', 'A type of software.', 'A type of data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 2), 'What is "phishing"?', 'A type of social engineering attack where an attacker sends a fraudulent message to trick a person.', JSON_ARRAY('A type of computer virus.', 'A type of social engineering attack where an attacker sends a fraudulent message to trick a person.', 'A type of data analysis.', 'A type of email.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 2), 'What is a "VPN"?', 'A Virtual Private Network, which creates a secure, encrypted connection over a public network.', JSON_ARRAY('A Very Personal Network.', 'A Virtual Public Network.', 'A Virtual Private Network, which creates a secure, encrypted connection over a public network.', 'A Very Popular Network.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 2), 'What is the purpose of a "strong password"?', 'To protect an account from unauthorized access.', JSON_ARRAY('To make it harder to remember.', 'To protect an account from unauthorized access.', 'To make it longer.', 'To make it easier to type.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 3), 'What is "encryption"?', 'The process of converting data into a code to prevent unauthorized access.', JSON_ARRAY('The process of changing data.', 'The process of converting data into a code to prevent unauthorized access.', 'The process of backing up data.', 'The process of deleting data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 3), 'What is a "key" in cryptography?', 'A piece of information that determines the functional output of an encryption algorithm.', JSON_ARRAY('A type of password.', 'A piece of information that determines the functional output of an encryption algorithm.', 'A type of lock.', 'A type of algorithm.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 3), 'What is "symmetric encryption"?', 'Using the same key for both encryption and decryption.', JSON_ARRAY('Using a different key for encryption and decryption.', 'Using a public key for encryption.', 'Using the same key for both encryption and decryption.', 'Using a private key for decryption.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 3), 'What is a "digital signature"?', 'A cryptographic mechanism that verifies the authenticity and integrity of a message or document.', JSON_ARRAY('A way to sign a document.', 'A cryptographic mechanism that verifies the authenticity and integrity of a message or document.', 'A type of fingerprint.', 'A way to type your name.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 3), 'What is a "hash function"?', 'A function that takes an input and produces a fixed-size string of characters.', JSON_ARRAY('A function that creates a password.', 'A function that takes an input and produces a fixed-size string of characters.', 'A function that encrypts data.', 'A function that decrypts data.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 4), 'What is "malware"?', 'Malicious software designed to cause damage to a computer, server, or network.', JSON_ARRAY('A type of computer hardware.', 'Malicious software designed to cause damage to a computer, server, or network.', 'A type of programming language.', 'A type of security software.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 4), 'What is a "virus"?', 'A type of malware that attaches itself to legitimate files and spreads by executing itself.', JSON_ARRAY('A type of anti-virus software.', 'A type of malware that attaches itself to legitimate files and spreads by executing itself.', 'A type of computer network.', 'A type of computer program.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 4), 'What is "ransomware"?', 'A type of malware that encrypts a victim files and demands a ransom to restore them.', JSON_ARRAY('A type of anti-virus software.', 'A type of software that deletes files.', 'A type of malware that encrypts a victim files and demands a ransom to restore them.', 'A type of firewall.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 4), 'What is a "Trojan horse"?', 'A type of malware that disguises itself as legitimate software to deceive users.', JSON_ARRAY('A type of firewall.', 'A type of anti-virus software.', 'A type of malware that disguises itself as legitimate software to deceive users.', 'A type of email.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 4), 'What does "spyware" do?', 'It secretly records and transmits information about a user computer activities.', JSON_ARRAY('It speeds up a computer.', 'It secretly records and transmits information about a user computer activities.', 'It protects a computer from viruses.', 'It backs up data.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 5), 'What is "multi-factor authentication" (MFA)?', 'A security system that requires two or more verification methods to grant access.', JSON_ARRAY('A security system that only requires a password.', 'A security system that requires two or more verification methods to grant access.', 'A security system that only uses a fingerprint.', 'A security system that only uses a text message.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 5), 'What is the purpose of an "anti-virus" program?', 'To detect, prevent, and remove malware from a computer.', JSON_ARRAY('To create viruses.', 'To detect, prevent, and remove malware from a computer.', 'To speed up a computer.', 'To create passwords.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 5), 'Why is it important to keep software updated?', 'Updates often include patches for security vulnerabilities.', JSON_ARRAY('To make the software more expensive.', 'To make the software run slower.', 'Updates often include patches for security vulnerabilities.', 'To make the software look better.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 5), 'What is a "penetration test"?', 'An authorized simulated cyberattack on a computer system to find vulnerabilities.', JSON_ARRAY('A type of computer virus.', 'An authorized simulated cyberattack on a computer system to find vulnerabilities.', 'A type of network cable.', 'A type of software.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'cybersecurity' AND module_order = 5), 'What is a "security policy"?', 'A document that outlines the rules and procedures for protecting an organization assets.', JSON_ARRAY('A type of computer.', 'A type of password.', 'A document that outlines the rules and procedures for protecting an organization assets.', 'A type of network.'));

-- UX/UI Design Principles Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 1), 'What is the primary goal of user research?', 'To understand user needs, behaviors, and motivations.', JSON_ARRAY('To design a logo.', 'To write code.', 'To understand user needs, behaviors, and motivations.', 'To find new clients.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 1), 'What is a "persona"?', 'A fictional representation of a target user based on research.', JSON_ARRAY('A type of software.', 'A type of design tool.', 'A fictional representation of a target user based on research.', 'A type of color palette.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 1), 'What is a "user journey map"?', 'A visual representation of the path a user takes to achieve a goal.', JSON_ARRAY('A map of a website.', 'A visual representation of the path a user takes to achieve a goal.', 'A type of wireframe.', 'A type of interview.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 1), 'What is a "stakeholder" in UX/UI?', 'Anyone with an interest or investment in a project.', JSON_ARRAY('A user of a product.', 'A person who designs the app.', 'Anyone with an interest or investment in a project.', 'A competitor.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 1), 'What is the difference between "qualitative" and "quantitative" research?', 'Qualitative is about understanding "why," while quantitative is about understanding "what" and "how many."', JSON_ARRAY('Qualitative is about numbers, and quantitative is about opinions.', 'Qualitative is about understanding "why," while quantitative is about understanding "what" and "how many."', 'Qualitative is about polls, and quantitative is about surveys.', 'Qualitative is about data, and quantitative is about interviews.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 2), 'What is a "wireframe"?', 'A low-fidelity visual guide that represents a website or app’s structure.', JSON_ARRAY('A finished, high-fidelity design.', 'A low-fidelity visual guide that represents a website or app’s structure.', 'A type of code.', 'A type of database.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 2), 'What is a "prototype"?', 'An interactive model of a design that simulates its functionality.', JSON_ARRAY('A static image of a design.', 'An interactive model of a design that simulates its functionality.', 'A type of font.', 'A type of color palette.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 2), 'What is a key benefit of wireframing?', 'It allows for quick and easy iteration on layout and structure.', JSON_ARRAY('It makes the design more complex.', 'It allows for quick and easy iteration on layout and structure.', 'It is the final step in the design process.', 'It adds colors and images.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 2), 'What is "usability testing"?', 'The process of testing a design with real users to identify problems.', JSON_ARRAY('The process of testing the speed of a website.', 'The process of testing the code of an app.', 'The process of testing a design with real users to identify problems.', 'The process of testing a marketing campaign.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 2), 'What is a "user flow"?', 'The sequence of steps a user takes to complete a specific task.', JSON_ARRAY('The path a user takes to get to a website.', 'The sequence of steps a user takes to complete a specific task.', 'The time a user spends on a page.', 'The number of clicks a user makes.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 3), 'What is the main goal of usability testing?', 'To evaluate a product ease of use and identify areas for improvement.', JSON_ARRAY('To make the product more expensive.', 'To evaluate a product ease of use and identify areas for improvement.', 'To make the product more popular.', 'To create a new product.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 3), 'What is "moderated" usability testing?', 'A test where a moderator guides a participant through the tasks.', JSON_ARRAY('A test where participants complete tasks on their own.', 'A test that is done very quickly.', 'A test where a moderator guides a participant through the tasks.', 'A test that is done by a computer.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 3), 'What is "unmoderated" usability testing?', 'A test where participants complete tasks on their own without a moderator present.', JSON_ARRAY('A test where a moderator guides a participant.', 'A test where participants complete tasks on their own without a moderator present.', 'A test that is done very slowly.', 'A test that is done by a computer.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 3), 'What is an "A/B test"?', 'A test that compares two versions of a design to see which performs better.', JSON_ARRAY('A test that is done on a single user.', 'A test that is done on a group of users.', 'A test that compares two versions of a design to see which performs better.', 'A test that is done on a finished product.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 3), 'What is the "Nielsen Norman Group" known for?', 'Its research and insights on usability.', JSON_ARRAY('Its mobile apps.', 'Its search engine.', 'Its research and insights on usability.', 'Its marketing campaigns.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 4), 'What is "information architecture" (IA)?', 'The structure of a website or app that helps users find information and complete tasks.', JSON_ARRAY('The visual design of a website.', 'The structure of a website or app that helps users find information and complete tasks.', 'The content of a website.', 'The code of an app.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 4), 'What is a "sitemap"?', 'A diagram that shows the pages of a website and how they are connected.', JSON_ARRAY('A map of a physical location.', 'A diagram that shows the pages of a website and how they are connected.', 'A list of website users.', 'A list of website features.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 4), 'What is "card sorting"?', 'A user research technique where users group topics into categories that make sense to them.', JSON_ARRAY('A way to organize a deck of cards.', 'A way to organize a list of data.', 'A user research technique where users group topics into categories that make sense to them.', 'A way to create a prototype.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 4), 'What is "labeling" in IA?', 'Choosing the words and phrases for navigation, headings, and links.', JSON_ARRAY('Adding colors to a design.', 'Choosing the words and phrases for navigation, headings, and links.', 'Adding images to a design.', 'Adding code to a website.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 4), 'What is "navigation" in IA?', 'The system that helps users move through the content.', JSON_ARRAY('The design of a website.', 'The system that helps users move through the content.', 'The process of writing code.', 'The process of collecting data.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 5), 'What is the purpose of a UX/UI portfolio?', 'To showcase your design process and problem-solving skills, not just the final product.', JSON_ARRAY('To showcase your coding skills.', 'To showcase your design process and problem-solving skills, not just the final product.', 'To showcase all the projects you have ever worked on.', 'To showcase all the clients you have worked with.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 5), 'What is a "case study" in a UX/UI portfolio?', 'A detailed story of a design project, including the problem, research, process, and outcome.', JSON_ARRAY('A list of all the software used in a project.', 'A detailed story of a design project, including the problem, research, process, and outcome.', 'A summary of your design skills.', 'A list of all the users of a product.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 5), 'Why is it important to include a "problem statement"?', 'To show that your design is a solution to a real user problem.', JSON_ARRAY('To make the portfolio longer.', 'To make the portfolio more colorful.', 'To show that your design is a solution to a real user problem.', 'To make the portfolio more complex.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 5), 'What is the best way to present a portfolio?', 'As a clean, easy-to-navigate website with clear case studies.', JSON_ARRAY('As a large PDF file.', 'As a series of images on social media.', 'As a clean, easy-to-navigate website with clear case studies.', 'As a set of printed documents.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'uxdesign' AND module_order = 5), 'What is a "high-fidelity prototype"?', 'A prototype that looks and works very similarly to the final product.', JSON_ARRAY('A prototype that is a rough sketch.', 'A prototype that is a static image.', 'A prototype that looks and works very similarly to the final product.', 'A prototype that is a simple wireframe.'));

-- Blockchain Essentials Quizzes
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 1), 'What is a "blockchain"?', 'A decentralized, distributed digital ledger that records transactions across many computers.', JSON_ARRAY('A type of database.', 'A decentralized, distributed digital ledger that records transactions across many computers.', 'A type of computer.', 'A type of software.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 1), 'What is "decentralization"?', 'The process of distributing power away from a central authority.', JSON_ARRAY('The process of centralizing power.', 'The process of distributing power away from a central authority.', 'The process of making something faster.', 'The process of making something more expensive.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 1), 'What is a "block"?', 'A record of transactions that is added to the blockchain.', JSON_ARRAY('A type of computer.', 'A record of transactions that is added to the blockchain.', 'A type of software.', 'A type of data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 1), 'What is a "node"?', 'A computer that participates in the blockchain network.', JSON_ARRAY('A type of computer virus.', 'A computer that participates in the blockchain network.', 'A type of database.', 'A type of cryptocurrency.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 1), 'What is "immutability"?', 'The inability for data to be altered or changed once it has been recorded on the blockchain.', JSON_ARRAY('The ability to change data.', 'The inability for data to be altered or changed once it has been recorded on the blockchain.', 'The ability to delete data.', 'The ability to add data.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 2), 'What is a "hash"?', 'A unique, fixed-length string of characters produced from a piece of data.', JSON_ARRAY('A type of key.', 'A unique, fixed-length string of characters produced from a piece of data.', 'A type of algorithm.', 'A type of code.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 2), 'What is a "public key"?', 'A cryptographic key that can be shared publicly.', JSON_ARRAY('A cryptographic key that is kept secret.', 'A cryptographic key that is shared publicly.', 'A type of password.', 'A type of algorithm.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 2), 'What is a "private key"?', 'A cryptographic key that is kept secret and used to sign transactions.', JSON_ARRAY('A cryptographic key that is shared publicly.', 'A cryptographic key that is kept secret and used to sign transactions.', 'A type of password.', 'A type of algorithm.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 2), 'What is the purpose of a "digital signature"?', 'To prove ownership and ensure the authenticity of a transaction.', JSON_ARRAY('To encrypt a transaction.', 'To prove ownership and ensure the authenticity of a transaction.', 'To make a transaction faster.', 'To make a transaction more expensive.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 2), 'What is "cryptocurrency"?', 'A digital or virtual currency that uses cryptography for security.', JSON_ARRAY('A type of physical currency.', 'A digital or virtual currency that uses cryptography for security.', 'A type of stock.', 'A type of bank account.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 3), 'What is a "dApp"?', 'A Decentralized Application, which runs on a decentralized network like a blockchain.', JSON_ARRAY('A type of mobile app.', 'A Decentralized Application, which runs on a decentralized network like a blockchain.', 'A type of computer.', 'A type of website.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 3), 'What is a key difference between a dApp and a traditional app?', 'dApps are censorship-resistant and do not have a single point of failure.', JSON_ARRAY('dApps are always faster.', 'dApps are always cheaper.', 'dApps are censorship-resistant and do not have a single point of failure.', 'dApps are easier to build.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 3), 'What is a "wallet" in the context of dApps?', 'A software application that stores public and private keys and interacts with the blockchain.', JSON_ARRAY('A physical wallet for cash.', 'A software application that stores public and private keys and interacts with the blockchain.', 'A type of cryptocurrency.', 'A type of database.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 3), 'What is "gas" on a blockchain network?', 'A fee paid by users to execute transactions on the network.', JSON_ARRAY('A type of cryptocurrency.', 'A fee paid by users to execute transactions on the network.', 'A type of data.', 'A type of algorithm.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 3), 'What is "interoperability" in blockchain?', 'The ability of different blockchains to communicate and exchange information.', JSON_ARRAY('The ability of a blockchain to run on a single computer.', 'The ability of different blockchains to communicate and exchange information.', 'The ability of a blockchain to process transactions quickly.', 'The ability of a blockchain to be easily changed.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 4), 'What is a "smart contract"?', 'A self-executing contract with the terms of the agreement directly written into lines of code.', JSON_ARRAY('A legal document.', 'A self-executing contract with the terms of the agreement directly written into lines of code.', 'A type of cryptocurrency.', 'A type of software.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 4), 'What is a key feature of a smart contract?', 'It is a self-executing and tamper-proof agreement.', JSON_ARRAY('It is a legal document.', 'It is a self-executing and tamper-proof agreement.', 'It is always free to use.', 'It is always easy to change.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 4), 'What language is commonly used to write smart contracts on Ethereum?', 'Solidity', JSON_ARRAY('Python', 'JavaScript', 'Solidity', 'Java'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 4), 'What is a "token" in a smart contract?', 'A digital asset issued on a blockchain.', JSON_ARRAY('A type of password.', 'A digital asset issued on a blockchain.', 'A type of algorithm.', 'A type of data.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 4), 'What is a "DAO"?', 'A Decentralized Autonomous Organization, governed by a set of rules encoded as a smart contract.', JSON_ARRAY('A type of cryptocurrency.', 'A Decentralized Autonomous Organization, governed by a set of rules encoded as a smart contract.', 'A type of bank.', 'A type of software.'));

INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 5), 'What is a "51% attack"?', 'An attack where a single entity controls more than half of the network’s mining hash rate.', JSON_ARRAY('An attack on a company.', 'An attack where a single entity controls more than half of the network’s mining hash rate.', 'An attack on a database.', 'An attack on a website.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 5), 'What is a "private blockchain"?', 'A blockchain where a central authority controls who can participate.', JSON_ARRAY('A blockchain that is open to everyone.', 'A blockchain where a central authority controls who can participate.', 'A blockchain that is only for companies.', 'A blockchain that is only for individuals.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 5), 'What is a "public blockchain"?', 'A blockchain that is open to everyone and is not controlled by a central authority.', JSON_ARRAY('A blockchain that is open to everyone and is not controlled by a central authority.', 'A blockchain that is only for companies.', 'A blockchain that is only for individuals.', 'A blockchain that is controlled by a central authority.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 5), 'What is a "cold wallet"?', 'A cryptocurrency wallet that is not connected to the internet.', JSON_ARRAY('A cryptocurrency wallet that is connected to the internet.', 'A cryptocurrency wallet that is always hot.', 'A cryptocurrency wallet that is not connected to the internet.', 'A type of bank account.'));
INSERT INTO `quizzes` (`module_id`, `question`, `correct_answer`, `options`) VALUES
((SELECT id FROM `modules` WHERE course_id = 'blockchain' AND module_order = 5), 'What is the purpose of "Proof of Work" (PoW)?', 'A consensus mechanism that requires participants to solve a complex puzzle to add a new block.', JSON_ARRAY('A consensus mechanism that uses a lot of energy.', 'A consensus mechanism that requires participants to solve a complex puzzle to add a new block.', 'A consensus mechanism that is very fast.', 'A consensus mechanism that is very cheap.'));



-- Clear existing enrollments to avoid duplicate key errors if running this script multiple times
DELETE FROM `enrollments`;

-- Alice Johnson (user_id: 1) enrolls in multiple courses
-- For completed_modules_json, we directly construct a JSON array of the module IDs
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'alice.j@example.com'), 'webdev', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'webdev' AND module_order IN (1, 2, 3)), 60.00), -- 3 out of 5 modules completed
((SELECT id FROM `users` WHERE email = 'alice.j@example.com'), 'python', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'python' AND module_order IN (1)), 20.00); -- 1 out of 5 modules completed

-- Bob Williams (user_id: 2)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'bob.w@example.com'), 'datascience', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'datascience' AND module_order IN (1, 2, 3, 4, 5)), 100.00), -- All 5 modules completed!
((SELECT id FROM `users` WHERE email = 'bob.w@example.com'), 'cybersecurity', '[]', 0.00);

-- Charlie Brown (user_id: 3)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'charlie.b@example.com'), 'marketing', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'marketing' AND module_order IN (1, 2, 3, 4, 5)), 100.00),
((SELECT id FROM `users` WHERE email = 'charlie.b@example.com'), 'webdev', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'webdev' AND module_order IN (1, 2, 3)), 60.00);

-- Diana Miller (user_id: 4)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'diana.m@example.com'), 'mobiledev', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'mobiledev' AND module_order IN (1, 2, 3, 4)), 80.00);

-- Ethan Davis (user_id: 5)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'ethan.d@example.com'), 'graphicdesign', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'graphicdesign' AND module_order IN (1, 2, 3, 4, 5)), 100.00); -- Completed!

-- Jack Wilson (user_id: 10)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'jack.w@example.com'), 'ai', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'ai' AND module_order IN (1, 2)), 40.00),
((SELECT id FROM `users` WHERE email = 'jack.w@example.com'), 'webdev', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'webdev' AND module_order IN (1, 2, 3, 4)), 80.00);

-- Karen Baker (user_id: 11)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'karen.b@example.com'), 'blockchain', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'blockchain' AND module_order IN (1, 2, 3)), 60.00);

-- Leo Adams (user_id: 12)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'leo.a@example.com'), 'datascience', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'datascience' AND module_order IN (1, 2)), 40.00);

-- Mia Hall (user_id: 13)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'mia.h@example.com'), 'python', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'python' AND module_order IN (1, 2, 3, 4, 5)), 100.00); -- Completed!

-- Noah Green (user_id: 14)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'noah.g@example.com'), 'uxdesign', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'uxdesign' AND module_order IN (1, 2, 3)), 60.00),
((SELECT id FROM `users` WHERE email = 'noah.g@example.com'), 'marketing', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'marketing' AND module_order IN (1)), 20.00);

-- Olivia Carter (user_id: 15)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'olivia.c@example.com'), 'mobiledev', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'mobiledev' AND module_order IN (1, 2)), 40.00);

-- Peter King (user_id: 16, Instructor) - As an instructor, just add the course enrollment without progress
INSERT INTO `enrollments` (`user_id`, `course_id`) VALUES
((SELECT id FROM `users` WHERE email = 'peter.k@example.com'), 'ai'),
((SELECT id FROM `users` WHERE email = 'peter.k@example.com'), 'datascience'),
((SELECT id FROM `users` WHERE email = 'peter.k@example.com'), 'python');


-- Quinn Wright (user_id: 17)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'quinn.w@example.com'), 'ai', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'ai' AND module_order IN (1, 2, 3, 4, 5)), 100.00), -- Completed!
((SELECT id FROM `users` WHERE email = 'quinn.w@example.com'), 'graphicdesign', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'graphicdesign' AND module_order IN (1)), 20.00);

-- Ryan Cooper (user_id: 18)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'ryan.c@example.com'), 'cybersecurity', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'cybersecurity' AND module_order IN (1, 2, 3, 4)), 80.00);

-- Sophia Turner (user_id: 19, Admin) - Admin can also enroll
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'sophia.t@example.com'), 'datascience', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'datascience' AND module_order IN (1, 2, 3)), 60.00);

-- Tyler Hill (user_id: 20)
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'tyler.h@example.com'), 'blockchain', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'blockchain' AND module_order IN (1, 2, 3, 4, 5)), 100.00), -- Completed!
((SELECT id FROM `users` WHERE email = 'tyler.h@example.com'), 'webdev', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'webdev' AND module_order IN (1, 2)), 40.00);

-- Student: Charlie Brown (id: 3) - another course
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'charlie.b@example.com'), 'python', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'python' AND module_order IN (1,2,3)), 60.00),
((SELECT id FROM `users` WHERE email = 'charlie.b@example.com'), 'uxdesign', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'uxdesign' AND module_order IN (1)), 20.00);
-- Student: Alice Johnson (id: 1) - another course
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'alice.j@example.com'), 'marketing', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'marketing' AND module_order IN (1,2,3,4)), 80.00);
-- Student: Bob Williams (id: 2) - another course
INSERT INTO `enrollments` (`user_id`, `course_id`, `completed_modules_json`, `progress_percentage`) VALUES
((SELECT id FROM `users` WHERE email = 'bob.w@example.com'), 'graphicdesign', (SELECT CONCAT('[', GROUP_CONCAT(id), ']') FROM `modules` WHERE course_id = 'graphicdesign' AND module_order IN (1,2)), 40.00);
