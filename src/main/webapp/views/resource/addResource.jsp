<!-- views/resource/addResource.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.constructionxpert.model.Supplier" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Resource</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
    <h1>Add Resource</h1>
    <form action="<%= request.getContextPath() %>/resources/add" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input type="text" id="name" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="type" class="form-label">Type:</label>
            <select id="type" name="type" class="form-select" required>
                <option value="Matériel">Matériel</option>
                <option value="Équipement">Équipement</option>
                <option value="Personnel">Personnel</option>
                <option value="Autre">Autre</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="quantity" class="form-label">Quantity:</label>
            <input type="number" id="quantity" name="quantity" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="unit" class="form-label">Unit:</label>
            <input type="text" id="unit" name="unit" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="costPerUnit" class="form-label">Cost per Unit:</label>
            <input type="number" id="costPerUnit" name="costPerUnit" step="0.01" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="supplierId" class="form-label">Supplier:</label>
            <select id="supplierId" name="supplierId" class="form-select" required>
                <% List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
                    if (suppliers != null) {
                        for (Supplier supplier : suppliers) { %>
                <option value="<%= supplier.getSupplierId() %>"><%= supplier.getName() %></option>
                <% }
                } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="notes" class="form-label">Notes:</label>
            <textarea id="notes" name="notes" class="form-control"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Add Resource</button>
    </form>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>