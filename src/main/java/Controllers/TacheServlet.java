package Controllers;

import DAO.TacheDAO;
import Model.Tache;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/tache")
public class TacheServlet extends HttpServlet {
    private TacheDAO tacheDao;

    @Override
    public void init() throws ServletException {
        tacheDao = new TacheDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // Redirige les requêtes POST vers doGet
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "listtache"; // Action par défaut
        }
        switch (action) {
            case "newtache":
                showNewForm(req, resp);
                break;
            case "createtache":
                ajoutTache(req, resp);
                break;
            case "listtache":
                listTache(req, resp);
                break;
            case "updatetache":
                updateTache(req, resp);
                break;
            case "deletetache":
                supprimerTache(req, resp);
                break;
            default:
                listTache(req, resp);
                break;
        }
    }

    private void updateTache(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id_tache"));
        String nom = request.getParameter("nom");
        String dateDebut = request.getParameter("date_debut");
        String dateFin = request.getParameter("date_fin");

        Tache tache = new Tache(id, nom, dateDebut, dateFin);
        tacheDao.updateTache(tache);
        response.sendRedirect(request.getContextPath() + "/tache?action=listtache");
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("listtache.jsp");
        dispatcher.forward(request, response);
    }

    public void ajoutTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String dateDebut = req.getParameter("date_debut");
        String dateFin = req.getParameter("date_fin");

        Tache tache = new Tache(nom, dateDebut, dateFin);
        tacheDao.insertTache(tache);
        resp.sendRedirect(req.getContextPath() + "/tache?action=listtache");
    }

    public void listTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Tache> taches = tacheDao.getAllTaches();
        req.setAttribute("taches", taches);
        RequestDispatcher dispatcher = req.getRequestDispatcher("listtache.jsp");
        dispatcher.forward(req, resp);
    }

    public void supprimerTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        tacheDao.deleteTache(id);
        resp.sendRedirect(req.getContextPath() + "/tache?action=listtache");
    }
}