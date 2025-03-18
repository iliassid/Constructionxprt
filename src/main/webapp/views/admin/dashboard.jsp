<%-- views/admin/dashboard.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.model.Admin" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .dashboard-container {
            max-width: 900px;
            margin: 50px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .dashboard-container h1 {
            color: #343a40;
        }
        .dashboard-menu {
            list-style: none;
            padding: 0;
        }
        .dashboard-menu li {
            margin: 10px 0;
        }
        .dashboard-menu a {
            display: block;
            padding: 12px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            font-weight: 500;
            transition: background 0.3s ease-in-out;
        }
        .dashboard-menu a:hover {
            background: #0056b3;
        }
        .logout-btn {
            display: block;
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            background: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: background 0.3s ease-in-out;
        }
        .logout-btn:hover {
            background: #c82333;
        }
    </style>
</head>
<body>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <div class="dashboard-container">
        <h1 class="text-center">Admin Dashboard</h1>
        <%
            Admin admin = (Admin) session.getAttribute("admin");
            if (admin != null) {
        %>
        <p class="text-center">Welcome, <strong><%= admin.getFullName() %></strong>!</p>
        <% } %>

        <ul class="dashboard-menu">
            <li><a href="<%=request.getContextPath()%>/projects">Manage Projects</a></li>
            <li><a href="<%=request.getContextPath()%>/tasks">Manage Tasks</a></li>
            <li><a href="<%=request.getContextPath()%>/resources">Manage Resources</a></li>
            <li><a href="<%=request.getContextPath()%>/suppliers">Manage Suppliers</a></li>
        </ul>

        <a href="<%=request.getContextPath()%>/logout" class="logout-btn">Logout</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
<script src="<%=request.getContextPath()%>/js/bootstrap.bundle.min.js"></script>

</body>
</html>
