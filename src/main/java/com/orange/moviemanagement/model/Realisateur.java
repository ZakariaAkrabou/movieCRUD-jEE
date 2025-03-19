package com.orange.moviemanagement.model;

public class Realisateur {

    private int id;
    private String nom;
    private String prenom;
    private String nationalite;

    public Realisateur() {}

    public Realisateur(int id, String nom, String prenom, String nationalite) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.nationalite = nationalite;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getNationalite() { return nationalite; }
    public void setNationalite(String nationalite) { this.nationalite = nationalite; }
}