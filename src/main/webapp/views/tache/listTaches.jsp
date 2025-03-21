<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Tache" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>List Taches</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <% Integer projetId = (Integer) request.getAttribute("projetId"); %>

    <h2>List Taches
        <% if(projetId != null) { %>
        for Projet ID: <%= projetId %>
        <% } %>
    </h2>
    <a href="<%=request.getContextPath()%>/taches/add" class="btn btn-success mb-3">Add New Tache</a>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Description</th>
            <th>Date Debut</th>
            <th>Date Fin</th>
            <th>Statut</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Tache> taches = (List<Tache>) request.getAttribute("taches");
            if (taches != null) {
                for (Tache tache : taches) { %>
        <tr>
            <td><%= tache.getId() %></td>
            <td><%= tache.getDescription() %></td>
            <td><%= tache.getDateDebut() !=null ? tache.getDateDebut() : "" %></td>
            <td><%= tache.getDateFin() != null ? tache.getDateFin() : ""%></td>
            <td><%= tache.getStatut() %></td>
            <td>
                <a href="<%=request.getContextPath()%>/taches/edit?id=<%= tache.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%=request.getContextPath()%>/taches/delete?id=<%= tache.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                <a href="<%=request.getContextPath()%>/taches/assignerRessource?tacheId=<%= tache.getId() %>" class="btn btn-info btn-sm">Assign Resource</a>
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