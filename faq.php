<?php 
  // This PHP file creates a dedicated page for Frequently Asked Questions.
  // It includes the header.php and footer.php for a consistent look and feel.
  // The page includes a header, a list of expandable FAQ sections, and a footer.
session_start(); 
$pathPrefix = '';
require_once 'header.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learnova - FAQ</title>
    <link rel="stylesheet" href="style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Specific styles for the FAQ page */
        .faq-section {
            padding: 80px 0;
            background-color: var(--f8f9fa);
        }

        .faq-item {
            background-color: var(--white);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .faq-question {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--green-dark);
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .faq-answer {
            margin-top: 15px;
            font-size: 1rem;
            color: #6c757d;
            display: none; /* Initially hide the answers */
        }

        .faq-item.active .faq-answer {
            display: block; /* Show answer when item is active */
        }

        .faq-question::after {
            content: '+';
            font-size: 1.5rem;
            font-weight: 700;
            transition: transform 0.3s ease;
        }

        .faq-item.active .faq-question::after {
            content: '-';
            transform: rotate(180deg);
        }
    </style>
</head>
<body>


    <section class="faq-section">
        <div class="container">
            <h1 class="section-title">Frequently Asked Questions</h1>
            <div class="faq-container">
                <div class="faq-item">
                    <h3 class="faq-question">What payment methods do you accept?</h3>
                    <p class="faq-answer">We accept all major credit cards, including Visa, MasterCard, and American Express. You can also pay via PayPal and other popular payment gateways.</p>
                </div>
                <div class="faq-item">
                    <h3 class="faq-question">Can I get a refund for a course?</h3>
                    <p class="faq-answer">Yes, we offer a 30-day money-back guarantee. If you are not satisfied with your purchase, you can request a full refund within 30 days of the transaction.</p>
                </div>
                <div class="faq-item">
                    <h3 class="faq-question">Are the certificates accredited?</h3>
                    <p class="faq-answer">Our certificates are a great way to showcase your new skills, but they are not officially accredited by a third-party organization.</p>
                </div>
                <div class="faq-item">
                    <h3 class="faq-question">What if I have technical issues with a course?</h3>
                    <p class="faq-answer">You can contact our support team via our contact page, and we will be happy to assist you with any technical issues you may be facing.</p>
                </div>
                <div class="faq-item">
                    <h3 class="faq-question">How do I access my course materials?</h3>
                    <p class="faq-answer">Once you enroll in a course, all course materials, including videos, quizzes, and resources, will be available on your personal dashboard. You can access them at any time from any device.</p>
                </div>
                <div class="faq-item">
                    <h3 class="faq-question">Do you offer any discounts or promotions?</h3>
                    <p class="faq-answer">We frequently run promotions and offer discounts. Be sure to subscribe to our newsletter and follow us on social media to stay updated on our latest offers.</p>
                </div>
            </div>
        </div>
    </section>

   

    <script>
        // JavaScript to handle the collapsible FAQ items
        document.querySelectorAll('.faq-question').forEach(item => {
            item.addEventListener('click', event => {
                const parent = item.parentElement;
                parent.classList.toggle('active');
            });
        });
    </script>
</body>
</html>
<?php
// Include the footer file, which contains the closing HTML tags.
require_once 'footer.php';
?>