<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.models.Administrateur" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="container mt-4">
    <% Administrateur admin = (Administrateur) session.getAttribute("admin"); %>
    <h1>Welcome, <%= admin.getNomUtilisateur() %>!</h1>
    <p>This is the admin dashboard.</p>
    <p> date : <%= admin.getDateCreation() %></p>
    <p> email : <%= admin.getEmail() %></p>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>