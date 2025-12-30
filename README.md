
# 🎓 Learnova: Modern Learning Management System

**Learnova** is a professional-grade educational platform built to provide a seamless learning experience. It serves three distinct user roles—**Students, Instructors, and Administrators**—each with a tailored dashboard and specific functional capabilities.


### 🚀 Core Features & Role-Based Access

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
├── 📁 course
    ├── 📄 login.php            <-- login page design
    ├── 📄 login.php            <-- login page design 
    ├── 📄 login.php            <-- login page design
    ├── 📄 login.php            <-- login page design
    ├── 📄 login.php            <-- login page design
    ├── 📄 login.php            <-- login page design
    ├── 📄 login.php            <-- login page design  
├── 📁 image                <-- Assets used in index.php (logos, banners, icons)
├── 📁 mail                 <-- PHP mailer(a setup to send a welcome message to a new user) 
├── 📁 Website Gallery      <-- Visual previews of the various dashboards
├── 📁 sql                  <-- Complete MySQL schema for local import
├── 📄 Create_course.php    <-- create new course , accessible by admin and instructors 
├── 📄 dashboard.php        <-- profile dashboard for all the users
├── 📄 index.php            <-- Main entrance of the web application
├── 📄 login.php            <-- login page design 
├── 📄 login_process.php    <-- Role based login managment 
├── 📄 logout.php    <-- Main entrance of the web application
├── 📄 profile.php    <-- Main entrance of the web application
├── 📄 session_check.php    <-- Main entrance of the web application
├── 📄 signup.php    <-- Main entrance of the web application
├── 📄 index.php    <-- Main entrance of the web application
├── 📄 index.php    <-- Main entrance of the web application
├── 📄 index.php    <-- Main entrance of the web application
├── 📄 index.php    <-- Main entrance of the web application
├── 📄 index.php    <-- Main entrance of the web application
├── 📄 index.php    <-- Main entrance of the web application
├── 📄 index.php    <-- Main entrance of the web application
└── 📄 update_profile.php <-- Complete MySQL schema for local import

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


