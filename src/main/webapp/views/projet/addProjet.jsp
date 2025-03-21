<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Projet</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>Add Projet</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <form action="<%=request.getContextPath()%>/projets/add" method="post">
        <div class="form-group">
            <label for="nom">Nom:</label>
            <input type="text" class="form-control" id="nom" name="nom" required>
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description"></textarea>
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
            <label for="budget">Budget:</label>
            <input type="number" step="0.01" class="form-control" id="budget" name="budget" required>
        </div>
        <div class="form-group">
            <label for="statut">Statut:</label>
            <select class="form-control" id="statut" name="statut" required>
                <option value="En attente">En attente</option>
                <option value="En cours">En cours</option>
                <option value="Terminé">Terminé</option>
                <option value="Annulé">Annulé</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Add Projet</button>
        <a href="<%= request.getContextPath() %>/projets" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>