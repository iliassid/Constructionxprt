<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.models.Ressource" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Fournisseur" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Ressource</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>Update Ressource</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <% Ressource ressource = (Ressource) request.getAttribute("ressource"); %>
    <form action="<%=request.getContextPath()%>/ressources/edit" method="post">
        <input type="hidden" name="id" value="<%= ressource.getId() %>">
        <div class="form-group">
            <label for="nom">Nom:</label>
            <input type="text" class="form-control" id="nom" name="nom" value="<%= ressource.getNom() %>" required>
        </div>
        <div class="form-group">
            <label for="type">Type:</label>
            <input type="text" class="form-control" id="type" name="type" value="<%= ressource.getType() %>" required>
        </div>
        <div class="form-group">
            <label for="quantite">Quantite:</label>
            <input type="number" class="form-control" id="quantite" name="quantite" value="<%= ressource.getQuantite() %>" required>
        </div>
        <div class="form-group">
            <label for="unite">Unite:</label>
            <input type="text" class="form-control" id="unite" name="unite" value="<%= ressource.getUnite() %>" required>
        </div>
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description"><%= ressource.getDescription() != null ? ressource.getDescription() : "" %></textarea>
        </div>
        <div class="form-group">
            <label for="fournisseurId">Fournisseur:</label>
            <select class="form-control" id="fournisseurId" name="fournisseurId">
                <option value="">No Fournisseur</option>
                <% List<Fournisseur> fournisseurs = (List<Fournisseur>) request.getAttribute("fournisseurs");
                    if (fournisseurs != null) {
                        for (Fournisseur fournisseur : fournisseurs) {
                            String selected = "";
                            if(ressource.getFournisseurId() != null && ressource.getFournisseurId().equals(fournisseur.getId())) {
                                selected = "selected";
                            }
                %>
                <option value="<%= fournisseur.getId() %>" <%= selected %>><%= fournisseur.getNom() %></option>

                <% }
                } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Update Ressource</button>
        <a href="<%= request.getContextPath() %>/ressources" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>