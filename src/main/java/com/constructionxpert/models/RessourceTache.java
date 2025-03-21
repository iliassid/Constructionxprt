package com.constructionxpert.models;

import java.sql.Timestamp;

public class RessourceTache {
    private int id;
    private int tacheId;
    private int ressourceId;
    private int quantiteUtilisee;
    private Timestamp dateAssignation;

    // Constructors
    public RessourceTache() {
    }

    public RessourceTache(int id, int tacheId, int ressourceId, int quantiteUtilisee, Timestamp dateAssignation) {
        this.id = id;
        this.tacheId = tacheId;
        this.ressourceId = ressourceId;
        this.quantiteUtilisee = quantiteUtilisee;
        this.dateAssignation = dateAssignation;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTacheId() {
        return tacheId;
    }

    public void setTacheId(int tacheId) {
        this.tacheId = tacheId;
    }

    public int getRessourceId() {
        return ressourceId;
    }

    public void setRessourceId(int ressourceId) {
        this.ressourceId = ressourceId;
    }

    public int getQuantiteUtilisee() {
        return quantiteUtilisee;
    }

    public void setQuantiteUtilisee(int quantiteUtilisee) {
        this.quantiteUtilisee = quantiteUtilisee;
    }

    public Timestamp getDateAssignation() {
        return dateAssignation;
    }

    public void setDateAssignation(Timestamp dateAssignation) {
        this.dateAssignation = dateAssignation;
    }

    @Override
    public String toString() {
        return "RessourceTache{" +
                "id=" + id +
                ", tacheId=" + tacheId +
                ", ressourceId=" + ressourceId +
                ", quantiteUtilisee=" + quantiteUtilisee +
                ", dateAssignation=" + dateAssignation +
                '}';
    }
}