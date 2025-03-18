package com.constructionxpert.model;

import java.util.Date;  // Import java.util.Date
import java.sql.Timestamp;

// Admin.java
public class Admin {
    private int adminId;
    private String username;
    private String passwordHash; // Store hashed passwords!
    private String fullName;
    private String email;
    private Timestamp createdAt;
    private Timestamp lastLogin;

    // Constructors (at least a default one)
    public Admin() {}

    public Admin(int adminId, String username, String passwordHash, String fullName, String email, Timestamp createdAt, Timestamp lastLogin) {
        this.adminId = adminId;
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.email = email;
        this.createdAt = createdAt;
        this.lastLogin = lastLogin;
    }

    // Getters and setters (essential)
    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getLastLogin() { return lastLogin; }
    public void setLastLogin(Timestamp lastLogin) { this.lastLogin = lastLogin; }
}

