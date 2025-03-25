package Controllers;

import DAO.ProjetDAO;
import Model.Projet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/projet")  // Changé de "/projet/*" à "/projet"
public class ProjetServlet extends HttpServlet {
    ProjetDAO projetDao;

    @Override
    public void init() throws ServletException {
        projetDao = new ProjetDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "listprojet";  // Action par défaut si null
        }
        switch (action) {
            case "newprojet":
                showNewForm(req, resp);
                break;
            case "neweditform":
                try {
                    showEditForm(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "createprojet":
                ajoutProjet(req, resp);
                break;
            case "listprojet":
                listProjet(req, resp);
                break;
            case "updateprojet":
                try {
                    updateProjet(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "deleteprojet":
                supprimerProjet(req, resp);
                break;
            default:
                listProjet(req, resp);
                break;
        }
    }

    // Méthodes existantes inchangées...

    private void updateProjet(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("idProjet"));
        String nomProjet = request.getParameter("nomProjet");
        String description = request.getParameter("description");
        String dateDebut = request.getParameter("dateDebut");
        String dateFin = request.getParameter("datefin");
        float budget = Float.parseFloat(request.getParameter("budget"));

        System.out.println("Tentative de mise à jour - ID: " + id + ", Nom: " + nomProjet + ", Description: " + description +
                ", DateDébut: " + dateDebut + ", DateFin: " + dateFin + ", Budget: " + budget);

        Projet projet = new Projet(id, nomProjet, description, dateDebut, dateFin, budget);
        projetDao.updateProjet(projet);
        System.out.println("Projet mis à jour avec ID : " + id);
        response.sendRedirect(request.getContextPath() + "/projet?action=listprojet");
    }
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idProjet"));
        Projet existingProjet = projetDao.getProjet(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listprojet.jsp");
        request.setAttribute("projet", existingProjet);
        dispatcher.forward(request, response);
    }
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("listprojet.jsp");
        dispatcher.forward(request, response);
    }
    public void ajoutProjet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nomProjet = req.getParameter("nomProjet");
        String description = req.getParameter("description");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("datefin");
        float budget = Float.parseFloat(req.getParameter("budget"));
        Projet projet = new Projet(nomProjet, description, dateDebut, dateFin, budget);
        projetDao.insertProjet(projet);

        resp.sendRedirect(req.getContextPath() + "/projet?action=listprojet");
    }
    public void listProjet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Projet> projets=projetDao.getAllProjets();
        req.setAttribute("projets",projets);
        System.out.println("hello");
        RequestDispatcher dispatcher = req.getRequestDispatcher("listprojet.jsp");
        dispatcher.forward(req, resp);

    }
    public void supprimerProjet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        projetDao.deleteProjet(id);
        resp.sendRedirect(req.getContextPath() + "/projet?action=listprojet");

    }


}