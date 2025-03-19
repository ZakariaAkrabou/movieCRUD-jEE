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

@WebServlet("/modifier-realisateur")
public class RealisateurEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DatabaseConnection.getConnection()) {
            RealisateurDAO realisateurDAO = new RealisateurDAO(connection);
            Realisateur realisateur = realisateurDAO.getRealisateurById(id);
            request.setAttribute("realisateur", realisateur);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/views/realisateurs/edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String nationalite = request.getParameter("nationalite");

        try (Connection connection = DatabaseConnection.getConnection()) {
            RealisateurDAO realisateurDAO = new RealisateurDAO(connection);
            Realisateur realisateur = new Realisateur(id, nom, prenom, nationalite);
            realisateurDAO.modifierRealisateur(realisateur);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/realisateurs");
    }
}