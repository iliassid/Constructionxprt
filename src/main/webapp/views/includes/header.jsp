<!-- views/includes/header.jsp -->
<nav class="navbar navbar-expand-lg custom-navbar">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/dashboard">
            <span class="brand-icon"><i class="fas fa-hard-hat"></i></span>
            ConstructionXpert
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="nav-container">
                <ul class="nav-links">
                    <li><a class="nav-item" href="<%=request.getContextPath()%>/projects">
                        <i class="fas fa-project-diagram nav-icon"></i> Projects
                    </a></li>
                    <li><a class="nav-item" href="<%=request.getContextPath()%>/tasks">
                        <i class="fas fa-tasks nav-icon"></i> Tasks
                    </a></li>
                    <li><a class="nav-item" href="<%=request.getContextPath()%>/resources">
                        <i class="fas fa-tools nav-icon"></i> Resources
                    </a></li>
                    <li><a class="nav-item" href="<%=request.getContextPath()%>/suppliers">
                        <i class="fas fa-truck nav-icon"></i> Suppliers
                    </a></li>
                    <li><a class="nav-item logout-link" href="<%=request.getContextPath()%>/logout">
                        <i class="fas fa-sign-out-alt nav-icon"></i> Logout
                    </a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<style>
    /* Navbar Styling */
    .custom-navbar {
        background-color: #8B4513; /* SaddleBrown */
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        padding: 12px 20px;
        border-radius: 8px;
    }

    .navbar-brand {
        font-weight: bold;
        font-size: 1.5rem;
        color: #fff;
        display: flex;
        align-items: center;
    }

    .navbar-brand:hover {
        color: #FFD700; /* Gold */
    }

    .brand-icon {
        color: #FFD700;
        margin-right: 8px;
    }

    .navbar-toggler {
        border: none;
        background: transparent;
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(255, 255, 255, 0.7)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    /* Navigation Links */
    .nav-container {
        width: 100%;
        display: flex;
        justify-content: flex-end;
    }

    .nav-links {
        display: flex;
        align-items: center;
        gap: 10px;
        margin: 0;
        padding: 0;
        list-style-type: none;
    }

    .nav-item {
        text-decoration: none;
        color: #ffffff;
        font-size: 1rem;
        font-weight: 500;
        padding: 10px 16px;
        border-radius: 5px;
        transition: 0.3s;
    }

    .nav-item:hover {
        background: rgba(255, 255, 255, 0.2);
        color: #FFD700; /* Gold */
    }

    .nav-icon {
        margin-right: 6px;
    }

    /* Logout Button */
    .logout-link {
        background: rgba(220, 53, 69, 0.2); /* Bootstrap Danger */
        border: 1px solid rgba(220, 53, 69, 0.4);
        color: #ffffff;
        font-weight: bold;
    }

    .logout-link:hover {
        background: rgba(220, 53, 69, 0.4);
        border-color: rgba(220, 53, 69, 0.6);
    }

    /* Responsive Design */
    @media (max-width: 991px) {
        .nav-container {
            justify-content: flex-start;
        }

        .nav-links {
            flex-direction: column;
            align-items: flex-start;
            width: 100%;
        }

        .nav-item {
            width: 100%;
            text-align: left;
        }

        .logout-link {
            margin-top: 10px;
            width: 100%;
        }
    }
</style>
