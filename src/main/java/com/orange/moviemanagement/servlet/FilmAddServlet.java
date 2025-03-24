package com.orange.moviemanagement.servlet;

import com.orange.moviemanagement.dao.ActeurDAO;
import com.orange.moviemanagement.dao.FilmDAO;
import com.orange.moviemanagement.dao.RealisateurDAO;
import com.orange.moviemanagement.model.Acteur;
import com.orange.moviemanagement.model.Film;
import com.orange.moviemanagement.model.Realisateur;
import com.orange.moviemanagment.config.DatabaseConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ajouter-film")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 2,
	    maxFileSize = 1024 * 1024 * 10, 
	    maxRequestSize = 1024 * 1024 * 50 
	)
public class FilmAddServlet extends HttpServlet {
	 private static final String UPLOAD_DIRECTORY = "uploads";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DatabaseConnection.getConnection()) {
            ActeurDAO acteurDAO = new ActeurDAO(connection);
            RealisateurDAO realisateurDAO = new RealisateurDAO(connection);
            List<Acteur> acteurs = acteurDAO.getTousLesActeurs();
            List<Realisateur> realisateurs = realisateurDAO.getTousLesRealisateurs();
            request.setAttribute("acteurs", acteurs);
            request.setAttribute("realisateurs", realisateurs);
            request.getRequestDispatcher("/views/films/add.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("poster");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
        
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir(); 

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath); 

        String dbFilePath = UPLOAD_DIRECTORY + "/" + fileName; 

       
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String genre = request.getParameter("genre");
        int anneeSortie = Integer.parseInt(request.getParameter("anneeSortie"));
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
            Film film = new Film(0, titre, description, genre, anneeSortie, dbFilePath, realisateurId);
            filmDAO.ajouterFilm(film, acteurIds);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/films");
    }
}