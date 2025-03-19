package com.orange.moviemanagement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.orange.moviemanagement.dao.RealisateurDAO;
import com.orange.moviemanagement.model.Realisateur;
import com.orange.moviemanagment.config.DatabaseConnection;



@WebServlet("/ajouter-realisateur")
public class RealisateurAddServlet extends HttpServlet {
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
            request.getRequestDispatcher("/views/realisateurs/add.jsp").forward(request, response);
            return;
        }

        try (Connection connection = DatabaseConnection.getConnection()) {
            RealisateurDAO realisateurDAO = new RealisateurDAO(connection);
            Realisateur realisateur = new Realisateur(0, nom, prenom, nationalite);
            realisateurDAO.ajouterRealisateur(realisateur);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/realisateurs");
    }
}