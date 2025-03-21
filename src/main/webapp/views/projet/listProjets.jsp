<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Projet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>List Projets</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>List Projets</h2>
    <a href="<%=request.getContextPath()%>/projets/add" class="btn btn-success mb-3">Add New Projet</a>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Description</th>
            <th>Date Debut</th>
            <th>Date Fin</th>
            <th>Budget</th>
            <th>Statut</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Projet> projets = (List<Projet>) request.getAttribute("projets");
            if (projets != null) {
                for (Projet projet : projets) { %>
        <tr>
            <td><%= projet.getId() %></td>
            <td><%= projet.getNom() %></td>
            <td><%= projet.getDescription() != null ? projet.getDescription() : "" %></td>
            <td><%= projet.getDateDebut() != null ? projet.getDateDebut() : "" %></td>
            <td><%= projet.getDateFin() != null ? projet.getDateFin() : "" %></td>
            <td><%= projet.getBudget() %></td>
            <td><%= projet.getStatut() %></td>
            <td>
                <a href="<%=request.getContextPath()%>/projets/edit?id=<%= projet.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%=request.getContextPath()%>/projets/delete?id=<%= projet.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                <a href="<%=request.getContextPath()%>/taches?projetId=<%= projet.getId() %>" class="btn btn-info btn-sm">View Taches</a>
            </td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>