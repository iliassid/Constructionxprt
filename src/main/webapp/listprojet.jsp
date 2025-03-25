<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Projet" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Projets - ConstructionXpert</title>
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
            padding-top: 80px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333;
            padding: 1rem 2rem;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .logo {
            display: flex;
            align-items: center;
            color: #fff;
            font-size: 1.5rem;
        }

        .logo i {
            margin-right: 10px;
            font-size: 2rem;
            color: #f39c12;
        }

        .nav-links {
            display: flex;
            list-style: none;
        }

        .nav-links li {
            margin-left: 2rem;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-size: 1.1rem;
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

        .toggle .line1 {
            transform: rotate(-45deg) translate(-5px, 6px);
        }

        .toggle .line2 {
            opacity: 0;
        }

        .toggle .line3 {
            transform: rotate(45deg) translate(-5px, -6px);
        }

        @media screen and (max-width: 768px) {
            .nav-links {
                position: absolute;
                right: 0;
                height: 100vh;
                top: 8vh;
                background-color: #333;
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 50%;
                transform: translateX(100%);
                transition: transform 0.5s ease-in;
            }

            .nav-links li {
                opacity: 0;
            }

            .burger {
                display: block;
            }
        }

        .nav-active {
            transform: translateX(0%);
        }

        @keyframes navLinkFade {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0px);
            }
        }

        .table-container {
            padding: 2rem;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #333;
            color: #fff;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .add-project-button {
            display: inline-block;
            margin: 1rem 2rem;
            padding: 10px 20px;
            background-color: #f39c12;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .add-project-button:hover {
            background-color: #e67e22;
        }

        .add-project-button i {
            margin-right: 8px;
        }

        .action-btn {
            padding: 5px 10px;
            margin-right: 5px;
            border-radius: 5px;
            text-decoration: none;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .edit-btn {
            background-color: #f39c12;
        }

        .edit-btn:hover {
            background-color: #e67e22;
            color: #fff;
        }

        .delete-btn {
            background-color: #e74c3c;
        }

        .delete-btn:hover {
            background-color: #c0392b;
            color: #fff;
        }
    </style>
</head>
<body>
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

<div class="table-container">
    <button class="add-project-button" data-bs-toggle="modal" data-bs-target="#projetModal" onclick="resetModal()">
        <i class="fas fa-plus"></i> Ajouter un projet
    </button>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Projet</th>
            <th>Description</th>
            <th>Date de début</th>
            <th>Date de fin</th>
            <th>Budget</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody id="project-table">
        <%
            List<Projet> projets = (List<Projet>) request.getAttribute("projets");
            if (projets != null) {
                for (Projet projet : projets) {
        %>
        <tr>
            <td><%= projet.getIdProjet() %></td>
            <td><%= projet.getNomProjet() %></td>
            <td><%= projet.getDescription() %></td>
            <td><%= projet.getDateDebut() %></td>
            <td><%= projet.getDateFin() %></td>
            <td><%= projet.getBudget() %></td>
            <td class="actions" style="width: 150px;">
                <button class="action-btn edit-btn" onclick="fillModal('<%= projet.getIdProjet() %>', '<%= projet.getNomProjet() %>', '<%= projet.getDescription() %>', '<%= projet.getDateDebut() %>', '<%= projet.getDateFin() %>', '<%= projet.getBudget() %>')" data-bs-toggle="modal" data-bs-target="#projetModal"><i class="fas fa-edit"></i></button>
                <button class="action-btn delete-btn" onclick="if(confirm('Confirmer la suppression ?')) window.location.href='<%=request.getContextPath()%>/projet?action=deleteprojet&id=<%=projet.getIdProjet()%>'"><i class="fas fa-trash-alt"></i></button>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<div class="modal fade" id="projetModal" tabindex="-1" aria-labelledby="projetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="projetModalLabel">Ajouter un projet</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="projetForm" action="<%=request.getContextPath()%>/projet?action=createprojet" method="post">
                    <input type="hidden" id="idProjet" name="idProjet">
                    <div class="mb-3">
                        <label for="nomProjet" class="form-label">Nom du projet</label>
                        <input type="text" class="form-control" id="nomProjet" name="nomProjet" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="dateDebut" class="form-label">Date de début</label>
                        <input type="date" class="form-control" id="dateDebut" name="dateDebut" required>
                    </div>
                    <div class="mb-3">
                        <label for="datefin" class="form-label">Date de fin</label>
                        <input type="date" class="form-control" id="datefin" name="datefin" required>
                    </div>
                    <div class="mb-3">
                        <label for="budget" class="form-label">Budget</label>
                        <input type="number" step="0.01" class="form-control" id="budget" name="budget" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                <button type="submit" form="projetForm" class="btn btn-primary">Enregistrer</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
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
    }

    navSlide();

    function fillModal(id, nomProjet, description, dateDebut, datefin, budget) {
        document.getElementById('projetModalLabel').innerText = 'Modifier un projet';
        document.getElementById('idProjet').value = id;
        document.getElementById('nomProjet').value = nomProjet;
        document.getElementById('description').value = description;
        document.getElementById('dateDebut').value = dateDebut;
        document.getElementById('datefin').value = datefin;
        document.getElementById('budget').value = budget;
        document.getElementById('projetForm').action = '<%=request.getContextPath()%>/projet?action=updateprojet';
        console.log("Modal rempli : ID=" + id + ", Nom=" + nomProjet + ", Action=" + document.getElementById('projetForm').action);
    }

    function resetModal() {
        document.getElementById('projetModalLabel').innerText = 'Ajouter un projet';
        document.getElementById('idProjet').value = '';
        document.getElementById('nomProjet').value = '';
        document.getElementById('description').value = '';
        document.getElementById('dateDebut').value = '';
        document.getElementById('datefin').value = '';
        document.getElementById('budget').value = '';
        document.getElementById('projetForm').action = '<%=request.getContextPath()%>/projet?action=createprojet';
    }
</script>
</body>
</html>