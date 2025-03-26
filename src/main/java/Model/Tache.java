package Model;

public class Tache {
    private int id_tache;
    private String nom;
    private String date_debut;
    private String date_fin;

    public Tache() {}

    public Tache(String nom, String date_debut, String date_fin) {
        this.nom = nom;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
    }

    public Tache(int id_tache, String nom, String date_debut, String date_fin) {
        this.id_tache = id_tache;
        this.nom = nom;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
    }

    // Getters et setters
    public int getId_tache() { return id_tache; }
    public void setId_tache(int id_tache) { this.id_tache = id_tache; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getDate_debut() { return date_debut; }
    public void setDate_debut(String date_debut) { this.date_debut = date_debut; }
    public String getDate_fin() { return date_fin; }
    public void setDate_fin(String date_fin) { this.date_fin = date_fin; }
}