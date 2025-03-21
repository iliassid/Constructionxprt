package com.constructionxpert.models;

import java.sql.Timestamp;

public class Ressource {
    private int id;
    private String nom;
    private String type;
    private int quantite;
    private String unite;
    private String description;
    private Integer fournisseurId;  // Allow nulls
    private Timestamp dateCreation;

    // Constructors, Getters, and Setters
    public Ressource() {}

    public Ressource(int id, String nom, String type, int quantite, String unite, String description, Integer fournisseurId, Timestamp dateCreation) {
        this.id = id;
        this.nom = nom;
        this.type = type;
        this.quantite = quantite;
        this.unite = unite;
        this.description = description;
        this.fournisseurId = fournisseurId;
        this.dateCreation = dateCreation;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getFournisseurId() {
        return fournisseurId;
    }

    public void setFournisseurId(Integer fournisseurId) {
        this.fournisseurId = fournisseurId;
    }

    public Timestamp getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Timestamp dateCreation) {
        this.dateCreation = dateCreation;
    }
    @Override
    public String toString() {
        return "Ressource{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", type='" + type + '\'' +
                ", quantite=" + quantite +
                ", unite='" + unite + '\'' +
                ", description='" + description + '\'' +
                ", fournisseurId=" + fournisseurId +
                ", dateCreation=" + dateCreation +
                '}';
    }
}