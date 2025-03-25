package DAO;

import Model.Projet;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjetDAO {
    private Connection connection;

    public ProjetDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/construction", "root", "");
            if (this.connection == null) {
                throw new SQLException("Failed to establish database connection!");
            }
            try (Statement statement = connection.createStatement()) {
                String createProjetTable = "CREATE TABLE IF NOT EXISTS projet (" +
                        "idProjet INT AUTO_INCREMENT PRIMARY KEY," +
                        "nomProjet VARCHAR(100) NOT NULL, " +
                        "description VARCHAR(100) NOT NULL, " +
                        "dateDebut DATE NOT NULL, " +
                        "datefin DATE NOT NULL, " +
                        "budget FLOAT NOT NULL " +
                        ")";
                statement.executeUpdate(createProjetTable);
                System.out.println("Table 'projet' créée avec succès (si elle n'existait pas).");
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public void insertProjet(Projet projet) {
        String insertUserQuery = "INSERT INTO projet (nomProjet, description, dateDebut, datefin, budget) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(insertUserQuery)) {
            preparedStatement.setString(1, projet.getNomProjet());
            preparedStatement.setString(2, projet.getDescription());
            preparedStatement.setString(3, projet.getDateDebut());
            preparedStatement.setString(4, projet.getDateFin());
            preparedStatement.setFloat(5, projet.getBudget());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Projet getProjet(int idProjet) {
        Projet projet = null;
        String select = "SELECT * FROM projet WHERE idProjet = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(select)) {
            preparedStatement.setInt(1, idProjet);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                projet = new Projet(
                        resultSet.getInt("idProjet"),
                        resultSet.getString("nomProjet"),
                        resultSet.getString("description"),
                        resultSet.getString("dateDebut"),
                        resultSet.getString("datefin"),
                        resultSet.getFloat("budget")
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return projet;
    }

    public List<Projet> getAllProjets() {
        List<Projet> projets = new ArrayList<Projet>();
        String select = "SELECT * FROM projet";
        try (PreparedStatement preparedStatement = connection.prepareStatement(select)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            System.out.println("ssss");
            while (resultSet.next()) {
                Projet projet = new Projet();
                projet.setIdProjet(resultSet.getInt("idProjet"));
                projet.setNomProjet(resultSet.getString("nomProjet"));
                projet.setDescription(resultSet.getString("description"));
                projet.setDateDebut(resultSet.getString("dateDebut"));
                projet.setDateFin(resultSet.getString("dateFin"));
                projet.setBudget(resultSet.getFloat("budget"));
                projets.add(projet);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return projets;
    }

    public void deleteProjet(int idProjet) {
        String delete = "DELETE FROM projet WHERE idProjet = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(delete)) {
            preparedStatement.setInt(1, idProjet);
            preparedStatement.executeUpdate();
            System.out.println("Projet supprimé");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateProjet(Projet projet) {
        String query = "UPDATE projet SET nomProjet = ?, description = ?, dateDebut = ?, datefin = ?, budget = ? WHERE idProjet = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, projet.getNomProjet());
            stmt.setString(2, projet.getDescription());
            stmt.setString(3, projet.getDateDebut());
            stmt.setString(4, projet.getDateFin());
            stmt.setFloat(5, projet.getBudget());
            stmt.setInt(6, projet.getIdProjet());
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Projet mis à jour avec succès ! " + rowsAffected + " ligne(s) affectée(s).");
        } catch (SQLException e) {
            System.out.println("Erreur lors de la mise à jour du projet : " + e.getMessage());
            e.printStackTrace(); // Ajout pour voir la stacktrace complète
        }
    }
}