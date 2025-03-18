package com.constructionxpert.controller;

import com.constructionxpert.dao.AdminDao;
import com.constructionxpert.model.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminServlet", urlPatterns = {"/login", "/logout","/admin/dashboard"})
public class AdminServlet extends HttpServlet {


}