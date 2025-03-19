package com.orange.moviemanagement.servlet;

import com.orange.moviemanagement.dao.FilmDAO;
import com.orange.moviemanagement.model.Film;
import com.orange.moviemanagment.config.DatabaseConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/films-user")
public class FilmUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DatabaseConnection.getConnection()) {
            FilmDAO filmDAO = new FilmDAO(connection);
            List<Film> films = filmDAO.getTousLesFilms(); 
            request.setAttribute("films", films);
            request.getRequestDispatcher("/films_user.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}