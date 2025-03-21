package com.constructionxpert.dao;

import com.constructionxpert.models.Fournisseur;
import com.constructionxpert.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FournisseurDao {

    public void addFournisseur(Fournisseur fournisseur) throws SQLException {
        String sql = "INSERT INTO fournisseur (nom, contact, email, telephone, adresse) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, fournisseur.getNom());
            pstmt.setString(2, fournisseur.getContact());
            pstmt.setString(3, fournisseur.getEmail());
            pstmt.setString(4, fournisseur.getTelephone());
            pstmt.setString(5, fournisseur.getAdresse());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating fournisseur failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    fournisseur.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating fournisseur failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }

    public List<Fournisseur> getAllFournisseurs() throws SQLException {
        List<Fournisseur> fournisseurs = new ArrayList<>();
        String sql = "SELECT * FROM fournisseur";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Fournisseur fournisseur = new Fournisseur(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("contact"),
                        rs.getString("email"),
                        rs.getString("telephone"),
                        rs.getString("adresse"),
                        rs.getTimestamp("date_creation")
                );
                fournisseurs.add(fournisseur);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
        return fournisseurs;
    }

    public Fournisseur getFournisseurById(int id) throws SQLException {
        String sql = "SELECT * FROM fournisseur WHERE id = ?";
        Fournisseur fournisseur = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    fournisseur = new Fournisseur(
                            rs.getInt("id"),
                            rs.getString("nom"),
                            rs.getString("contact"),
                            rs.getString("email"),
                            rs.getString("telephone"),
                            rs.getString("adresse"),
                            rs.getTimestamp("date_creation")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
        return fournisseur;
    }

    public void updateFournisseur(Fournisseur fournisseur) throws SQLException {
        String sql = "UPDATE fournisseur SET nom = ?, contact = ?, email = ?, telephone = ?, adresse = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, fournisseur.getNom());
            pstmt.setString(2, fournisseur.getContact());
            pstmt.setString(3, fournisseur.getEmail());
            pstmt.setString(4, fournisseur.getTelephone());
            pstmt.setString(5, fournisseur.getAdresse());
            pstmt.setInt(6, fournisseur.getId());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }

    public void deleteFournisseur(int id) throws SQLException {
        String sql = "DELETE FROM fournisseur WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }
    // ... other CRUD methods ...
}