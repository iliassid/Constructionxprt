<!-- views/task/addTask.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Project" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Task</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Add Task</h1>
    <form action="<%= request.getContextPath() %>/tasks/add" method="post">
        <div class="mb-3">
            <label for="projectId" class="form-label">Project:</label>
            <select id="projectId" name="projectId" class="form-select" required>
                <% List<Project> projects = (List<Project>) request.getAttribute("projects");
                    if (projects != null) {
                        for (Project project : projects) { %>
                <option value="<%= project.getProjectId() %>"><%= project.getName() %></option>
                <% }
                } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input type="text" id="name" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Description:</label>
            <textarea id="description" name="description" class="form-control"></textarea>
        </div>
        <div class="mb-3">
            <label for="startDate" class="form-label">Start Date:</label>
            <input type="date" id="startDate" name="startDate" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="endDate" class="form-label">End Date:</label>
            <input type="date" id="endDate" name="endDate" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="status" class="form-label">Status:</label>
            <select id="status" name="status" class="form-select" required>
                <option value="À faire">À faire</option>
                <option value="En cours">En cours</option>
                <option value="Terminée">Terminée</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="priority" class="form-label">Priority:</label>
            <select id="priority" name="priority" class="form-select" required>
                <option value="Basse">Basse</option>
                <option value="Moyenne">Moyenne</option>
                <option value="Haute">Haute</option>
                <option value="Urgente">Urgente</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Add Task</button>
    </form>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>