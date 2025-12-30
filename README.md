
# 🎓 Learnova: Modern Learning Management System

**Learnova** is a professional-grade educational platform built to provide a seamless learning experience. It serves three distinct user roles—**Students, Instructors, and Administrators**—each with a tailored dashboard and specific functional capabilities.


###  Core Features & Role-Based Access

#### 🔹 Student Experience

* **Smart Enrollment**: Instant access to a diverse catalog of courses.
* **Curriculum View**: Navigate through video lectures and structured lesson modules.
* **Interactive Quizzes**: Real-time knowledge assessment at the end of each course.
* **Automated Certification**: Earn and download a personalized certificate immediately upon passing.

#### 🔸 Instructor Tools

* **Course Management**: Create, edit, and organize courses with ease.
* **Content Upload**: Dedicated portal for uploading high-quality video lessons.
* **Assessment Builder**: Design quizzes to evaluate and track student performance.

#### 🔸 Administrator Dashboard

* **User Management**: Full authority over student and instructor account status.
* **Financial Tracking**: Monitor platform revenue and enrollment transactions.
* **System Integrity**: Oversee the centralized database and platform-wide configurations.

---

### 📂 File Structure

```text
📁 Learnova-LMS-Platform
├── 📁 Website Gallery      <-- Visual previews of the various dashboards
└── 📁 course                        <-- Course module directory
    ├── 📄 all_courses.php           <-- Page displaying a catalog/list of all available courses
    ├── 📄 course.php                <-- Main logic or class definition file for course objects
    ├── 📄 course_page.css           <-- Stylesheet specific to the course viewing interface
    ├── 📄 course_page.php           <-- The main page where students view course content/lessons
    ├── 📄 enroll_process.php        <-- Backend script to process a user's enrollment in a course
    ├── 📄 generate_certificate.php  <-- Script to generate a certificate upon course completion
    ├── 📄 submit_quiz.php           <-- Backend script to process and grade quiz submissions 
├── 📁 image                <-- Assets used in index.php (logos, banners, icons)
├── 📁 mail                 <-- PHP mailer(a setup to send a welcome message to a new user) 
├── 📁 sql                  <-- Complete MySQL schema for local import
├── 📄 Create_course.php    <-- create new course , accessible by admin and instructors 
├── 📄 dashboard.php           <-- Main user dashboard after logging in
├── 📄 dbconnection.php        <-- Database connection configuration file
├── 📄 faq.php                 <-- Frequently Asked Questions page
├── 📄 footer.php              <-- Reusable footer component included in other pages
├── 📄 header.php              <-- Reusable header/navigation component
├── 📄 index.php               <-- The main homepage/landing page of the website
├── 📄 login.php               <-- Login page design and form
├── 📄 login_process.php       <-- Backend script to handle login authentication
├── 📄 logout.php              <-- Script to destroy the session and log the user out
├── 📄 password_generator.php  <-- extra file that generates random password(can be used to build a new entry in database)
├── 📄 profile.php             <-- Page displaying the user's profile information
├── 📄 session_check.php       <-- Middleware script to verify if a user is logged in
├── 📄 signup.php              <-- Registration page design and form
├── 📄 signup_process.php      <-- Backend script to handle user registration
├── 📄 style.css               <-- Main stylesheet containing CSS for the site
└── 📄 update_profile.php      <-- Form or logic to edit/update user profile details

```

---

###  Tech Stack

* **Frontend**: HTML5, CSS3, JavaScript
* **Backend**: PHP
* **Database**: MySQL
* **Local Server**: XAMPP / WAMP

---

### ⚙️ Installation & Database Setup

To run this project locally, follow these steps exactly:

#### 1. Prepare Local Server

* Download and install **XAMPP**.
* Open the XAMPP Control Panel and **Start** both **Apache** and **MySQL**.
* Clone this repository into `C:/xampp/htdocs/Learnova`.

#### 2. Configure MySQL Database

* Open your browser and go to `http://localhost/phpmyadmin/`.
* Click on **New** in the left sidebar.
* Enter Database Name: **`learnovabd`** and click **Create**.
* Click on your newly created `learnovabd` database.
* Go to the **Import** tab at the top.
* Click **Choose File** and select the **`database.sql`** file from the project folder.
* Scroll down and click **Go/Import**.

> **Note:** The system will automatically build all tables (Users, Courses, Quizzes, Certificates) and insert the necessary initial data.

#### 3. Run the Application

* In your browser, navigate to: `http://localhost/Learnova`

---


