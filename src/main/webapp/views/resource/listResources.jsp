<!-- views/resource/listResources.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Resource" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resources</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Resource List</h1>
    <a href="<%=request.getContextPath()%>/resources/add" class="btn btn-success mb-3">Add Resource</a>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Type</th>
            <th>Quantity</th>
            <th>Unit</th>
            <th>Cost/Unit</th>
            <th>Supplier</th>
            <th>Notes</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Resource> resources = (List<Resource>) request.getAttribute("resources");
            if (resources != null && !resources.isEmpty()) {
                for (Resource resource : resources) { %>
        <tr>
            <td><%= resource.getResourceId() %></td>
            <td><%= resource.getName() %></td>
            <td><%= resource.getType() %></td>
            <td><%= resource.getQuantity() %></td>
            <td><%= resource.getUnit() %></td>
            <td><%= resource.getCostPerUnit() %></td>
            <td><%= resource.getSupplierName() %></td>  <%-- Display supplier NAME --%>
            <td><%= resource.getNotes() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/resources/edit?id=<%= resource.getResourceId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%= request.getContextPath() %>/resources/delete?id=<%= resource.getResourceId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr><td colspan="9">No resources found.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>