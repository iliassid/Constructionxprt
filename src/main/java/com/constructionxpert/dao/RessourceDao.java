package com.constructionxpert.dao;

import com.constructionxpert.models.Ressource;
import com.constructionxpert.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RessourceDao {

    public void addRessource(Ressource ressource) throws SQLException {
        String sql = "INSERT INTO ressource (nom, type, quantite, unite, description, fournisseur_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, ressource.getNom());
            pstmt.setString(2, ressource.getType());
            pstmt.setInt(3, ressource.getQuantite());
            pstmt.setString(4, ressource.getUnite());
            pstmt.setString(5, ressource.getDescription());
            // Handle potential null for fournisseur_id
            if (ressource.getFournisseurId() != null) {
                pstmt.setInt(6, ressource.getFournisseurId());
            } else {
                pstmt.setNull(6, Types.INTEGER);
            }

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating ressource failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    ressource.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating ressource failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }

    public List<Ressource> getAllRessources() throws SQLException {
        List<Ressource> ressources = new ArrayList<>();
        String sql = "SELECT * FROM ressource";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Ressource ressource = new Ressource(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("type"),
                        rs.getInt("quantite"),
                        rs.getString("unite"),
                        rs.getString("description"),
                        // Handle potential null for fournisseur_id
                        rs.getInt("fournisseur_id"), // Use getInt - JDBC handles null to 0
                        rs.getTimestamp("date_creation")
                );
                ressources.add(ressource);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ressources;
    }
    public Ressource getRessourceById(int id) throws SQLException {
        Ressource ressource = null;
        String sql = "SELECT * FROM ressource WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ressource = new Ressource(
                            rs.getInt("id"),
                            rs.getString("nom"),
                            rs.getString("type"),
                            rs.getInt("quantite"),
                            rs.getString("unite"),
                            rs.getString("description"),
                            rs.getInt("fournisseur_id"), // Use getInt
                            rs.getTimestamp("date_creation")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ressource;
    }

    public void updateRessource(Ressource ressource) throws SQLException {
        String sql = "UPDATE ressource SET nom = ?, type = ?, quantite = ?, unite = ?, description = ?, fournisseur_id = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, ressource.getNom());
            pstmt.setString(2, ressource.getType());
            pstmt.setInt(3, ressource.getQuantite());
            pstmt.setString(4, ressource.getUnite());
            pstmt.setString(5, ressource.getDescription());
            if (ressource.getFournisseurId() != null) {
                pstmt.setInt(6, ressource.getFournisseurId());
            } else {
                pstmt.setNull(6, Types.INTEGER);
            }
            pstmt.setInt(7, ressource.getId());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteRessource(int id) throws SQLException {
        String sql = "DELETE FROM ressource WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateRessourceQuantity(int ressourceId, int newQuantity) throws SQLException {
        String sql = "UPDATE ressource SET quantite = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, ressourceId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log and handle appropriately
        }
    }
}