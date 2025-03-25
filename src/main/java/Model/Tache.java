package Model;

public class Tache {
    private int id_tache;
    private String nom;
    private String date_debut;
    private String date_fin;
    private int id_projet;
    private String nomProjet;
    private int quantiteRessources; // Nouvelle variable pour la somme des quantités

    public Tache() {
        this.quantiteRessources = 0; // Initialisation à 0
    }

    public Tache(int id_tache, String nom, String date_debut, String date_fin, int id_projet, String nomProjet) {
        this.id_tache = id_tache;
        this.nom = nom;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
        this.id_projet = id_projet;
        this.nomProjet = nomProjet;
        this.quantiteRessources = 0;
    }

    public Tache(int id_tache, String nom, String date_debut, String date_fin, int id_projet) {
        this.id_tache = id_tache;
        this.nom = nom;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
        this.id_projet = id_projet;
        this.quantiteRessources = 0;
    }

    public Tache(String nom, String date_debut, String date_fin) {
        this.nom = nom;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
        this.quantiteRessources = 0;
    }

    public int getId_tache() {
        return id_tache;
    }

    public void setId_tache(int id_tache) {
        this.id_tache = id_tache;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(String date_debut) {
        this.date_debut = date_debut;
    }

    public String getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(String date_fin) {
        this.date_fin = date_fin;
    }

    public int getId_projet() {
        return id_projet;
    }

    public void setId_projet(int id_projet) {
        this.id_projet = id_projet;
    }

    public String getNomProjet() {
        return nomProjet;
    }

    public void setNomProjet(String nomProjet) {
        this.nomProjet = nomProjet;
    }

    public int getQuantiteRessources() {
        return quantiteRessources;
    }

    public void setQuantiteRessources(int quantiteRessources) {
        this.quantiteRessources = quantiteRessources;
    }

    @Override
    public String toString() {
        return "Tache{" +
                "id_tache=" + id_tache +
                ", nom='" + nom + '\'' +
                ", date_debut='" + date_debut + '\'' +
                ", date_fin='" + date_fin + '\'' +
                ", id_projet=" + id_projet +
                ", nomProjet='" + nomProjet + '\'' +
                ", quantiteRessources=" + quantiteRessources +
                '}';
    }
}