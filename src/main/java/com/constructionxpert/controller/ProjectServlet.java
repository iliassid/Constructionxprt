package com.constructionxpert.controller;

import com.constructionxpert.dao.ProjectDao;
import com.constructionxpert.model.Project;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ProjectServlet", urlPatterns = {
        "/projects", "/projects/add", "/projects/edit", "/projects/update", "/projects/delete"
})
public class ProjectServlet extends HttpServlet {

    private ProjectDao projectDao ;

    @Override
    public void init() throws ServletException {
        projectDao = new ProjectDao();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getServletPath();

        switch (action) {
            case "/projects":
        }
    }
}