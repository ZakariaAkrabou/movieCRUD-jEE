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
import com.orange.moviemanagment.config.DatabaseConnection;



@WebServlet("/supprimer-realisateur")
public class RealisateurDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DatabaseConnection.getConnection()) {
            RealisateurDAO realisateurDAO = new RealisateurDAO(connection);
            realisateurDAO.supprimerRealisateur(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/realisateurs");
    }
}