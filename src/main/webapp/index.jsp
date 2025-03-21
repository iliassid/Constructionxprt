<%
    // Check if the user is logged in
    if (session.getAttribute("admin") != null) {
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    } else {
        response.sendRedirect(request.getContextPath() + "/login");
    }
%>