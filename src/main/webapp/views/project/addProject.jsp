<!-- views/project/addProject.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.model.Admin" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Project</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Add Project</h1>
    <form action="<%= request.getContextPath() %>/projects/add" method="post">
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
            <input type="date" id="endDate" name="endDate" class="form-controlclass=" required>
        </div>
        <div class="mb-3">
            <label for="budget" class="form-label">Budget:</label>
            <input type="number" id="budget" name="budget" step="0.01" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="status" class="form-label">Status:</label>
            <select id="status" name="status" class="form-select" required>
                <option value="Planifié">Planifié</option>
                <option value="En cours">En cours</option>
                <option value="En pause">En pause</option>
                <option value="Terminé">Terminé</option>
                <option value="Annulé">Annulé</option>
            </select>
        </div>
        <% Admin admin = (Admin) session.getAttribute("admin");%>
        <input type="hidden" name="createdBy" value="<%= admin.getAdminId() %>">

        <button type="submit" class="btn btn-primary">Add Project</button>
    </form>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>