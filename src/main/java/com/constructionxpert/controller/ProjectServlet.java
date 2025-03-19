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
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ProjectServlet", urlPatterns = {
        "/projects", "/projects/add", "/projects/edit", "/projects/update", "/projects/delete"
})
public class ProjectServlet extends HttpServlet {

    private ProjectDao projectDao;

    @Override
    public void init() throws ServletException {
        projectDao = new ProjectDao();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/projects":
                listProjects(request, response);
                break;
            case "/projects/add":
                showAddForm(request, response);
                break;
            case "/projects/edit":
                showEditForm(request, response);
                break;
            case "/projects/delete":
                try {
                    deleteProject(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            default:
                // Handle other cases or errors
                response.sendRedirect(request.getContextPath() + "/projects");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/projects/add":
                try {
                    addProject(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/projects/update":
                try {
                    updateProject(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            default:
                // Handle other cases or errors
                response.sendRedirect(request.getContextPath() + "/projects");
        }
    }

    private void listProjects(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Project> projects = projectDao.getAllProjects();
        request.setAttribute("projects", projects);
        request.getRequestDispatcher("/views/project/listProjects.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/project/addProject.jsp").forward(request, response);
    }

    private void addProject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // Get parameters from the form
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        Date startDate = Date.valueOf(request.getParameter("startDate")); // Convert String to java.sql.Date
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        double budget = Double.parseDouble(request.getParameter("budget"));
        String status = request.getParameter("status");
        int createdBy = Integer.parseInt(request.getParameter("createdBy"));


        Project project = new Project();
        project.setName(name);
        project.setDescription(description);
        project.setStartDate(startDate);
        project.setEndDate(endDate);
        project.setBudget(budget);
        project.setStatus(status);
        project.setCreatedBy(createdBy); // Get from session, ideally

        projectDao.createProject(project);
        response.sendRedirect(request.getContextPath() + "/projects");
    }



    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int projectId = Integer.parseInt(request.getParameter("id"));
        Project project = projectDao.getProjectById(projectId);

        if (project != null) {
            request.setAttribute("project", project);
            request.getRequestDispatcher("/views/project/editProject.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void updateProject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // Get parameters from the form
        int projectId = Integer.parseInt(request.getParameter("projectId"));  // Get projectID
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        double budget = Double.parseDouble(request.getParameter("budget"));
        String status = request.getParameter("status");

        Project project = new Project();
        project.setProjectId(projectId);  // Important: Set the project ID
        project.setName(name);
        project.setDescription(description);
        project.setStartDate(startDate);
        project.setEndDate(endDate);
        project.setBudget(budget);
        project.setStatus(status);
        // CreatedBy typically wouldn't change on update

        projectDao.updateProject(project);
        response.sendRedirect(request.getContextPath() + "/projects");
    }

    private void deleteProject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int projectId = Integer.parseInt(request.getParameter("id"));
        projectDao.deleteProject(projectId);
        response.sendRedirect(request.getContextPath() + "/projects");
    }

    // Similar methods for TaskServlet, ResourceServlet, SupplierServlet
    // Implement doGet and doPost methods for handling CRUD operations for other entities.
}