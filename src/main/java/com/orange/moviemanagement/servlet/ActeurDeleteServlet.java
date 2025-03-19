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
import com.orange.moviemanagment.config.DatabaseConnection;

/**
 * Servlet implementation class ActeurDeleteServlet
 */
@WebServlet("/delete-acteur")
public class ActeurDeleteServlet extends HttpServlet {
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DatabaseConnection.getConnection()) {
            ActeurDAO acteurDAO = new ActeurDAO(connection);
            acteurDAO.supprimerActeur(id);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/acteurs");
    }

}
