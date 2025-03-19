
// ProjectDao.java (Example - other DAOs are similar)
package com.constructionxpert.dao;

import com.constructionxpert.config.DBConnection;
import com.constructionxpert.model.Project;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDao {

    // Create
    public void createProject(Project project) {
        String sql = "INSERT INTO projects (name, description, start_date, end_date, budget, status, created_by) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, project.getName());
            stmt.setString(2, project.getDescription());
            stmt.setDate(3, project.getStartDate());
            stmt.setDate(4, project.getEndDate());
            stmt.setDouble(5, project.getBudget());
            stmt.setString(6, project.getStatus());
            stmt.setInt(7, project.getCreatedBy());
            stmt.executeUpdate();

            // Get the generated project ID
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    project.setProjectId(generatedKeys.getInt(1));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Log this
        }
    }


    // Read (Get all)
    public List<Project> getAllProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM projects";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Project project = new Project();
                project.setProjectId(rs.getInt("project_id"));
                project.setName(rs.getString("name"));
                project.setDescription(rs.getString("description"));
                project.setStartDate(rs.getDate("start_date"));
                project.setEndDate(rs.getDate("end_date"));
                project.setBudget(rs.getDouble("budget"));
                project.setStatus(rs.getString("status"));
                project.setCreatedAt(rs.getTimestamp("created_at"));
                project.setUpdatedAt(rs.getTimestamp("updated_at"));
                project.setCreatedBy(rs.getInt("created_by"));
                projects.add(project);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this
        }
        return projects;
    }

    // Read (Get by ID)
    public Project getProjectById(int projectId) {
        String sql = "SELECT * FROM projects WHERE project_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, projectId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Project project = new Project();
                    project.setProjectId(rs.getInt("project_id"));
                    project.setName(rs.getString("name"));
                    project.setDescription(rs.getString("description"));
                    project.setStartDate(rs.getDate("start_date"));
                    project.setEndDate(rs.getDate("end_date"));
                    project.setBudget(rs.getDouble("budget"));
                    project.setStatus(rs.getString("status"));
                    project.setCreatedAt(rs.getTimestamp("created_at"));
                    project.setUpdatedAt(rs.getTimestamp("updated_at"));
                    project.setCreatedBy(rs.getInt("created_by"));
                    return project;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log this
        }
        return null;
    }
    // Update
    public void updateProject(Project project) {
        String sql = "UPDATE projects SET name = ?, description = ?, start_date = ?, end_date = ?, budget = ?, status = ? WHERE project_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, project.getName());
            stmt.setString(2, project.getDescription());
            stmt.setDate(3, project.getStartDate());
            stmt.setDate(4, project.getEndDate());
            stmt.setDouble(5, project.getBudget());
            stmt.setString(6, project.getStatus());
            stmt.setInt(7, project.getProjectId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Log this
        }
    }

    // Delete
    public void deleteProject(int projectId) {
        String sql = "DELETE FROM projects WHERE project_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, projectId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Log this
        }
    }
    // Other CRUD methods for Project (getProjectById, updateProject, deleteProject)
    // Implement similar DAOs for TaskDao, ResourceDao, and SupplierDao.
}