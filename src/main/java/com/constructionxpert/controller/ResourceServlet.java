package com.constructionxpert.controller;

import com.constructionxpert.dao.ResourceDao;
import com.constructionxpert.dao.SupplierDao;
import com.constructionxpert.model.Resource;
import com.constructionxpert.model.Supplier;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ResourceServlet", urlPatterns = {
        "/resources", "/resources/add", "/resources/edit", "/resources/update", "/resources/delete"
})
public class ResourceServlet extends HttpServlet {

    private ResourceDao resourceDao;
    private SupplierDao supplierDao; // Needed for the supplier dropdown

    @Override
    public void init() throws ServletException {
        resourceDao = new ResourceDao();
        supplierDao = new SupplierDao(); // Initialize SupplierDao
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/resources":
                listResources(request, response);
                break;
            case "/resources/add":
                showAddForm(request, response);
                break;
            case "/resources/edit":
                showEditForm(request, response);
                break;
            case "/resources/delete":
                deleteResource(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/resources");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        switch (action) {
            case "/resources/add":
                addResource(request, response);
                break;
            case "/resources/update":
                updateResource(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/resources");
        }
    }

    private void listResources(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Resource> resources = resourceDao.getAllResources();
        request.setAttribute("resources", resources);
        request.getRequestDispatcher("/views/resource/listResources.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the list of suppliers for the dropdown
        List<Supplier> suppliers = supplierDao.getAllSuppliers();
        request.setAttribute("suppliers", suppliers);

        request.getRequestDispatcher("/views/resource/addResource.jsp").forward(request, response);
    }

    private void addResource(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String unit = request.getParameter("unit");
        double costPerUnit = Double.parseDouble(request.getParameter("costPerUnit"));
        int supplierId = Integer.parseInt(request.getParameter("supplierId")); // Get supplier ID
        String notes = request.getParameter("notes");

        Resource resource = new Resource();
        resource.setName(name);
        resource.setType(type);
        resource.setQuantity(quantity);
        resource.setUnit(unit);
        resource.setCostPerUnit(costPerUnit);
        resource.setSupplierId(supplierId); // Set supplier ID
        resource.setNotes(notes);

        resourceDao.createResource(resource);
        response.sendRedirect(request.getContextPath() + "/resources");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int resourceId = Integer.parseInt(request.getParameter("id"));
        Resource resource = resourceDao.getResourceById(resourceId);
        // Get the list of suppliers for the dropdown
        List<Supplier> suppliers = supplierDao.getAllSuppliers();


        if (resource != null) {
            request.setAttribute("resource", resource);
            request.setAttribute("suppliers", suppliers); //set suppliers list
            request.getRequestDispatcher("/views/resource/editResource.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void updateResource(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int resourceId = Integer.parseInt(request.getParameter("resourceId"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String unit = request.getParameter("unit");
        double costPerUnit = Double.parseDouble(request.getParameter("costPerUnit"));
        int supplierId = Integer.parseInt(request.getParameter("supplierId"));
        String notes = request.getParameter("notes");

        Resource resource = new Resource();
        resource.setResourceId(resourceId);
        resource.setName(name);
        resource.setType(type);
        resource.setQuantity(quantity);
        resource.setUnit(unit);
        resource.setCostPerUnit(costPerUnit);
        resource.setSupplierId(supplierId);
        resource.setNotes(notes);

        resourceDao.updateResource(resource);
        response.sendRedirect(request.getContextPath() + "/resources");
    }

    private void deleteResource(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int resourceId = Integer.parseInt(request.getParameter("id"));
        resourceDao.deleteResource(resourceId);
        response.sendRedirect(request.getContextPath() + "/resources");
    }
}