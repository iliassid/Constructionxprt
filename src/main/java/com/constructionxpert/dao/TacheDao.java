package com.constructionxpert.dao;

import com.constructionxpert.models.Tache;
import com.constructionxpert.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TacheDao {

    public void addTache(Tache tache) throws SQLException {
        String sql = "INSERT INTO tache (description, date_debut, date_fin, statut, projet_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, tache.getDescription());
            pstmt.setDate(2, tache.getDateDebut());
            pstmt.setDate(3, tache.getDateFin());
            pstmt.setString(4, tache.getStatut());
            pstmt.setInt(5, tache.getProjetId());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating tache failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    tache.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating tache failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Tache> getAllTachesByProjectId(int projetId) throws SQLException {
        List<Tache> taches = new ArrayList<>();
        String sql = "SELECT * FROM tache WHERE projet_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, projetId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Tache tache = new Tache(
                            rs.getInt("id"),
                            rs.getString("description"),
                            rs.getDate("date_debut"),
                            rs.getDate("date_fin"),
                            rs.getString("statut"),
                            rs.getInt("projet_id"),
                            rs.getTimestamp("date_creation")
                    );
                    taches.add(tache);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return taches;
    }

    public Tache getTacheById(int id) throws SQLException {
        Tache tache = null;
        String sql = "SELECT * FROM tache WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    tache = new Tache(
                            rs.getInt("id"),
                            rs.getString("description"),
                            rs.getDate("date_debut"),
                            rs.getDate("date_fin"),
                            rs.getString("statut"),
                            rs.getInt("projet_id"),
                            rs.getTimestamp("date_creation")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tache;
    }

    public void updateTache(Tache tache) throws SQLException {
        String sql = "UPDATE tache SET description = ?, date_debut = ?, date_fin = ?, statut = ?, projet_id = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, tache.getDescription());
            pstmt.setDate(2, tache.getDateDebut());
            pstmt.setDate(3, tache.getDateFin());
            pstmt.setString(4, tache.getStatut());
            pstmt.setInt(5, tache.getProjetId());
            pstmt.setInt(6, tache.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void deleteTache(int id) throws SQLException {
        String sql = "DELETE FROM tache WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public List<Tache> getAllTaches() throws SQLException { // Method to get all tasks
        List<Tache> taches = new ArrayList<>();
        String sql = "SELECT * FROM tache";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Tache tache = new Tache();
                tache.setId(rs.getInt("id"));
                tache.setDescription(rs.getString("description"));
                tache.setDateDebut(rs.getDate("date_debut"));
                tache.setDateFin(rs.getDate("date_fin"));
                tache.setStatut(rs.getString("statut"));
                tache.setProjetId(rs.getInt("projet_id"));
                tache.setDateCreation(rs.getTimestamp("date_creation"));
                taches.add(tache);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
        return taches;
    }
}