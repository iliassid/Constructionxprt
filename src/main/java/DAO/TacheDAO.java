package DAO;

import Model.Tache;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TacheDAO {

    private Connection connection;

    public TacheDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/construction", "root", "");
            if (this.connection == null) {
                throw new SQLException("Failed to establish database connection!");
            }
            try (Statement statement = connection.createStatement()) {
                String createTacheTable = "CREATE TABLE IF NOT EXISTS tache (" +
                        "id_tache INT AUTO_INCREMENT PRIMARY KEY, " +
                        "nom VARCHAR(100) NOT NULL, " +
                        "date_debut DATE NOT NULL, " +
                        "date_fin DATE NOT NULL, " +
                        "id_projet INT, " +
                        "FOREIGN KEY (id_projet) REFERENCES projet(idProjet) ON DELETE SET NULL" +
                        ")";
                statement.executeUpdate(createTacheTable);
                System.out.println("Table 'tache' créée avec succès (si elle n'existait pas).");

                try (ResultSet rs = connection.getMetaData().getColumns(null, null, "tache", "id_projet")) {
                    if (!rs.next()) {
                        statement.executeUpdate("ALTER TABLE tache " +
                                "ADD COLUMN id_projet INT, " +
                                "ADD FOREIGN KEY (id_projet) REFERENCES projet(idProjet) ON DELETE SET NULL");
                        System.out.println("Colonne 'id_projet' ajoutée à la table 'tache'.");
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public void insertTache(Tache tache) {
        String insertQuery = "INSERT INTO tache (nom, date_debut, date_fin, id_projet) VALUES (?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
            preparedStatement.setString(1, tache.getNom());
            preparedStatement.setString(2, tache.getDate_debut());
            preparedStatement.setString(3, tache.getDate_fin());
            preparedStatement.setInt(4, tache.getId_projet());
            preparedStatement.executeUpdate();
            System.out.println("Tâche ajoutée avec succès !");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Tache getTache(int idTache) {
        Tache tache = null;
        String select = "SELECT t.*, p.nomProjet, " +
                "COALESCE((SELECT SUM(tr.quantite) FROM tache_ressource tr WHERE tr.id_tache = t.id_tache), 0) AS quantite_ressources " +
                "FROM tache t " +
                "LEFT JOIN projet p ON t.id_projet = p.idProjet " +
                "WHERE t.id_tache = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(select)) {
            preparedStatement.setInt(1, idTache);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                tache = new Tache(
                        resultSet.getInt("id_tache"),
                        resultSet.getString("nom"),
                        resultSet.getString("date_debut"),
                        resultSet.getString("date_fin"),
                        resultSet.getInt("id_projet"),
                        resultSet.getString("nomProjet")
                );
                tache.setQuantiteRessources(resultSet.getInt("quantite_ressources"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tache;
    }

    public List<Tache> getAllTaches() {
        List<Tache> taches = new ArrayList<>();
        String select = "SELECT t.*, p.nomProjet, " +
                "COALESCE((SELECT SUM(tr.quantite) FROM tache_ressource tr WHERE tr.id_tache = t.id_tache), 0) AS quantite_ressources " +
                "FROM tache t " +
                "LEFT JOIN projet p ON t.id_projet = p.idProjet";
        try (PreparedStatement preparedStatement = connection.prepareStatement(select)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            System.out.println("Récupération des tâches");
            while (resultSet.next()) {
                Tache tache = new Tache();
                tache.setId_tache(resultSet.getInt("id_tache"));
                tache.setNom(resultSet.getString("nom"));
                tache.setDate_debut(resultSet.getString("date_debut"));
                tache.setDate_fin(resultSet.getString("date_fin"));
                tache.setId_projet(resultSet.getInt("id_projet"));
                tache.setNomProjet(resultSet.getString("nomProjet"));
                tache.setQuantiteRessources(resultSet.getInt("quantite_ressources"));
                taches.add(tache);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return taches;
    }

    public void deleteTache(int idTache) {
        String delete = "DELETE FROM tache WHERE id_tache = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(delete)) {
            preparedStatement.setInt(1, idTache);
            preparedStatement.executeUpdate();
            System.out.println("Tâche supprimée");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateTache(Tache tache) {
        String query = "UPDATE tache SET nom = ?, date_debut = ?, date_fin = ?, id_projet = ? WHERE id_tache = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, tache.getNom());
            stmt.setString(2, tache.getDate_debut());
            stmt.setString(3, tache.getDate_fin());
            stmt.setInt(4, tache.getId_projet());
            stmt.setInt(5, tache.getId_tache());
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Tâche mise à jour avec succès ! " + rowsAffected + " ligne(s) affectée(s).");
        } catch (SQLException e) {
            System.out.println("Erreur lors de la mise à jour de la tâche : " + e.getMessage());
            e.printStackTrace();
        }
    }
}