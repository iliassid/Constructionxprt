<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Ressource" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>List Ressources</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>List Ressources</h2>
    <a href="<%=request.getContextPath()%>/ressources/add" class="btn btn-success mb-3">Add New Ressource</a>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Type</th>
            <th>Quantite</th>
            <th>Unite</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Ressource> ressources = (List<Ressource>) request.getAttribute("ressources");
            if (ressources != null) {
                for (Ressource ressource : ressources) { %>
        <tr>
            <td><%= ressource.getId() %></td>
            <td><%= ressource.getNom() %></td>
            <td><%= ressource.getType() %></td>
            <td><%= ressource.getQuantite() %></td>
            <td><%= ressource.getUnite() %></td>
            <td><%= ressource.getDescription() != null ? ressource.getDescription() : "" %></td>
            <td>
                <a href="<%=request.getContextPath()%>/ressources/edit?id=<%= ressource.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%=request.getContextPath()%>/ressources/delete?id=<%= ressource.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
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