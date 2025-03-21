<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.models.Fournisseur" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Fournisseur</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>Update Fournisseur</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <% Fournisseur fournisseur = (Fournisseur) request.getAttribute("fournisseur"); %>
    <form action="<%=request.getContextPath()%>/fournisseurs/edit" method="post">
        <input type="hidden" name="id" value="<%= fournisseur.getId() %>">
        <div class="form-group">
            <label for="nom">Nom:</label>
            <input type="text" class="form-control" id="nom" name="nom" value="<%= fournisseur.getNom() %>" required>
        </div>
        <div class="form-group">
            <label for="contact">Contact:</label>
            <input type="text" class="form-control" id="contact" name="contact" value="<%= fournisseur.getContact() != null ? fournisseur.getContact() : "" %>">
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= fournisseur.getEmail() %>" required>
        </div>
        <div class="form-group">
            <label for="telephone">Telephone:</label>
            <input type="text" class="form-control" id="telephone" name="telephone" value="<%= fournisseur.getTelephone() != null ? fournisseur.getTelephone() : "" %>">
        </div>
        <div class="form-group">
            <label for="adresse">Adresse:</label>
            <textarea class="form-control" id="adresse" name="adresse"><%= fournisseur.getAdresse() != null ? fournisseur.getAdresse() : "" %></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Update Fournisseur</button>
        <a href="<%= request.getContextPath() %>/fournisseurs" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>