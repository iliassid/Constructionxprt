<!-- views/resource/editResource.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.constructionxpert.model.Resource" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Supplier" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Resource</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Edit Resource</h1>
    <% Resource resource = (Resource) request.getAttribute("resource");
        if (resource != null) { %>
    <form action="<%= request.getContextPath() %>/resources/update" method="post">
        <input type="hidden" name="resourceId" value="<%= resource.getResourceId() %>">

        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input type="text" id="name" name="name" class="form-control" value="<%= resource.getName() %>" required>
        </div>
        <div class="mb-3">
            <label for="type" class="form-label">Type:</label>
            <select id="type" name="type" class="form-select" required>
                <option value="Matériel" <%= resource.getType().equals("Matériel") ? "selected" : "" %>>Matériel</option>
                <option value="Équipement" <%= resource.getType().equals("Équipement") ? "selected" : "" %>>Équipement</option>
                <option value="Personnel" <%= resource.getType().equals("Personnel") ? "selected" : "" %>>Personnel</option>
                <option value="Autre" <%= resource.getType().equals("Autre") ? "selected" : "" %>>Autre</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="quantity" class="form-label">Quantity:</label>
            <input type="number" id="quantity" name="quantity" class="form-control" value="<%= resource.getQuantity() %>" required>
        </div>
        <div class="mb-3">
            <label for="unit" class="form-label">Unit:</label>
            <input type="text" id="unit" name="unit" class="form-control" value="<%= resource.getUnit() %>" required>
        </div>
        <div class="mb-3">
            <label for="costPerUnit" class="form-label">Cost per Unit:</label>
            <input type="number" id="costPerUnit" name="costPerUnit" step="0.01" class="form-control" value="<%= resource.getCostPerUnit() %>" required>
        </div>
        <div class="mb-3">
            <label for="supplierId" class="form-label">Supplier:</label>
            <select id="supplierId" name="supplierId" class="form-select" required>
                <% List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
                    if (suppliers != null) {
                        for (Supplier supplier : suppliers) { %>
                <option value="<%= supplier.getSupplierId() %>" <%= (supplier.getSupplierId() == resource.getSupplierId()) ? "selected" : "" %>><%= supplier.getName() %></option>
                <% }
                } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="notes" class="form-label">Notes:</label>
            <textarea id="notes" name="notes" class="form-control"><%= resource.getNotes() %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Resource</button>
    </form>
    <% } else { %>
    <p>Resource not found.</p>
    <% } %>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></</script>
</body>
</html>