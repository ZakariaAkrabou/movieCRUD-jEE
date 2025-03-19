package com.orange.moviemanagement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.orange.moviemanagement.dao.ActeurDAO;
import com.orange.moviemanagement.model.Acteur;
import com.orange.moviemanagment.config.DatabaseConnection;


@WebServlet("/ajouter-acteur")
public class ActeurAddServlet extends HttpServlet {
	 @Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        String nom = request.getParameter("nom");
	        String prenom = request.getParameter("prenom");
	        String nationalite = request.getParameter("nationalite");

	      
	        String erreur = null;
	        if (nom == null || nom.trim().isEmpty() || nom.length() > 50) {
	            erreur = "Le nom est invalide (vide ou trop long).";
	        } else if (prenom == null || prenom.trim().isEmpty() || prenom.length() > 50) {
	            erreur = "Le prénom est invalide (vide ou trop long).";
	        } else if (nationalite == null || nationalite.trim().isEmpty() || nationalite.length() > 50) {
	            erreur = "La nationalité est invalide (vide ou trop long).";
	        }

	        if (erreur != null) {
	            request.setAttribute("erreur", erreur);
	            request.getRequestDispatcher("/views/acteur/add.jsp").forward(request, response);
	            return;
	        }

	        try (Connection connection = DatabaseConnection.getConnection()) {
	            ActeurDAO acteurDAO = new ActeurDAO(connection);
	            Acteur acteur = new Acteur(0, nom, prenom, nationalite);
	            acteurDAO.ajouterActeur(acteur);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        response.sendRedirect(request.getContextPath() + "/acteurs");
	    }

}
