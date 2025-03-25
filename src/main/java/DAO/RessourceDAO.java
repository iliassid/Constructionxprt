package DAO;

import Model.Ressource;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RessourceDAO {
    private Connection connection;

    public RessourceDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/construction", "root", "");
            System.out.println("Connected to database");

            String createTableSQL = "CREATE TABLE IF NOT EXISTS ressource (" +
                    "id_ressource INT AUTO_INCREMENT PRIMARY KEY, " +
                    "nom VARCHAR(100) NOT NULL, " +
                    "type VARCHAR(50) NOT NULL, " +
                    "quantite INT NOT NULL, " +
                    "fournisseur VARCHAR(100) NOT NULL " +
                    ")";
            String createTacheRessourceTable = "CREATE TABLE IF NOT EXISTS tache_ressource (" +
                    "id_tache INT, " +
                    "id_ressource INT, " +
                    "quantite INT NOT NULL, " +
                    "PRIMARY KEY (id_tache, id_ressource), " +
                    "FOREIGN KEY (id_tache) REFERENCES tache(id_tache) ON DELETE CASCADE, " +
                    "FOREIGN KEY (id_ressource) REFERENCES ressource(id_ressource) ON DELETE CASCADE" +
                    ")";

            try (Statement statement = connection.createStatement()) {
                statement.executeUpdate(createTableSQL);
                statement.executeUpdate(createTacheRessourceTable);
                System.out.println("Tables 'ressource' et 'tache_ressource' prêtes.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void addRessource(Ressource ressource) {
        String query = "INSERT INTO ressource (nom, type, quantite, fournisseur) VALUES (?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, ressource.getNom());
            preparedStatement.setString(2, ressource.getType());
            preparedStatement.setInt(3, ressource.getQuantite());
            preparedStatement.setString(4, ressource.getFournisseur());
            preparedStatement.executeUpdate();
            System.out.println("Ressource ajoutée avec succès !");
        } catch (SQLException e) {
            System.out.println("Erreur lors de l'ajout de la ressource: " + e.getMessage());
        }
    }

    public Ressource getRessourceById(int id) {
        Ressource ressource = null;
        String query = "SELECT * FROM ressource WHERE id_ressource = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ressource = new Ressource(
                            rs.getInt("id_ressource"),
                            rs.getString("nom"),
                            rs.getString("type"),
                            rs.getInt("quantite"),
                            rs.getString("fournisseur")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Erreur lors de la récupération de la ressource: " + e.getMessage());
        }
        return ressource;
    }

    public List<Ressource> getAllRessources() {
        List<Ressource> listRessources = new ArrayList<>();
        String query = "SELECT * FROM ressource";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Ressource ressource = new Ressource(
                        rs.getInt("id_ressource"),
                        rs.getString("nom"),
                        rs.getString("type"),
                        rs.getInt("quantite"),
                        rs.getString("fournisseur")
                );
                listRessources.add(ressource);
            }
        } catch (SQLException e) {
            System.out.println("Erreur lors de la récupération des ressources: " + e.getMessage());
        }
        return listRessources;
    }

    public void updateRessource(Ressource ressource) {
        String query = "UPDATE ressource SET nom = ?, type = ?, quantite = ?, fournisseur = ? WHERE id_ressource = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, ressource.getNom());
            stmt.setString(2, ressource.getType());
            stmt.setInt(3, ressource.getQuantite());
            stmt.setString(4, ressource.getFournisseur());
            stmt.setInt(5, ressource.getId_ressource());
            stmt.executeUpdate();
            System.out.println("Ressource mise à jour avec succès !");
        } catch (SQLException e) {
            System.out.println("Erreur lors de la mise à jour de la ressource: " + e.getMessage());
        }
    }

    public void deleteRessource(int id) {
        String query = "DELETE FROM ressource WHERE id_ressource = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            System.out.println("Ressource supprimée avec succès !");
        } catch (SQLException e) {
            System.out.println("Erreur lors de la suppression de la ressource: " + e.getMessage());
        }
    }

    // Nouvelle méthode pour assigner une ressource à une tâche
    public void assignerRessource(int idTache, int idRessource, int quantite) throws SQLException {
        connection.setAutoCommit(false); // Début de la transaction
        try {
            // Vérifier la quantité disponible
            String checkQuery = "SELECT quantite FROM ressource WHERE id_ressource = ?";
            try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
                checkStmt.setInt(1, idRessource);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    int quantiteDisponible = rs.getInt("quantite");
                    if (quantiteDisponible < quantite) {
                        throw new SQLException("Quantité insuffisante pour la ressource ID " + idRessource);
                    }
                } else {
                    throw new SQLException("Ressource ID " + idRessource + " non trouvée");
                }
            }

            // Insérer dans tache_ressource
            String insertQuery = "INSERT INTO tache_ressource (id_tache, id_ressource, quantite) VALUES (?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE quantite = quantite + VALUES(quantite)";
            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
                insertStmt.setInt(1, idTache);
                insertStmt.setInt(2, idRessource);
                insertStmt.setInt(3, quantite);
                insertStmt.executeUpdate();
            }

            // Mettre à jour la quantité dans ressource
            String updateQuery = "UPDATE ressource SET quantite = quantite - ? WHERE id_ressource = ?";
            try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                updateStmt.setInt(1, quantite);
                updateStmt.setInt(2, idRessource);
                updateStmt.executeUpdate();
            }

            connection.commit(); // Valider la transaction
            System.out.println("Ressource assignée à la tâche ID " + idTache + " avec succès !");
        } catch (SQLException e) {
            connection.rollback(); // Annuler en cas d'erreur
            throw e;
        } finally {
            connection.setAutoCommit(true); // Réactiver l'auto-commit
        }
    }
}