<%--
  Created by IntelliJ IDEA.
  User: iliass
  Date: 17/03/2025
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<!-- views/project/listProjects.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Project" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Projects</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Project List</h1>
    <a href="<%=request.getContextPath()%>/projects/add" class="btn btn-success mb-3">Add Project</a>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Budget</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Project> projects = (List<Project>) request.getAttribute("projects");
            if (projects != null) {
                for (Project project : projects) { %>
        <tr>
            <td><%= project.getProjectId() %></td>
            <td><%= project.getName() %></td>
            <td><%= project.getDescription() %></td>
            <td><%= project.getStartDate() %></td>
            <td><%= project.getEndDate() %></td>
            <td><%= project.getBudget() %></td>
            <td><%= project.getStatus() %></td>
            <td>
                <a href="<%=request.getContextPath()%>/projects/edit?id=<%= project.getProjectId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%=request.getContextPath()%>/projects/delete?id=<%= project.getProjectId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr><td colspan="8">No projects found.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>

<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>