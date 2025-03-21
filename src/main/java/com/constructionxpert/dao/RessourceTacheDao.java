package com.constructionxpert.dao;

import com.constructionxpert.models.RessourceTache;
import com.constructionxpert.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RessourceTacheDao {

    public void addRessourceTache(RessourceTache ressourceTache) throws SQLException {
        String sql = "INSERT INTO ressource_tache (tache_id, ressource_id, quantite_utilisee) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, ressourceTache.getTacheId());
            pstmt.setInt(2, ressourceTache.getRessourceId());
            pstmt.setInt(3, ressourceTache.getQuantiteUtilisee());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating ressource_tache failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    ressourceTache.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating ressource_tache failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<RessourceTache> getAllRessourceTachesByTacheId(int tacheId) throws SQLException {
        List<RessourceTache> ressourceTaches = new ArrayList<>();
        String sql = "SELECT * FROM ressource_tache WHERE tache_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, tacheId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RessourceTache ressourceTache = new RessourceTache(
                            rs.getInt("id"),
                            rs.getInt("tache_id"),
                            rs.getInt("ressource_id"),
                            rs.getInt("quantite_utilisee"),
                            rs.getTimestamp("date_assignation")
                    );
                    ressourceTaches.add(ressourceTache);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log and handle the exception
        }
        return ressourceTaches;
    }
    // Add delete and update if necessary.  Keep it minimal if not used.
    public void deleteRessourceTache(int tacheId, int ressourceId) throws SQLException {
        String sql = "DELETE FROM ressource_tache WHERE tache_id = ? AND ressource_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, tacheId);
            pstmt.setInt(2, ressourceId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }
}