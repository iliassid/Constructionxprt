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
        body{
            background-color: rgb(255, 255, 255);

            color: rgb(11, 11, 11);
        }
        .myh1{
            font-size:xx-large;
            color: rgb(167, 161, 33);

        }
        p{
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        }
        .mydiv{
            display: flex;
            flex-direction: column;
            align-content: center;
            justify-content: center;
            text-align: center;
            background-color: rgba(170, 166, 166, 0.514);
            border-radius: 30px;
            backdrop-filter: blur(5px);
            box-shadow: 10px 10px 20px rgba(0, 0, 0, 0.8);
            width: 60%;
        }
        .propos{
            font-size: x-large;
        }

    </style>
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<div class="mydiv container mt-4">
    <% Administrateur admin = (Administrateur) session.getAttribute("admin"); %>
    <h1 class="myh1">Welcome, <%= admin.getNomUtilisateur() %>!</h1>
    <p class="propos">à propos de l'expert en construction</p>
    <p >Our Construction Management App is designed to enhance efficiency, organization, and communication in construction projects. Whether you're managing a small renovation or a large-scale development, this app provides powerful tools to keep your projects on track.</p>
    <p>Key Features:
        Project Planning & Scheduling – Create, assign, and track tasks with real-time updates.<br>
        Resource Management – Monitor materials, equipment, and workforce allocation.<br>
        Budget & Cost Tracking – Keep expenses in check with accurate financial reports.<br>
        Document & File Sharing – Store blueprints, contracts, and important documents in one place.<br>
        Collaboration & Communication – Connect teams with instant messaging and notifications.<br>
        Progress Monitoring & Reporting – Generate real-time reports and performance analytics.<br>

        With a user-friendly interface and cloud-based accessibility, our Construction Management App simplifies complex processes, reduces delays, and ensures successful project completion.</p>
    <p> date : <%= admin.getDateCreation() %></p>
    <p> email : <%= admin.getEmail() %></p>
</div>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>