<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.models.Fournisseur" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>List Fournisseurs</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container">
    <h2>List Fournisseurs</h2>
    <a href="<%=request.getContextPath()%>/fournisseurs/add" class="btn btn-success mb-3">Add New Fournisseur</a>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Contact</th>
            <th>Email</th>
            <th>Telephone</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Fournisseur> fournisseurs = (List<Fournisseur>) request.getAttribute("fournisseurs");
            if (fournisseurs != null) {
                for (Fournisseur fournisseur : fournisseurs) { %>
        <tr>
            <td><%= fournisseur.getId() %></td>
            <td><%= fournisseur.getNom() %></td>
            <td><%= fournisseur.getContact() != null ? fournisseur.getContact() : "" %></td>
            <td><%= fournisseur.getEmail() %></td>
            <td><%= fournisseur.getTelephone() != null ? fournisseur.getTelephone() : "" %></td>
            <td>
                <a href="<%=request.getContextPath()%>/fournisseurs/edit?id=<%= fournisseur.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%=request.getContextPath()%>/fournisseurs/delete?id=<%= fournisseur.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>

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