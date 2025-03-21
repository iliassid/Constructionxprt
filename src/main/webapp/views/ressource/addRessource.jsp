<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Fournisseur" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Ressource</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>Add Ressource</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <form action="<%=request.getContextPath()%>/ressources/add" method="post">
        <div class="form-group">
            <label for="nom">Nom:</label>
            <input type="text" class="form-control" id="nom" name="nom" required>
        </div>
        <div class="form-group">
            <label for="type">Type:</label>
            <input type="text" class="form-control" id="type" name="type" required>
        </div>
        <div class="form-group">
            <label for="quantite">Quantite:</label>
            <input type="number" class="form-control" id="quantite" name="quantite" required>
        </div>
        <div class="form-group">
            <label for="unite">Unite:</label>
            <input type="text" class="form-control" id="unite" name="unite" required>
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description"></textarea>
        </div>
        <div class="form-group">
            <label for="fournisseurId">Fournisseur:</label>
            <select class="form-control" id="fournisseurId" name="fournisseurId">
                <option value="">No Fournisseur</option> <!-- Option for no selection -->
                <% List<Fournisseur> fournisseurs = (List<Fournisseur>) request.getAttribute("fournisseurs");
                    if (fournisseurs != null) {
                        for (Fournisseur fournisseur : fournisseurs) { %>
                <option value="<%= fournisseur.getId() %>"><%= fournisseur.getNom() %></option>
                <% }
                } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Add Ressource</button>
        <a href="<%= request.getContextPath() %>/ressources" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>