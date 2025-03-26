package Controllers;

import DAO.ProjetDAO;
import Model.Projet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/projet")
public class ProjetServlet extends HttpServlet {
    private ProjetDAO projetDao;

    @Override
    public void init() throws ServletException {
        projetDao = new ProjetDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // Redirige les requêtes POST vers doGet
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "listprojet"; // Action par défaut
        }
        switch (action) {
            case "createprojet":
                ajoutProjet(req, resp);
                break;
            case "listprojet":
                listProjet(req, resp);
                break;
            case "updateprojet":
                updateProjet(req, resp);
                break;
            case "deleteprojet":
                supprimerProjet(req, resp);
                break;
            default:
                listProjet(req, resp);
                break;
        }
    }

    private void updateProjet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("idProjet"));
        String nomProjet = request.getParameter("nomProjet");
        String description = request.getParameter("description");
        String dateDebut = request.getParameter("dateDebut");
        String dateFin = request.getParameter("datefin");
        float budget = Float.parseFloat(request.getParameter("budget"));

        Projet projet = new Projet(id, nomProjet, description, dateDebut, dateFin, budget);
        projetDao.updateProjet(projet);
        response.sendRedirect(request.getContextPath() + "/projet?action=listprojet");
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
        List<Projet> projets = projetDao.getAllProjets();
        req.setAttribute("projets", projets);
        RequestDispatcher dispatcher = req.getRequestDispatcher("listprojet.jsp");
        dispatcher.forward(req, resp);
    }

    public void supprimerProjet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        projetDao.deleteProjet(id);
        resp.sendRedirect(req.getContextPath() + "/projet?action=listprojet");
    }
}