package com.constructionxpert.dao;

import com.constructionxpert.config.DBConnection;
import com.constructionxpert.model.Admin;
import java.sql.*;

public class AdminDao {

    public Admin getAdminByUsername(String username) {
        String sql = "SELECT * FROM administrators WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("admin_id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setPasswordHash(rs.getString("password_hash"));
                    admin.setFullName(rs.getString("full_name"));
                    admin.setEmail(rs.getString("email"));
                    admin.setCreatedAt(rs.getTimestamp("created_at"));
                    admin.setLastLogin(rs.getTimestamp("last_login"));
                    return admin;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly in a real application
        }
        return null; // Return null if no admin is found
    }

    // Example: Update last login timestamp
    public void updateLastLogin(int adminId) {
        String sql = "UPDATE administrators SET last_login = CURRENT_TIMESTAMP WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, adminId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Add other methods as needed (e.g., createAdmin, updateAdmin, etc.)
}
