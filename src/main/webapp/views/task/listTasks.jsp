<!-- views/task/listTasks.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Task" %>
<%@ page import="com.constructionxpert.model.Project" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tasks for Project</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <% Project project = (Project) request.getAttribute("project"); %>
    <h1>Tasks for Project: <%= (project != null) ? project.getName() : "N/A" %></h1>
    <a href="<%=request.getContextPath()%>/tasks/add?projectId=<%= project.getProjectId() %>" class="btn btn-success mb-3">Add Task</a>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Status</th>
            <th>Priority</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Task> tasks = (List<Task>) request.getAttribute("tasks");
            if (tasks != null && !tasks.isEmpty()) {
                for (Task task : tasks) { %>
        <tr>
            <td><%= task.getTaskId() %></td>
            <td><%= task.getName() %></td>
            <td><%= task.getDescription() %></td>
            <td><%= task.getStartDate() %></td>
            <td><%= task.getEndDate() %></td>
            <td><%= task.getStatus() %></td>
            <td><%= task.getPriority() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/tasks/edit?id=<%= task.getTaskId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%= request.getContextPath() %>/tasks/delete?id=<%= task.getTaskId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr><td colspan="8">No tasks found for this project.</td></tr>
        <% } %>
        </tbody>
    </table>
    <a href="<%= request.getContextPath() %>/projects" class="btn btn-secondary">Back to Projects</a>
    <!--In listTasks.jsp  add link-->
    <a href="<%=request.getContextPath()%>/tasks/resources/add?taskId=<%= project.getProjectId() %>" class="btn btn-success mb-3">Add Task Resource</a>
</div>

<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>