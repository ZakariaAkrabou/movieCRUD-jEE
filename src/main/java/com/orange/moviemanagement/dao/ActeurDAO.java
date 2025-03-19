package com.orange.moviemanagement.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.orange.moviemanagement.model.Acteur;




public class ActeurDAO {
	private Connection connection;
	public ActeurDAO(Connection connection) {
		 this.connection = connection;
	}
	
	 public void ajouterActeur(Acteur acteur) throws SQLException {
	        String sql = "INSERT INTO acteur (nom, prenom, nationalite) VALUES (?, ?, ?)";
	        PreparedStatement stmt = connection.prepareStatement(sql);
	        stmt.setString(1, acteur.getNom());
	        stmt.setString(2, acteur.getPrenom());
	        stmt.setString(3, acteur.getNationalite());
	        stmt.executeUpdate();
	    }
	 
	 public List<Acteur> getTousLesActeurs() throws SQLException {
	        List<Acteur> acteurs = new ArrayList<>();
	        String sql = "SELECT * FROM acteur";
	        Statement stmt = connection.createStatement();
	        ResultSet rs = stmt.executeQuery(sql);
	        
	        while (rs.next()) {
	        	Acteur acteur = new Acteur(
	                rs.getInt("id"),
	                rs.getString("nom"),
	                rs.getString("prenom"),
	                rs.getString("nationalite")
	            );
	        	acteurs.add(acteur);
	        }
	        return acteurs;
	    }
	 
	 public void modifierActeur(Acteur acteur) throws SQLException {
	        String sql = "UPDATE acteur SET nom = ?, prenom = ?, nationalite = ? WHERE id = ?";
	        PreparedStatement stmt = connection.prepareStatement(sql);
	        stmt.setString(1, acteur.getNom());
	        stmt.setString(2, acteur.getPrenom());
	        stmt.setString(3, acteur.getNationalite());
	        stmt.setInt(4, acteur.getId());
	        stmt.executeUpdate();
	    }

	 public void supprimerActeur(int id) throws SQLException {
	        String sql = "DELETE FROM acteur WHERE id = ?";
	        PreparedStatement stmt = connection.prepareStatement(sql);
	        stmt.setInt(1, id);
	        stmt.executeUpdate();
	    }

	 public Acteur getActeurById(int id) throws SQLException {
	        String sql = "SELECT * FROM  acteur WHERE id = ?";
	        PreparedStatement stmt = connection.prepareStatement(sql);
	        stmt.setInt(1, id);
	        ResultSet rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            return new Acteur(
	                rs.getInt("id"),
	                rs.getString("nom"),
	                rs.getString("prenom"),
	                rs.getString("nationalite")
	            );
	        }
	        return null;
	    }


}
