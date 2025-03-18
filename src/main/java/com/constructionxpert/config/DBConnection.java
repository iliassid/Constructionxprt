package com.constructionxpert.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/constructionxpert_db";
    private static final String USERNAME = "root"; // Replace
    private static final String PASSWORD = ""; // Replace

    private static Connection connection;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load the driver
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            } catch (ClassNotFoundException e) {
                throw new SQLException("MySQL JDBC Driver not found", e);
            }
        }
        return connection;
    }

    // Optional:  Method to close the connection (best practice, but managed by the container often)
    public static void closeConnection() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}