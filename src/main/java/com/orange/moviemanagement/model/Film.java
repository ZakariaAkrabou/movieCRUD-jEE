package com.orange.moviemanagement.model;

public class Film {
    private int id;
    private String titre;
    private String description;
    private String genre;
    private int anneeSortie;
    private String poster;
    private int realisateurId;

    public Film(int id, String titre, String description, String genre, int anneeSortie, String poster, int realisateurId) {
        this.id = id;
        this.titre = titre;
        this.description = description;
        this.genre = genre;
        this.anneeSortie = anneeSortie;
        this.poster = poster;
        this.realisateurId = realisateurId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }
    public int getAnneeSortie() { return anneeSortie; }
    public void setAnneeSortie(int anneeSortie) { this.anneeSortie = anneeSortie; }
    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }
    public int getRealisateurId() { return realisateurId; }
    public void setRealisateurId(int realisateurId) { this.realisateurId = realisateurId; }
}