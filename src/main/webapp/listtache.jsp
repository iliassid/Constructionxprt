<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Tache" %>
<%@ page import="DAO.ProjetDAO" %>
<%@ page import="Model.Projet" %>
<%@ page import="Model.Ressource" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Tâches - ConstructionXpert</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

        .assign-btn {
            background-color: #3498db;
        }

        .assign-btn:hover {
            background-color: #2980b9;
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
    <button class="add-project-button" data-bs-toggle="modal" data-bs-target="#tacheModal" onclick="resetModal()">
        <i class="fas fa-plus"></i> Ajouter une tâche
    </button>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Date de début</th>
            <th>Date de fin</th>
            <th>Projet</th>
            <th>Ressources (Quantité)</th> <!-- Nouvelle colonne -->
            <th>Actions</th>
        </tr>
        </thead>
        <tbody id="tache-table">
        <%
            List<Tache> taches = (List<Tache>) request.getAttribute("taches");
            if (taches != null) {
                for (Tache tache : taches) {
        %>
        <tr>
            <td><%= tache.getId_tache() %></td>
            <td><%= tache.getNom() %></td>
            <td><%= tache.getDate_debut() %></td>
            <td><%= tache.getDate_fin() %></td>
            <td><%= tache.getNomProjet() != null ? tache.getNomProjet() : "Non assigné" %></td>
            <td><%= tache.getQuantiteRessources() %></td> <!-- Affichage de la quantité -->
            <td class="actions" style="width: 200px;">
                <button class="action-btn edit-btn" onclick="fillModal('<%= tache.getId_tache() %>', '<%= tache.getNom() %>', '<%= tache.getDate_debut() %>', '<%= tache.getDate_fin() %>', '<%= tache.getId_projet() %>')" data-bs-toggle="modal" data-bs-target="#tacheModal"><i class="fas fa-edit"></i></button>
                <button class="action-btn delete-btn" onclick="if(confirm('Confirmer la suppression ?')) window.location.href='<%=request.getContextPath()%>/tache?action=deletetache&id=<%=tache.getId_tache()%>'"><i class="fas fa-trash-alt"></i></button>
                <button class="action-btn assign-btn" onclick="fillRessourceModal('<%= tache.getId_tache() %>')" data-bs-toggle="modal" data-bs-target="#ressourceModal"><i class="fas fa-box"></i></button>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<!-- Modal pour ajouter/modifier une tâche -->
<div class="modal fade" id="tacheModal" tabindex="-1" aria-labelledby="tacheModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tacheModalLabel">Ajouter une tâche</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="tacheForm" action="<%=request.getContextPath()%>/tache?action=createtache" method="post">
                    <input type="hidden" id="id_tache" name="id_tache">
                    <div class="mb-3">
                        <label for="nom" class="form-label">Nom de la tâche</label>
                        <input type="text" class="form-control" id="nom" name="nom" required>
                    </div>
                    <div class="mb-3">
                        <label for="date_debut" class="form-label">Date de début</label>
                        <input type="date" class="form-control" id="date_debut" name="date_debut" required>
                    </div>
                    <div class="mb-3">
                        <label for="date_fin" class="form-label">Date de fin</label>
                        <input type="date" class="form-control" id="date_fin" name="date_fin" required>
                    </div>
                    <div class="mb-3">
                        <label for="id_projet" class="form-label">Assigner un projet</label>
                        <select class="form-control" id="id_projet" name="id_projet" required>
                            <option value="0">Aucun projet</option>
                            <%
                                ProjetDAO projetDAO = new ProjetDAO();
                                List<Projet> projets = projetDAO.getAllProjets();
                                for (Projet projet : projets) {
                            %>
                            <option value="<%= projet.getIdProjet() %>"><%= projet.getNomProjet() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                <button type="submit" form="tacheForm" class="btn btn-primary">Enregistrer</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal pour assigner une ressource -->
<div class="modal fade" id="ressourceModal" tabindex="-1" aria-labelledby="ressourceModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ressourceModalLabel">Assigner une ressource</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="ressourceForm" action="<%=request.getContextPath()%>/tache?action=assignerRessource" method="post">
                    <input type="hidden" id="ressource_id_tache" name="id_tache">
                    <div class="mb-3">
                        <label for="id_ressource" class="form-label">Ressource</label>
                        <select class="form-control" id="id_ressource" name="id_ressource" required>
                            <option value="">Sélectionner une ressource</option>
                            <%
                                List<Ressource> ressources = (List<Ressource>) request.getAttribute("ressources");
                                if (ressources != null) {
                                    for (Ressource ressource : ressources) {
                            %>
                            <option value="<%= ressource.getId_ressource() %>"><%= ressource.getNom() %> (Quantité disponible: <%= ressource.getQuantite() %>)</option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="quantite" class="form-label">Quantité</label>
                        <input type="number" class="form-control" id="quantite" name="quantite" min="1" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                <button type="submit" form="ressourceForm" class="btn btn-primary">Assigner</button>
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

    function fillModal(id, nom, dateDebut, dateFin, idProjet) {
        document.getElementById('tacheModalLabel').innerText = 'Modifier une tâche';
        document.getElementById('id_tache').value = id;
        document.getElementById('nom').value = nom;
        document.getElementById('date_debut').value = dateDebut;
        document.getElementById('date_fin').value = dateFin;
        document.getElementById('id_projet').value = idProjet || '0';
        document.getElementById('tacheForm').action = '<%=request.getContextPath()%>/tache?action=updatetache';
    }

    function resetModal() {
        document.getElementById('tacheModalLabel').innerText = 'Ajouter une tâche';
        document.getElementById('id_tache').value = '';
        document.getElementById('nom').value = '';
        document.getElementById('date_debut').value = '';
        document.getElementById('date_fin').value = '';
        document.getElementById('id_projet').value = '0';
        document.getElementById('tacheForm').action = '<%=request.getContextPath()%>/tache?action=createtache';
    }

    function fillRessourceModal(idTache) {
        document.getElementById('ressource_id_tache').value = idTache;
        document.getElementById('id_ressource').value = '';
        document.getElementById('quantite').value = '';
    }
</script>
</body>
</html>