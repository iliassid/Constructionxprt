<!-- views/project/editProject.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.model.Project" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Project</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Edit Project</h1>
    <% Project project = (Project) request.getAttribute("project");
        if (project != null) { %>
    <form action="<%= request.getContextPath() %>/projects/update" method="post">
        <input type="hidden" name="projectId" value="<%= project.getProjectId() %>">

        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input type="text" id="name" name="name" class="form-control" value="<%= project.getName() %>" required>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Description:</label>
            <textarea id="description" name="description" class="form-control"><%= project.getDescription() %></textarea>
        </div>
        <div class="mb-3">
            <label for="startDate" class="form-label">Start Date:</label>
            <input type="date" id="startDate" name="startDate" class="form-control" value="<%= project.getStartDate() %>" required>
        </div>
        <div class="mb-3">
            <label for="endDate" class="form-label">End Date:</label>
            <input type="date" id="endDate" name="endDate" class="form-control" value="<%= project.getEndDate() %>" required>
        </div>
        <div class="mb-3">
            <label for="budget" class="form-label">Budget:</label>
            <input type="number" id="budget" name="budget" step="0.01" class="form-control" value="<%= project.getBudget() %>" required>
        </div>
        <div class="mb-3">
            <label for="status" class="form-label">Status:</label>
            <select id="status" name="status" class="form-select" required>
                <option value="Planifié" <%= project.getStatus().equals("Planifié") ? "selected" : "" %>>Planifié</option>
                <option value="En cours" <%= project.getStatus().equals("En cours") ? "selected" : "" %>>En cours</option>
                <option value="En pause" <%= project.getStatus().equals("En pause") ? "selected" : "" %>>En pause</option>
                <option value="Terminé" <%= project.getStatus().equals("Terminé") ? "selected" : "" %>>Terminé</option>
                <option value="Annulé" <%= project.getStatus().equals("Annulé") ? "selected" : "" %>>Annulé</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Update Project</button>
    </form>
    <% } else { %>
    <p>Project not found.</p>
    <% } %>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>