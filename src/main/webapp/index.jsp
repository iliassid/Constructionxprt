<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Accueil</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            overflow-x: hidden;
        }

        /* Navbar */
        .navbar {
            background-color: #333;
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .navbar .logo {
            display: flex;
            align-items: center;
            color: #fff;
            font-size: 1.8rem;
            font-weight: bold;
        }

        .navbar .logo i {
            margin-right: 10px;
            font-size: 2.2rem;
            color: #f39c12;
        }

        .nav-links {
            list-style: none;
            display: flex;
        }

        .nav-links li {
            margin-left: 2rem;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-size: 1.2rem;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #f39c12;
        }

        .nav-links i {
            margin-right: 0.5rem;
        }

        .burger {
            display: none;
            cursor: pointer;
        }

        .burger div {
            width: 25px;
            height: 3px;
            background-color: #fff;
            margin: 5px;
            transition: all 0.3s ease;
        }

        @media (max-width: 768px) {
            .nav-links {
                position: absolute;
                top: 80px;
                right: 0;
                background-color: #333;
                width: 50%;
                height: 100vh;
                flex-direction: column;
                align-items: center;
                transform: translateX(100%);
                transition: transform 0.5s ease-in;
            }

            .nav-links li {
                margin: 1.5rem 0;
            }

            .burger {
                display: block;
            }

            .nav-active {
                transform: translateX(0%);
            }

            @keyframes navLinkFade {
                from { opacity: 0; transform: translateX(50px); }
                to { opacity: 1; transform: translateX(0); }
            }
        }

        /* Hero Section */
        .hero {
            height: 100vh;
            background: url('https://images.unsplash.com/photo-1504307651254-35680f356dfd?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80') no-repeat center center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #fff;
            position: relative;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }

        .hero-content {
            z-index: 1;
            animation: fadeInUp 1s ease-out;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
        }

        .hero p {
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }

        .hero .btn {
            background-color: #f39c12;
            color: #fff;
            padding: 12px 30px;
            font-size: 1.2rem;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .hero .btn:hover {
            background-color: #e67e22;
        }

        /* Features Section */
        .features {
            padding: 5rem 2rem;
            text-align: center;
            background-color: #fff;
        }

        .features h2 {
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: #333;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background-color: #f9f9f9;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        .feature-card i {
            font-size: 2.5rem;
            color: #f39c12;
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .feature-card p {
            font-size: 1rem;
            color: #666;
        }

        /* Animations */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-on-scroll {
            opacity: 0;
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .animate-on-scroll.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* Footer */
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 2rem;
        }

        footer p {
            margin: 0;
            font-size: 1rem;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar">
    <div class="logo">
        <i class="fas fa-building"></i>
        <span>ConstructionXpert</span>
    </div>
    <ul class="nav-links">
        <li><a href="index.jsp"><i class="fas fa-home"></i> Accueil</a></li>
        <li><a href="<%=request.getContextPath()%>/projet?action=listprojet"><i class="fas fa-building"></i> Projets</a></li>
        <li><a href="<%=request.getContextPath()%>/ressource?action=listressource"><i class="fas fa-box"></i> Ressources</a></li>
        <li><a href="<%=request.getContextPath()%>/tache?action=listtache"><i class="fas fa-tasks"></i> Tâches</a></li>
    </ul>
    <div class="burger">
        <div class="line1"></div>
        <div class="line2"></div>
        <div class="line3"></div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1>Bienvenue sur ConstructionXpert</h1>
        <p>Gérez vos projets de construction avec efficacité et précision</p>
        <a href="#features" class="btn">Découvrir</a>
    </div>
</section>

<!-- Features Section -->
<section class="features" id="features">
    <h2>Nos Fonctionnalités</h2>
    <div class="feature-grid">
        <div class="feature-card animate-on-scroll">
            <i class="fas fa-building"></i>
            <h3>Gestion des Projets</h3>
            <p>Planifiez, suivez et gérez vos projets de construction en toute simplicité.</p>
        </div>
        <div class="feature-card animate-on-scroll">
            <i class="fas fa-box"></i>
            <h3>Gestion des Ressources</h3>
            <p>Optimisez l'utilisation de vos ressources matérielles et humaines.</p>
        </div>
        <div class="feature-card animate-on-scroll">
            <i class="fas fa-tasks"></i>
            <h3>Gestion des Tâches</h3>
            <p>Assignez et suivez les tâches pour une exécution fluide.</p>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <p>&copy; 2025 ConstructionXpert. Tous droits réservés.</p>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    // Burger Menu Toggle
    const navSlide = () => {
        const burger = document.querySelector('.burger');
        const nav = document.querySelector('.nav-links');
        const navLinks = document.querySelectorAll('.nav-links li');

        burger.addEventListener('click', () => {
            nav.classList.toggle('nav-active');
            navLinks.forEach((link, index) => {
                if (link.style.animation) {
                    link.style.animation = '';
                } else {
                    link.style.animation = `navLinkFade 0.5s ease forwards ${index / 7 + 0.3}s`;
                }
            });
            burger.classList.toggle('toggle');
        });
    };

    navSlide();

    // Scroll Animation for Features
    const featureCards = document.querySelectorAll('.animate-on-scroll');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.2 });

    featureCards.forEach(card => {
        card.style.transform = 'translateY(50px)';
        observer.observe(card);
    });
</script>
</body>
</html>