package com.constructionxpert.dao;

import com.constructionxpert.models.Projet;
import com.constructionxpert.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjetDao {

    public void addProjet(Projet projet) throws SQLException {
        String sql = "INSERT INTO projet (nom, description, date_debut, date_fin, budget, statut, administrateur_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, projet.getNom());
            pstmt.setString(2, projet.getDescription());
            pstmt.setDate(3, projet.getDateDebut());
            pstmt.setDate(4, projet.getDateFin());
            pstmt.setDouble(5, projet.getBudget());
            pstmt.setString(6, projet.getStatut());
            pstmt.setInt(7, projet.getAdministrateurId());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating projet failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    projet.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating projet failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }

    public List<Projet> getAllProjets() throws SQLException {
        List<Projet> projets = new ArrayList<>();
        String sql = "SELECT * FROM projet";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Projet projet = new Projet(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDate("date_debut"),
                        rs.getDate("date_fin"),
                        rs.getDouble("budget"),
                        rs.getString("statut"),
                        rs.getInt("administrateur_id"),
                        rs.getTimestamp("date_creation")
                );
                projets.add(projet);
            }
        }  catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
        return projets;
    }


    public Projet getProjetById(int id) throws SQLException {
        Projet projet = null;
        String sql = "SELECT * FROM projet WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    projet = new Projet(
                            rs.getInt("id"),
                            rs.getString("nom"),
                            rs.getString("description"),
                            rs.getDate("date_debut"),
                            rs.getDate("date_fin"),
                            rs.getDouble("budget"),
                            rs.getString("statut"),
                            rs.getInt("administrateur_id"),
                            rs.getTimestamp("date_creation")
                    );
                }
            }
        }  catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
        return projet;
    }

    public void updateProjet(Projet projet) throws SQLException {
        String sql = "UPDATE projet SET nom = ?, description = ?, date_debut = ?, date_fin = ?, budget = ?, statut = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, projet.getNom());
            pstmt.setString(2, projet.getDescription());
            pstmt.setDate(3, projet.getDateDebut());
            pstmt.setDate(4, projet.getDateFin());
            pstmt.setDouble(5, projet.getBudget());
            pstmt.setString(6, projet.getStatut());
            pstmt.setInt(7, projet.getId());
            pstmt.executeUpdate();
        }  catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }

    public void deleteProjet(int id) throws SQLException {
        String sql = "DELETE FROM projet WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }
}