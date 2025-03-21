<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.models.Tache" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Ressource" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assign Resource to Tache</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>Assign Resource to Tache</h2>
        <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
        <% } %>
        <% Tache tache = (Tache) request.getAttribute("tache"); %>
    <p>Assigning resource to Tache: <%= tache.getDescription() %></p>

    <form action="<%=request.getContextPath()%>/taches/assignerRessource" method="post">
        <input type="hidden" name="tacheId" value="<%= tache.getId() %>">

        <div class="form-group">
            <label for="ressourceId">Resource:</label>
            <select class="form-control" id="ressourceId" name="ressourceId" required>
                <% List<Ressource> ressources = (List<Ressource>) request.getAttribute("ressources");
                    if (ressources != null && !ressources.isEmpty()) {
                        for (Ressource ressource : ressources) { %>
                <option value="<%= ressource.getId() %>"><%= ressource.getNom() %> (<%= ressource.getQuantite() %> <%= ressource.getUnite() %> available)</option>
                <% }
                } else { %>
                <option value="">No resources available</option>
                <% } %>
            </select>
        </div>

        <div class="form-group">
            <label for="quantiteUtilisee">Quantity to Use:</label>
            <input type="number" class="form-control" id="quantiteUtilisee" name="quantiteUtilisee" required>
        </div>

        <button type="submit" class="btn btn-primary">Assign Resource</button>
        <a href="<%= request.getContextPath() %>/taches/edit?id=<%=tache.getId()%>" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>