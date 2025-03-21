<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.models.Tache" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Projet" %>
<%@ page import="com.constructionxpert.models.Ressource" %>
<%@ page import="com.constructionxpert.models.RessourceTache" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Tache</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>Update Tache</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <% Tache tache = (Tache) request.getAttribute("tache"); %>
    <form action="<%=request.getContextPath()%>/taches/edit" method="post">
        <input type="hidden" name="id" value="<%= tache.getId() %>">
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description" required><%= tache.getDescription() %></textarea>
        </div>
        <div class="form-group">
            <label for="dateDebut">Date Debut:</label>
            <input type="date" class="form-control" id="dateDebut" name="dateDebut" value="<%= tache.getDateDebut() %>" required>
        </div>
        <div class="form-group">
            <label for="dateFin">Date Fin:</label>
            <input type="date" class="form-control" id="dateFin" name="dateFin" value="<%= tache.getDateFin() %>" required>
        </div>
        <div class="form-group">
            <label for="statut">Statut:</label>
            <select class="form-control" id="statut" name="statut" required>
                <option value="À faire" <%= tache.getStatut().equals("À faire") ? "selected" : "" %>>À faire</option>
                <option value="En cours" <%= tache.getStatut().equals("En cours") ? "selected" : "" %>>En cours</option>
                <option value="Terminée" <%= tache.getStatut().equals("Terminée") ? "selected" : "" %>>Terminée</option>
            </select>
        </div>
        <div class="form-group">
            <label for="projetId">Projet:</label>
            <select class="form-control" id="projetId" name="projetId" required>
                <% List<Projet> projets = (List<Projet>) request.getAttribute("projets");
                    if (projets != null) {
                        for (Projet projet : projets) {
                            String selected = "";
                            if (projet.getId() == tache.getProjetId()) {
                                selected = "selected";
                            }
                %>
                <option value="<%= projet.getId() %>" <%= selected %>><%= projet.getNom() %></option>
                <% }
                } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Update Tache</button>
        <a href="<%= request.getContextPath() %>/taches" class="btn btn-secondary">Cancel</a>
    </form>
    <!-- Display Assigned Resources -->
    <h3>Assigned Resources</h3>
    <% List<Ressource> assignedResources = (List<Ressource>) request.getAttribute("assignedResources");
        List<RessourceTache> ressourceTaches = (List<RessourceTache>)request.getAttribute("ressourceTaches");
        if (assignedResources != null && !assignedResources.isEmpty()) { %>

    <table class="table">
        <thead>
        <tr>
            <th>Resource Name</th>
            <th>Quantity Used</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (int i = 0; i < assignedResources.size(); i++) {
                Ressource ressource = assignedResources.get(i);
                RessourceTache ressourceTache = ressourceTaches.get(i);
        %>
        <tr>
            <td><%= ressource.getNom() %></td>
            <td><%= ressourceTache.getQuantiteUtilisee() %></td>
            <td>
                <a href="<%=request.getContextPath()%>/taches/supprimerRessource?tacheId=<%= tache.getId() %>&ressourceId=<%= ressource.getId() %>"
                   class="btn btn-danger btn-sm">Remove</a>
            </td>
        </tr>

        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <p>No resources assigned to this task.</p>
    <% } %>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>