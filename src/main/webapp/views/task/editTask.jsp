<!-- views/task/editTask.jsp-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.model.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Project" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Task</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Edit Task</h1>
    <% Task task = (Task) request.getAttribute("task");
        if (task != null) { %>
    <form action="<%= request.getContextPath() %>/tasks/update" method="post">
        <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">

        <div class="mb-3">
            <label for="projectId" class="form-label">Project:</label>
            <select id="projectId" name="projectId" class="form-select" required>
                <% List<Project> projects = (List<Project>) request.getAttribute("projects");
                    if (projects != null) {
                        for (Project project : projects) { %>
                <option value="<%= project.getProjectId() %>" <%= (project.getProjectId() == task.getProjectId()) ? "selected" : "" %>><%= project.getName() %></option>
                <% }
                } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input type="text" id="name" name="name" class="form-control" value="<%= task.getName() %>" required>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Description:</label>
            <textarea id="description" name="description" class="form-control"><%= task.getDescription() %></textarea>
        </div>
        <div class="mb-3">
            <label for="startDate" class="form-label">Start Date:</label>
            <input type="date" id="startDate" name="startDate" class="form-control" value="<%= task.getStartDate() %>" required>
        </div>
        <div class="mb-3">
            <label for="endDate" class="form-label">End Date:</label>
            <input type="date" id="endDate" name="endDate" class="form-control" value="<%= task.getEndDate() %>" required>
        </div>
        <div class="mb-3">
            <label for="status" class="form-label">Status:</label>
            <select id="status" name="status" class="form-select" required>
                <option value="À faire" <%= task.getStatus().equals("À faire") ? "selected" : "" %>>À faire</option>
                <option value="En cours" <%= task.getStatus().equals("En cours") ? "selected" : "" %>>En cours</option>
                <option value="Terminée" <%= task.getStatus().equals("Terminée") ? "selected" : "" %>>Terminée</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="priority" class="form-label">Priority:</label>
            <select id="priority" name="priority" class="form-select" required>
                <option value="Basse" <%= task.getPriority().equals("Basse") ? "selected" : "" %>>Basse</option>
                <option value="Moyenne" <%= task.getPriority().equals("Moyenne") ? "selected" : "" %>>Moyenne</option>
                <option value="Haute" <%= task.getPriority().equals("Haute") ? "selected" : "" %>>Haute</option>
                <option value="Urgente" <%= task.getPriority().equals("Urgente") ? "selected" : "" %>>Urgente</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Update Task</button>
    </form>
    <% } else { %>
    <p>Task not found.</p>
    <% } %>

</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>