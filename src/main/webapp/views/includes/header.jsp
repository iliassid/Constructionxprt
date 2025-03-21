<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<!-- Add these styles to your CSS file -->
<style>
    /* Color Variables */
    :root {
        --primary: #00ff16;
        --secondary: #3498db;
        --accent: #e74c3c;
        --light: #ecf0f1;
        --dark: #2c3e50;
        --success: #2ecc71;
        --warning: #f39c12;
        --info: #3498db;
        --danger: #e74c3c;
    }

    /* Navbar Base Styling */
    .navbar {
        background: linear-gradient(#360033, #0b8793);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        padding: 12px 20px;
        transition: all 0.4s ease;
    }

    .navbar-brand {
        color: white !important;
        font-weight: 700;
        font-size: 1.4rem;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
    }

    .navbar-brand i {
        color: var(--secondary);
        margin-right: 8px;
        transition: transform 0.4s ease;
    }

    .navbar-brand:hover {
        transform: translateY(-2px);
    }

    .navbar-brand:hover i {
        transform: rotate(15deg);
        color: var(--accent);
    }

    /* Nav Links Styling */
    .navbar .nav-link {
        color: rgba(255, 255, 255, 0.85) !important;
        font-weight: 500;
        margin: 0 5px;
        padding: 10px 15px !important;
        border-radius: 4px;
        position: relative;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }

    .navbar .nav-link i {
        margin-right: 8px;
        transition: all 0.4s ease;
        opacity: 0.8;
    }

    .navbar .nav-link:hover {
        color: white !important;
        background-color: rgba(255, 255, 255, 0.1);
        transform: translateY(-3px);
    }

    .navbar .nav-link:hover i {
        transform: scale(1.2);
        opacity: 1;
        color: var(--secondary);
    }

    /* Animated Underline Effect */
    .navbar-nav .nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: 5px;
        left: 15px;
        background-color: var(--secondary);
        transition: width 0.3s ease-in-out;
    }

    .navbar-nav .nav-link:hover::after {
        width: calc(100% - 30px);
    }

    /* Active State Styling */
    .navbar-nav .nav-item.active .nav-link {
        color: white !important;
        background-color: rgba(52, 152, 219, 0.2);
    }

    .navbar-nav .nav-item.active .nav-link::after {
        width: calc(100% - 30px);
        background-color: var(--accent);
    }

    .navbar-nav .nav-item.active .nav-link i {
        color: var(--accent);
        opacity: 1;
    }

    /* Dropdown Styling */
    .dropdown-menu {
        border: none;
        border-radius: 8px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        animation: dropdownFade 0.3s ease;
        background: #fff;
        margin-top: 10px;
    }

    .dropdown-item {
        padding: 10px 20px;
        transition: all 0.2s ease;
    }

    .dropdown-item i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
    }

    .dropdown-item:hover {
        background-color: #f8f9fa;
        transform: translateX(5px);
    }

    .dropdown-divider {
        margin: 0.5rem 0;
    }

    .dropdown-header {
        font-weight: 600;
        color: var(--primary);
    }

    /* Notification Badge */
    .notification-icon {
        position: relative;
    }

    .notification-badge {
        position: absolute;
        top: 0;
        right: 5px;
        background-color: var(--accent);
        color: white;
        font-size: 0.6rem;
        padding: 0.2rem 0.4rem;
        border-radius: 50%;
        animation: pulse 2s infinite;
    }

    .notification-dropdown {
        min-width: 300px;
    }

    /* Hamburger Menu */
    .navbar-toggler {
        border: none;
        background-color: rgba(255, 255, 255, 0.1);
        padding: 8px;
        border-radius: 4px;
        transition: all 0.3s ease;
    }

    .navbar-toggler:focus {
        outline: none;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.5);
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30' viewBox='0 0 30 30'%3E%3Cpath stroke='rgba(255, 255, 255, 0.85)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
    }

    /* Animations */
    @keyframes dropdownFade {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.2); }
        100% { transform: scale(1); }
    }

    /* Scroll Effect */
    .navbar.scrolled {
        padding: 8px 20px;
        background: rgba(44, 62, 80, 0.98);
    }

    /* Color Theme Switcher */
    .theme-switch {
        display: flex;
        align-items: center;
        margin-left: 15px;
    }

    .theme-switch-wrapper {
        display: flex;
        align-items: center;
    }

    .theme-switch-btn {
        background: none;
        border: none;
        color: rgba(255, 255, 255, 0.85);
        font-size: 1.2rem;
        cursor: pointer;
        padding: 5px;
        transition: all 0.3s ease;
    }

    .theme-switch-btn:hover {
        color: var(--secondary);
        transform: rotate(30deg);
    }

    /* Responsive Styles */
    @media (max-width: 991.98px) {
        .navbar-collapse {
            background-color: var(--primary);
            border-radius: 8px;
            padding: 15px;
            margin-top: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .navbar-nav .nav-link {
            padding: 12px 15px !important;
            margin: 3px 0;
        }

        .navbar-nav .nav-link::after {
            bottom: 8px;
        }

        .ml-auto {
            margin-left: 0 !important;
            margin-top: 10px;
        }

        .navbar-brand {
            margin-right: auto;
        }
    }

    /* Dark Mode Styles - Apply with JS */
    body.dark-mode .navbar {
        background: linear-gradient(135deg, #121212, #1e1e1e);
    }

    body.dark-mode .dropdown-menu {
        background-color: #2d2d2d;
        color: #fff;
    }

    body.dark-mode .dropdown-item {
        color: #ddd;
    }

    body.dark-mode .dropdown-item:hover {
        background-color: #3d3d3d;
    }
</style>

<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/dashboard">
          ConstructionXpert
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/projets">
                         Projets
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/taches">
                     Taches
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/ressources">
                         Ressources
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/fournisseurs">
                         Fournisseurs
                    </a>
                </li>
            </ul>

        </div>
    </div>
</nav>

<!-- Add this before closing body tag -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>

</body>
</html>