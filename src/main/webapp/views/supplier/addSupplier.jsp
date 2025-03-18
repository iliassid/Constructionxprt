<!-- views/supplier/addSupplier.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Supplier</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../includes/header.jsp" />
<div class="container">
  <h1>Add Supplier</h1>
  <form action="<%= request.getContextPath() %>/suppliers/add" method="post">
    <div class="mb-3">
      <label for="name" class="form-label">Name:</label>
      <input type="text" id="name" name="name" class="form-control" required>
    </div>
    <div class="mb-3">
      <label for="contactPerson" class="form-label">Contact Person:</label>
      <input type="text" id="contactPerson" name="contactPerson" class="form-control">
    </div>
    <div class="mb-3">
      <label for="phone" class="form-label">Phone:</label>
      <input type="text" id="phone" name="phone" class="form-control">
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Email:</label>
      <input type="email" id="email" name="email" class="form-control">
    </div>
    <div class="mb-3">
      <label for="address" class="form-label">Address:</label>
      <textarea id="address" name="address" class="form-control"></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Add Supplier</button>
  </form>
</div>
<jsp:include page="../includes/footer.jsp" />
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>