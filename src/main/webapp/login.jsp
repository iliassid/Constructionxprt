<%--
  Created by IntelliJ IDEA.
  User: iliass
  Date: 17/03/2025
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<!-- login.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/custom.css"> <%-- Your custom styles --%>
</head>
<body>
<div class="container">
    <h1>Login</h1>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    <form action="login" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username:</label>
            <input type="text" id="username" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password:</label>
            <input type="password" id="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>
</div>
<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>