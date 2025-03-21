package com.constructionxpert.controllers;

import com.constructionxpert.dao.ProjetDao;
import com.constructionxpert.dao.RessourceDao;
import com.constructionxpert.dao.RessourceTacheDao;
import com.constructionxpert.dao.TacheDao;
import com.constructionxpert.models.Projet;
import com.constructionxpert.models.Ressource;
import com.constructionxpert.models.RessourceTache;
import com.constructionxpert.models.Tache;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = {"/taches", "/taches/add", "/taches/edit", "/taches/delete","/taches/assignerRessource", "/taches/supprimerRessource"})
public class TacheServlet extends HttpServlet {

    private TacheDao tacheDao;
    private ProjetDao projetDao;  // For listing projects
    private RessourceDao ressourceDao; // For assigning resources
    private RessourceTacheDao ressourceTacheDao;

    @Override
    public void init() throws ServletException {
        tacheDao = new TacheDao();
        projetDao = new ProjetDao();
        ressourceDao = new RessourceDao();
        ressourceTacheDao = new RessourceTacheDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        try {
            switch (path) {
                case "/taches":
                    listTaches(request,response);
                    break;
                case "/taches/add":
                    showAddForm(request, response);
                    break;
                case "/taches/edit":
                    showEditForm(request, response);
                    break;
                case "/taches/delete":
                    deleteTache(request, response);
                    break;
                case "/taches/assignerRessource":
                    showAssignerRessourceForm(request, response);
                    break;
                case "/taches/supprimerRessource":
                    supprimerRessource(request,response);
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
                case "/taches/add":
                    addTache(request, response);
                    break;
                case "/taches/edit":
                    updateTache(request, response);
                    break;
                case "/taches/assignerRessource":
                    assignerRessource(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private void listTaches(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String projetIdStr = request.getParameter("projetId");

        // If a projetId is provided, list tasks for that project.  Otherwise, list all tasks.
        List<Tache> taches;
        if(projetIdStr != null && !projetIdStr.trim().isEmpty()){
            int projetId = Integer.parseInt(projetIdStr);
            taches = tacheDao.getAllTachesByProjectId(projetId);
            request.setAttribute("projetId", projetId); // Pass projetId to JSP

        } else {
            taches = tacheDao.getAllTaches();
        }

        request.setAttribute("taches", taches);
        request.getRequestDispatcher("/views/tache/listTaches.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Projet> projets = projetDao.getAllProjets();
        request.setAttribute("projets", projets);
        request.getRequestDispatcher("/views/tache/addTache.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tache tache = tacheDao.getTacheById(id);

        if (tache == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tache not found");
            return;
        }

        List<Projet> projets = projetDao.getAllProjets(); // For the project dropdown
        request.setAttribute("projets", projets);
        request.setAttribute("tache", tache);

        List<RessourceTache> ressourceTaches = ressourceTacheDao.getAllRessourceTachesByTacheId(id);
        List<Integer> assignedResourceIds = ressourceTaches.stream()
                .map(RessourceTache::getRessourceId)
                .collect(Collectors.toList());

        List<Ressource> assignedResources = assignedResourceIds.stream()
                .map(resourceId -> {
                    try {
                        return ressourceDao.getRessourceById(resourceId);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);  // Handle properly
                    }
                })
                .collect(Collectors.toList());

        request.setAttribute("assignedResources", assignedResources);
        request.setAttribute("ressourceTaches", ressourceTaches);

        request.getRequestDispatcher("/views/tache/updateTache.jsp").forward(request, response);
    }

    private void addTache(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String description = request.getParameter("description");
        String dateDebutStr = request.getParameter("dateDebut");
        String dateFinStr = request.getParameter("dateFin");
        String statut = request.getParameter("statut");
        String projetIdStr = request.getParameter("projetId");

        // Input validation.
        if (description == null || description.trim().isEmpty() ||
                dateDebutStr == null || dateDebutStr.trim().isEmpty() ||
                dateFinStr == null || dateFinStr.trim().isEmpty() ||
                statut == null || statut.trim().isEmpty() ||
                projetIdStr == null || projetIdStr.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            showAddForm(request, response);
            return;
        }

        Date dateDebut = null;
        Date dateFin = null;
        int projetId = 0;

        try {
            dateDebut = Date.valueOf(dateDebutStr);
            dateFin = Date.valueOf(dateFinStr);
            projetId = Integer.parseInt(projetIdStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date or project ID format.");
            showAddForm(request, response);
            return;
        }
        // Create a new Tache object
        Tache tache = new Tache();
        tache.setDescription(description);
        tache.setDateDebut(dateDebut);
        tache.setDateFin(dateFin);
        tache.setStatut(statut);
        tache.setProjetId(projetId);

        tacheDao.addTache(tache);
        response.sendRedirect(request.getContextPath() + "/taches?projetId=" + projetId);
    }
    private void updateTache(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String description = request.getParameter("description");
        String dateDebutStr = request.getParameter("dateDebut");
        String dateFinStr = request.getParameter("dateFin");
        String statut = request.getParameter("statut");
        String projetIdStr = request.getParameter("projetId"); // Allow changing the project

        // Input Validation
        if (description == null || description.trim().isEmpty() ||
                dateDebutStr == null || dateDebutStr.trim().isEmpty() ||
                dateFinStr == null || dateFinStr.trim().isEmpty() ||
                statut == null || statut.trim().isEmpty() ||
                projetIdStr == null || projetIdStr.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.setAttribute("tache", tacheDao.getTacheById(id)); // Get existing data
            showEditForm(request, response);
            return;
        }

        Date dateDebut = null;
        Date dateFin = null;
        int projetId = 0;

        try {
            dateDebut = Date.valueOf(dateDebutStr);
            dateFin = Date.valueOf(dateFinStr);
            projetId = Integer.parseInt(projetIdStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date or project ID format.");
            request.setAttribute("tache", tacheDao.getTacheById(id));
            showEditForm(request,response);
            return;
        }

        // Get existing tache
        Tache tache = tacheDao.getTacheById(id);
        if (tache == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tache with given ID not found");
            return;
        }
        // Update Tache object.
        tache.setDescription(description);
        tache.setDateDebut(dateDebut);
        tache.setDateFin(dateFin);
        tache.setStatut(statut);
        tache.setProjetId(projetId);

        tacheDao.updateTache(tache);
        response.sendRedirect(request.getContextPath() + "/taches?projetId=" + projetId); // Redirect to the task list for the project
    }

    private void deleteTache(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Tache tache = tacheDao.getTacheById(id);  // Fetch to get projetId
        if (tache == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tache not found.");
            return;
        }
        int projetId = tache.getProjetId();
        tacheDao.deleteTache(id);
        response.sendRedirect(request.getContextPath() + "/taches?projetId=" + projetId); // Redirect back to the project's tasks
    }

    private void showAssignerRessourceForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int tacheId = Integer.parseInt(request.getParameter("tacheId"));
        Tache tache = tacheDao.getTacheById(tacheId);

        if (tache == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Tache not found");
            return;
        }

        // Get all available resources.
        List<Ressource> ressources = ressourceDao.getAllRessources();

        // Get already assigned resources to avoid duplicates in dropdown.
        List<RessourceTache> ressourceTaches = ressourceTacheDao.getAllRessourceTachesByTacheId(tacheId);
        List<Integer> assignedResourceIds = ressourceTaches.stream()
                .map(RessourceTache::getRessourceId)
                .collect(Collectors.toList());

        // Filter out already assigned resources
        List<Ressource> availableResources = ressources.stream()
                .filter(ressource -> !assignedResourceIds.contains(ressource.getId()))
                .collect(Collectors.toList());


        request.setAttribute("tache", tache);  // Pass the tache
        request.setAttribute("ressources", availableResources); // Pass available resources
        request.getRequestDispatcher("/views/tache/assignerRessource.jsp").forward(request, response);
    }
    private void assignerRessource(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int tacheId = Integer.parseInt(request.getParameter("tacheId"));
        int ressourceId = Integer.parseInt(request.getParameter("ressourceId"));
        String quantiteUtiliseeStr = request.getParameter("quantiteUtilisee");

        // Input validation
        if (quantiteUtiliseeStr == null || quantiteUtiliseeStr.trim().isEmpty()) {
            request.setAttribute("error", "Quantity is required.");
            showAssignerRessourceForm(request, response);
            return;
        }


        int quantiteUtilisee = 0;
        try{
            quantiteUtilisee = Integer.parseInt(quantiteUtiliseeStr);
        } catch (NumberFormatException e){
            request.setAttribute("error", "Invalid quantity format.");
            showAssignerRessourceForm(request, response);
            return;
        }

        //Check if the ressource exist and available
        Ressource ressource = ressourceDao.getRessourceById(ressourceId);
        if (ressource == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Resource not found.");
            return;
        }
        if(ressource.getQuantite() < quantiteUtilisee){
            request.setAttribute("error", "Not enough resources available.");
            showAssignerRessourceForm(request, response);
            return;
        }

        // Check for existing assignment (prevent duplicates).
        List<RessourceTache> existingAssignments = ressourceTacheDao.getAllRessourceTachesByTacheId(tacheId);
        for(RessourceTache rt : existingAssignments){
            if(rt.getRessourceId() == ressourceId){
                request.setAttribute("error", "This resource is already assigned to this task.");
                showAssignerRessourceForm(request, response);
                return;
            }
        }

        RessourceTache ressourceTache = new RessourceTache();
        ressourceTache.setTacheId(tacheId);
        ressourceTache.setRessourceId(ressourceId);
        ressourceTache.setQuantiteUtilisee(quantiteUtilisee);

        ressourceTacheDao.addRessourceTache(ressourceTache);

        // Update the remaining quantity of the resource.
        int newQuantity = ressource.getQuantite() - quantiteUtilisee;
        ressourceDao.updateRessourceQuantity(ressourceId, newQuantity);

        response.sendRedirect(request.getContextPath() + "/taches/edit?id=" + tacheId); // Redirect to the edit page of the task
    }
    private void supprimerRessource(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int tacheId = Integer.parseInt(request.getParameter("tacheId"));
        int ressourceId = Integer.parseInt(request.getParameter("ressourceId"));

        // Retrieve the RessourceTache to get the quantity used
        List<RessourceTache> ressourceTaches = ressourceTacheDao.getAllRessourceTachesByTacheId(tacheId);
        RessourceTache ressourceTacheToDelete = null;
        for (RessourceTache rt : ressourceTaches) {
            if (rt.getRessourceId() == ressourceId) {
                ressourceTacheToDelete = rt;
                break;
            }
        }

        if (ressourceTacheToDelete == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Resource assignment not found.");
            return;
        }

        // Delete the association
        ressourceTacheDao.deleteRessourceTache(tacheId, ressourceId);

        // Add the used quantity back to the resource
        Ressource ressource = ressourceDao.getRessourceById(ressourceId);
        if (ressource != null) {
            int updatedQuantity = ressource.getQuantite() + ressourceTacheToDelete.getQuantiteUtilisee();
            ressourceDao.updateRessourceQuantity(ressourceId, updatedQuantity);
        }

        response.sendRedirect(request.getContextPath() + "/taches/edit?id=" + tacheId);
    }

}