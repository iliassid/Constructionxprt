<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.models.Projet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Projet</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>Update Projet</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <% Projet projet = (Projet) request.getAttribute("projet"); %>
    <form action="<%=request.getContextPath()%>/projets/edit" method="post">
        <input type="hidden" name="id" value="<%= projet.getId() %>">
        <div class="form-group">
            <label for="nom">Nom:</label>
            <input type="text" class="form-control" id="nom" name="nom" value="<%= projet.getNom() %>" required>
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description"><%= projet.getDescription() != null ? projet.getDescription() : ""%></textarea>
        </div>
        <div class="form-group">
            <label for="dateDebut">Date Debut:</label>
            <input type="date" class="form-control" id="dateDebut" name="dateDebut" value="<%= projet.getDateDebut() %>" required>
        </div>
        <div class="form-group">
            <label for="dateFin">Date Fin:</label>
            <input type="date" class="form-control" id="dateFin" name="dateFin" value="<%= projet.getDateFin() %>" required>
        </div>
        <div class="form-group">
            <label for="budget">Budget:</label>
            <input type="number" step="0.01" class="form-control" id="budget" name="budget" value="<%= projet.getBudget() %>" required>
        </div>
        <div class="form-group">
            <label for="statut">Statut:</label>
            <select class="form-control" id="statut" name="statut" required>
                <option value="En attente" <%= projet.getStatut().equals("En attente") ? "selected" : "" %>>En attente</option>
                <option value="En cours" <%= projet.getStatut().equals("En cours") ? "selected" : "" %>>En cours</option>
                <option value="Terminé" <%= projet.getStatut().equals("Terminé") ? "selected" : "" %>>Terminé</option>
                <option value="Annulé" <%= projet.getStatut().equals("Annulé") ? "selected" : "" %>>Annulé</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Update Projet</button>
        <a href="<%= request.getContextPath() %>/projets" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>