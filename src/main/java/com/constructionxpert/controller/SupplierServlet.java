package com.constructionxpert.controller;

import com.constructionxpert.dao.SupplierDao;
import com.constructionxpert.model.Supplier;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SupplierServlet", urlPatterns = {
        "/suppliers", "/suppliers/add", "/suppliers/edit", "/suppliers/update", "/suppliers/delete"
})
public class SupplierServlet extends HttpServlet {


}