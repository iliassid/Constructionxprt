package com.constructionxpert.controller;

import com.constructionxpert.dao.AdminDao;
import com.constructionxpert.model.Admin;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminServlet", urlPatterns = {"/login", "/logout","/admin/dashboard"})
public class AdminServlet extends HttpServlet {

private AdminDao adminDao;

    @Override
    public void init() throws ServletException {
        adminDao = new AdminDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/logout":
                logout(request, response);
                break;
            case "/admin/dashboard":
                showDachboard(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}