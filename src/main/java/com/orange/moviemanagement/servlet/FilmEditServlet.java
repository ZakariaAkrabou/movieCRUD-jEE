package com.orange.moviemanagement.servlet;

import com.orange.moviemanagement.dao.ActeurDAO;
import com.orange.moviemanagement.dao.FilmDAO;
import com.orange.moviemanagement.dao.RealisateurDAO;
import com.orange.moviemanagement.model.Acteur;
import com.orange.moviemanagement.model.Film;
import com.orange.moviemanagement.model.Realisateur;
import com.orange.moviemanagment.config.DatabaseConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/modifier-film")
public class FilmEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int filmId = Integer.parseInt(request.getParameter("id"));
        try (Connection connection = DatabaseConnection.getConnection()) {
            FilmDAO filmDAO = new FilmDAO(connection);
            ActeurDAO acteurDAO = new ActeurDAO(connection);
            RealisateurDAO realisateurDAO = new RealisateurDAO(connection);
            Film film = filmDAO.getFilmById(filmId);
            List<Acteur> acteurs = acteurDAO.getTousLesActeurs();
            List<Realisateur> realisateurs = realisateurDAO.getTousLesRealisateurs();
            request.setAttribute("film", film);
            request.setAttribute("acteurs", acteurs);
            request.setAttribute("realisateurs", realisateurs);
            request.getRequestDispatcher("/views/films/edit.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int filmId = Integer.parseInt(request.getParameter("id"));
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String genre = request.getParameter("genre");
        int anneeSortie = Integer.parseInt(request.getParameter("anneeSortie"));
        String poster = request.getParameter("poster");
        int realisateurId = Integer.parseInt(request.getParameter("realisateurId"));
        String[] acteurIdsStr = request.getParameterValues("acteurIds");

        List<Integer> acteurIds = new ArrayList<>();
        if (acteurIdsStr != null) {
            for (String id : acteurIdsStr) {
                acteurIds.add(Integer.parseInt(id));
            }
        }

        try (Connection connection = DatabaseConnection.getConnection()) {
            FilmDAO filmDAO = new FilmDAO(connection);
            Film film = new Film(filmId, titre, description, genre, anneeSortie, poster, realisateurId);
            filmDAO.modifierFilm(film, acteurIds);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/films");
    }
}