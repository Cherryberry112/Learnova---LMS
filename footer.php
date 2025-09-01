<?php
// footer.php
// This file contains the footer and closing body/html tags.
// It also includes the necessary CSS for the profile dropdown.
?>
    <!-- Footer Section -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Learnova. All rights reserved.</p>
        </div>
    </footer>

    <style>
        /* New CSS for the profile dropdown */
        .user-profile-dropdown {
            position: relative;
            display: inline-block;
            margin-left: 20px;
        }

        .profile-name {
            display: inline-block;
            padding: 10px 20px;
            cursor: pointer;
            color: var(--green-dark);
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .profile-name:hover {
            color: var(--gray-dark);
        }
        
        .profile-name i {
            margin-right: 5px;
        }
        
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: var(--white);
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            min-width: 160px;
            z-index: 1;
            border-radius: 10px;
            right: 0;
            top: 45px;
            overflow: hidden;
        }

        .dropdown-content a {
            color: var(--gray-dark);
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            margin: 0;
        }

        .dropdown-content a:hover {
            background-color: var(--gray-light);
        }

        .user-profile-dropdown:hover .dropdown-content {
            display: block;
        }
    </style>
    
    <script>
        // Simple script to handle the profile dropdown
        document.addEventListener('DOMContentLoaded', () => {
            const dropdown = document.querySelector('.user-profile-dropdown');
            if (dropdown) {
                dropdown.addEventListener('click', () => {
                    const content = dropdown.querySelector('.dropdown-content');
                    content.style.display = content.style.display === 'block' ? 'none' : 'block';
                });

                // Close the dropdown if the user clicks outside of it
                window.addEventListener('click', (event) => {
                    if (!dropdown.contains(event.target)) {
                        dropdown.querySelector('.dropdown-content').style.display = 'none';
                    }
                });
            }
        });
    </script>
</body>
</html>
