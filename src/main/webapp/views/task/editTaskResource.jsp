<!-- views/task/editTaskResource.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Resource" %>
<%@ page import="com.constructionxpert.model.Task" %>
<%@ page import="com.constructionxpert.model.TaskResource" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Resource Assignment</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
  <% Task task = (Task) request.getAttribute("task");
    TaskResource taskResource = (TaskResource) request.getAttribute("taskResource");
  %>
  <h1>Edit Resource Assignment for Task: <%= (task != null) ? task.getName() : "N/A" %></h1>

  <form action="<%= request.getContextPath() %>/tasks/resources/update" method="post">
    <input type="hidden" name="taskResourceId" value="<%= taskResource.getTaskResourceId() %>">
    <input type="hidden" name="taskId" value="<%= task.getTaskId() %>">

    <div class="mb-3">
      <label for="resourceId" class="form-label">Resource:</label>
      <select id="resourceId" name="resourceId" class="form-select" required>
        <% List<Resource> resources = (List<Resource>) request.getAttribute("resources");
          if (resources != null) {
            for (Resource resource : resources) { %>
        <option value="<%= resource.getResourceId() %>" <%= (resource.getResourceId() == taskResource.getResourceId()) ? "selected" : "" %>><%= resource.getName() %> (Available: <%= resource.getQuantity() %>)</option>
        <% }
        } %>
      </select>
    </div>

    <div class="mb-3">
      <label for="quantityNeeded" class="form-label">Quantity Needed:</label>
      <input type="number" id="quantityNeeded" name="quantityNeeded" class="form-control" required min="1" value="<%= taskResource.getQuantityNeeded() %>">
    </div>

    <button type="submit" class="btn btn-primary">Update Assignment</button>
  </form>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>