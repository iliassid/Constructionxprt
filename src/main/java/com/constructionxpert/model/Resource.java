package com.constructionxpert.model;

import java.sql.Timestamp;

public class Resource {
    private int resourceId;
    private String name;
    private String type; // Use String, not enum
    private int quantity;
    private String unit;
    private double costPerUnit;
    private int supplierId;
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String supplierName; // Added for user-friendly display


    // Constructors
    public Resource() {
    }

    public Resource(int resourceId, String name, String type, int quantity, String unit, double costPerUnit,
                    int supplierId, String notes, Timestamp createdAt, Timestamp updatedAt, String supplierName) {
        this.resourceId = resourceId;
        this.name = name;
        this.type = type;
        this.quantity = quantity;
        this.unit = unit;
        this.costPerUnit = costPerUnit;
        this.supplierId = supplierId;
        this.notes = notes;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.supplierName = supplierName;
    }

    // Getters and setters (essential for all fields)

    public int getResourceId() {
        return resourceId;
    }

    public void setResourceId(int resourceId) {
        this.resourceId = resourceId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public double getCostPerUnit() {
        return costPerUnit;
    }

    public void setCostPerUnit(double costPerUnit) {
        this.costPerUnit = costPerUnit;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}