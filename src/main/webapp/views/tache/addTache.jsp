<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Projet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Tache</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>Add Tache</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <form action="<%=request.getContextPath()%>/taches/add" method="post">
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description" required></textarea>
        </div>
        <div class="form-group">
            <label for="dateDebut">Date Debut:</label>
            <input type="date" class="form-control" id="dateDebut" name="dateDebut" required>
        </div>
        <div class="form-group">
            <label for="dateFin">Date Fin:</label>
            <input type="date" class="form-control" id="dateFin" name="dateFin" required>
        </div>
        <div class="form-group">
            <label for="statut">Statut:</label>
            <select class="form-control" id="statut" name="statut" required>
                <option value="À faire">À faire</option>
                <option value="En cours">En cours</option>
                <option value="Terminée">Terminée</option>
            </select>
        </div>
        <div class="form-group">
            <label for="projetId">Projet:</label>
            <select class="form-control" id="projetId" name="projetId" required>
                <% List<Projet> projets = (List<Projet>) request.getAttribute("projets");
                    if (projets != null) {
                        for (Projet projet : projets) { %>
                <option value="<%= projet.getId() %>"><%= projet.getNom() %></option>
                <% }
                } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Add Tache</button>
        <a href="<%= request.getContextPath() %>/taches" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>