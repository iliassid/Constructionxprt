package com.constructionxpert.dao;

import com.constructionxpert.config.DBConnection;
import com.constructionxpert.model.Resource;
import com.constructionxpert.model.Supplier;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResourceDao {

    public void createResource (Resource resource) throws SQLException {

        String sql = "INSERT INTO resource (name, type, quantity, unit, cost_per_unit, supplier_id, notes) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){

            stmt.setString(1, resource.getName());
            stmt.setString(2, resource.getType());
            stmt.setInt(3, resource.getQuantity());
            stmt.setString(4, resource.getUnit());
            stmt.setDouble(5, resource.getCostPerUnit());
            stmt.setInt(6, resource.getSupplierId());
            stmt.setString(7, resource.getNotes());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    resource.setResourceId(generatedKeys.getInt(1));
                }
            }

        }catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Resource> getAllResources () throws SQLException {
        List<Resource> resources = new ArrayList<>();
        String sql = "SELECT r.*, s.name AS supplier_name FROM resources r LEFT JOIN suppliers s ON r.supplier_id = s.supplier_id";
        try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()){
            while (rs.next()) {
                Resource resource = new Resource();
                resource.setResourceId(rs.getInt("resource_id"));
                resource.setName(rs.getString("name"));
                resource.setType(rs.getString("type"));
                resource.setQuantity(rs.getInt("quantity"));
                resource.setUnit(rs.getString("unit"));
                resource.setCostPerUnit(rs.getDouble("cost_per_unit"));
                resource.setSupplierId(rs.getInt("supplier_id"));
                resource.setNotes(rs.getString("notes"));
                resource.setCreatedAt(rs.getTimestamp("created_at"));
                resource.setUpdatedAt(rs.getTimestamp("updated_at"));

                resource.setSupplierName(rs.getString("supplier_name"));
                resources.add(resource);
            }

        }catch (SQLException e) {
            e.printStackTrace();
        }
        return resources;
    }


    public Resource getResourceById(int resourceId) {
        String sql = "SELECT r.*, s.name AS supplier_name FROM resources r LEFT JOIN suppliers s ON r.supplier_id = s.supplier_id WHERE r.resource_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, resourceId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Resource resource = new Resource();
                    resource.setResourceId(rs.getInt("resource_id"));
                    resource.setName(rs.getString("name"));
                    resource.setType(rs.getString("type"));
                    resource.setQuantity(rs.getInt("quantity"));
                    resource.setUnit(rs.getString("unit"));
                    resource.setCostPerUnit(rs.getDouble("cost_per_unit"));
                    resource.setSupplierId(rs.getInt("supplier_id"));
                    resource.setNotes(rs.getString("notes"));
                    resource.setCreatedAt(rs.getTimestamp("created_at"));
                    resource.setUpdatedAt(rs.getTimestamp("updated_at"));
                    resource.setSupplierName(rs.getString("supplier_name")); // Get supplier name
                    return resource;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    public void updateResource(Resource resource) {
        String sql = "UPDATE resources SET name = ?, type = ?, quantity = ?, unit = ?, cost_per_unit = ?, supplier_id = ?, notes = ? WHERE resource_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, resource.getName());
            stmt.setString(2, resource.getType());
            stmt.setInt(3, resource.getQuantity());
            stmt.setString(4, resource.getUnit());
            stmt.setDouble(5, resource.getCostPerUnit());
            stmt.setInt(6, resource.getSupplierId());
            stmt.setString(7, resource.getNotes());
            stmt.setInt(8, resource.getResourceId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void deleteResource(int resourceId) {
        String sql = "DELETE FROM resources WHERE resource_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, resourceId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateResourceQuantity(int resourceId, int quantityChange, Connection conn) throws SQLException {
        String sql = "UPDATE resources SET quantity = quantity + ? WHERE resource_id = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, quantityChange);
            stmt.setInt(2, resourceId);
            stmt.executeUpdate();
        }finally {
            if (stmt != null) {
                stmt.close(); // Close in a finally block!
            }
        }
    }

}