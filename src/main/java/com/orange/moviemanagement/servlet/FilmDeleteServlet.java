// com.orange.moviemanagement.servlet.FilmDeleteServlet.java
package com.orange.moviemanagement.servlet;

import com.orange.moviemanagement.dao.FilmDAO;
import com.orange.moviemanagment.config.DatabaseConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/supprimer-film")
public class FilmDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int filmId = Integer.parseInt(request.getParameter("id"));
        try (Connection connection = DatabaseConnection.getConnection()) {
            FilmDAO filmDAO = new FilmDAO(connection);
            filmDAO.supprimerFilm(filmId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/films");
    }
}