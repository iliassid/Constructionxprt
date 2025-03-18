<!-- views/supplier/listSuppliers.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Supplier" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Suppliers</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Supplier List</h1>
    <a href="<%=request.getContextPath()%>/suppliers/add" class="btn btn-success mb-3">Add Supplier</a>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Contact Person</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Address</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
            if (suppliers != null && !suppliers.isEmpty()) {
                for (Supplier supplier : suppliers) { %>
        <tr>
            <td><%= supplier.getSupplierId() %></td>
            <td><%= supplier.getName() %></td>
            <td><%= supplier.getContactPerson() %></td>
            <td><%= supplier.getPhone() %></td>
            <td><%= supplier.getEmail() %></td>
            <td><%= supplier.getAddress() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/suppliers/edit?id=<%= supplier.getSupplierId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="<%= request.getContextPath() %>/suppliers/delete?id=<%= supplier.getSupplierId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr><td colspan="7">No suppliers found.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>