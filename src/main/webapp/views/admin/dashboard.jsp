<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.models.Administrateur" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        body {
            background: linear-gradient(to right, #abbaab, #ffffff);

        }
        .myh1 {
            font-size: xx-large;
            color: rgb(20, 135, 7);
        }
        p {
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        }
        .mydiv {
            display: flex;
            flex-direction: column;
            align-content: center;
            justify-content: center;
            text-align: center;
            background-color: rgba(223, 172, 71, 0.673);
            border-radius: 30px;
            backdrop-filter: blur(5px);
            box-shadow: 10px 10px 20px rgba(0, 0, 0, 0.8);
            padding: 20px;
        }
    </style>
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="mydiv container mt-4">
    <% Administrateur admin = (Administrateur) session.getAttribute("admin"); %>
    <h1 class="myh1">Welcome, <%= admin.getNomUtilisateur() %>!</h1>
    <p>This is the admin dashboard.</p>
    <p>date: <%= admin.getDateCreation() %></p>
    <p>email: <%= admin.getEmail() %></p>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>