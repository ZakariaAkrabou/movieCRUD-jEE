package com.orange.moviemanagement.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.orange.moviemanagement.model.Realisateur;

public class RealisateurDAO {
    private Connection connection;

    public RealisateurDAO(Connection connection) {
        this.connection = connection;
    }

    public void ajouterRealisateur(Realisateur realisateur) throws SQLException {
        String sql = "INSERT INTO realisateur (nom, prenom, nationalite) VALUES (?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, realisateur.getNom());
        stmt.setString(2, realisateur.getPrenom());
        stmt.setString(3, realisateur.getNationalite());
        stmt.executeUpdate();
    }

    public List<Realisateur> getTousLesRealisateurs() throws SQLException {
        List<Realisateur> realisateurs = new ArrayList<>();
        String sql = "SELECT * FROM realisateur";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        
        while (rs.next()) {
            Realisateur realisateur = new Realisateur(
                rs.getInt("id"),
                rs.getString("nom"),
                rs.getString("prenom"),
                rs.getString("nationalite")
            );
            realisateurs.add(realisateur);
        }
        return realisateurs;
    }

    public void modifierRealisateur(Realisateur realisateur) throws SQLException {
        String sql = "UPDATE realisateur SET nom = ?, prenom = ?, nationalite = ? WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, realisateur.getNom());
        stmt.setString(2, realisateur.getPrenom());
        stmt.setString(3, realisateur.getNationalite());
        stmt.setInt(4, realisateur.getId());
        stmt.executeUpdate();
    }

    public void supprimerRealisateur(int id) throws SQLException {
        String sql = "DELETE FROM realisateur WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public Realisateur getRealisateurById(int id) throws SQLException {
        String sql = "SELECT * FROM realisateur WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            return new Realisateur(
                rs.getInt("id"),
                rs.getString("nom"),
                rs.getString("prenom"),
                rs.getString("nationalite")
            );
        }
        return null;
    }

}