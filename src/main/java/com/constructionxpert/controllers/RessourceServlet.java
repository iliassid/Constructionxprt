package com.constructionxpert.controllers;

import com.constructionxpert.dao.FournisseurDao;
import com.constructionxpert.dao.RessourceDao;
import com.constructionxpert.models.Fournisseur;
import com.constructionxpert.models.Ressource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/ressources", "/ressources/add", "/ressources/edit", "/ressources/delete"})
public class RessourceServlet extends HttpServlet {

    private RessourceDao ressourceDao;
    private FournisseurDao fournisseurDao; // Required for the fournisseur dropdown

    @Override
    public void init() throws ServletException {
        ressourceDao = new RessourceDao();
        fournisseurDao = new FournisseurDao(); // Initialize FournisseurDao
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        try {
            switch (path) {
                case "/ressources":
                    listRessources(request, response);
                    break;
                case "/ressources/add":
                    showAddForm(request, response);
                    break;
                case "/ressources/edit":
                    showEditForm(request, response);
                    break;
                case "/ressources/delete":
                    deleteRessource(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        try {
            switch (path) {
                case "/ressources/add":
                    addRessource(request, response);
                    break;
                case "/ressources/edit":
                    updateRessource(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void listRessources(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Ressource> ressources = ressourceDao.getAllRessources();
        request.setAttribute("ressources", ressources);
        request.getRequestDispatcher("/views/ressource/listRessources.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        // Fetch the list of fournisseurs for the dropdown
        List<Fournisseur> fournisseurs = fournisseurDao.getAllFournisseurs();
        request.setAttribute("fournisseurs", fournisseurs);
        request.getRequestDispatcher("/views/ressource/addRessource.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Ressource ressource = ressourceDao.getRessourceById(id);
        if (ressource == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ressource not found");
            return;
        }

        // Fetch fournisseurs for the dropdown.
        List<Fournisseur> fournisseurs = fournisseurDao.getAllFournisseurs();
        request.setAttribute("fournisseurs", fournisseurs);
        request.setAttribute("ressource", ressource);
        request.getRequestDispatcher("/views/ressource/updateRessource.jsp").forward(request, response);
    }

    private void addRessource(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String nom = request.getParameter("nom");
        String type = request.getParameter("type");
        String quantiteStr = request.getParameter("quantite");
        String unite = request.getParameter("unite");
        String description = request.getParameter("description");
        String fournisseurIdStr = request.getParameter("fournisseurId"); // Could be null

        // Input Validation
        if (nom == null || nom.trim().isEmpty() ||
                type == null || type.trim().isEmpty() ||
                quantiteStr == null || quantiteStr.trim().isEmpty() ||
                unite == null || unite.trim().isEmpty()) {

            request.setAttribute("error", "Nom, Type, Quantite, and Unite are required.");
            showAddForm(request,response); //re-display with error
            return;

        }
        int quantite = 0;
        try {
            quantite = Integer.parseInt(quantiteStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid quantity format.");
            showAddForm(request,response);
            return;
        }

        Integer fournisseurId = null;
        if (fournisseurIdStr != null && !fournisseurIdStr.trim().isEmpty()) {
            try {
                fournisseurId = Integer.parseInt(fournisseurIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Fournisseur ID format.");
                showAddForm(request,response);
                return;
            }
        }

        // Create a new Ressource object
        Ressource ressource = new Ressource();
        ressource.setNom(nom);
        ressource.setType(type);
        ressource.setQuantite(quantite);
        ressource.setUnite(unite);
        ressource.setDescription(description);
        ressource.setFournisseurId(fournisseurId); // Can be null

        ressourceDao.addRessource(ressource);
        response.sendRedirect(request.getContextPath() + "/ressources");
    }
    private void updateRessource(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String type = request.getParameter("type");
        String quantiteStr = request.getParameter("quantite");
        String unite = request.getParameter("unite");
        String description = request.getParameter("description");
        String fournisseurIdStr = request.getParameter("fournisseurId"); // Could be null


        // Input validation (similar to add, but for updating).
        if (nom == null || nom.trim().isEmpty() ||
                type == null || type.trim().isEmpty() ||
                quantiteStr == null || quantiteStr.trim().isEmpty() ||
                unite == null || unite.trim().isEmpty()) {

            request.setAttribute("error", "Nom, Type, Quantite, and Unite are required.");
            request.setAttribute("ressource", ressourceDao.getRessourceById(id)); // Get existing data
            showEditForm(request,response);
            return;
        }


        int quantite = 0;
        try {
            quantite = Integer.parseInt(quantiteStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid quantity format.");
            request.setAttribute("ressource", ressourceDao.getRessourceById(id));
            showEditForm(request,response);
            return;
        }

        Integer fournisseurId = null;
        if (fournisseurIdStr != null && !fournisseurIdStr.trim().isEmpty()) {
            try {
                fournisseurId = Integer.parseInt(fournisseurIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid Fournisseur ID format.");
                request.setAttribute("ressource", ressourceDao.getRessourceById(id));
                showEditForm(request,response); // Re-display the edit form.
                return;
            }
        }

        // Get existing ressource.
        Ressource ressource = ressourceDao.getRessourceById(id);
        if(ressource == null){
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ressource with given ID not found");
            return;
        }

        // Update object
        ressource.setNom(nom);
        ressource.setType(type);
        ressource.setQuantite(quantite);
        ressource.setUnite(unite);
        ressource.setDescription(description);
        ressource.setFournisseurId(fournisseurId); // Allow null

        ressourceDao.updateRessource(ressource);
        response.sendRedirect(request.getContextPath() + "/ressources");
    }

    private void deleteRessource(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        ressourceDao.deleteRessource(id);
        response.sendRedirect(request.getContextPath() + "/ressources");
    }
}