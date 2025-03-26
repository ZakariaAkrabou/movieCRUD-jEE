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
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 2,
	    maxFileSize = 1024 * 1024 * 10, 
	    maxRequestSize = 1024 * 1024 * 50 
	)

@WebServlet("/modifier-film")
public class FilmEditServlet extends HttpServlet {
	 private static final String UPLOAD_DIRECTORY = "uploads";

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
            List<Integer> selectedActeurIds = new ArrayList<>();
            for (Acteur acteur : film.getActeurs()) {
                selectedActeurIds.add(acteur.getId());
            }
            request.setAttribute("film", film);
            request.setAttribute("acteurs", acteurs);
            request.setAttribute("realisateurs", realisateurs);
            request.setAttribute("selectedActeurIds",selectedActeurIds);
            request.getRequestDispatcher("/views/films/edit.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int filmId = Integer.parseInt(request.getParameter("id"));
        Connection connection = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            connection.setAutoCommit(false); 
            

          
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

            
            FilmDAO filmDAO = new FilmDAO(connection);
            Film existingFilm = filmDAO.getFilmById(filmId);
            String posterPath = existingFilm.getPoster();

            Part filePart = request.getPart("poster");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null 
                    && !filePart.getSubmittedFileName().isEmpty()) {
                
             
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs(); 
                }

             
                String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadPath + File.separator + fileName;

               
                if (existingFilm.getPoster() != null && !existingFilm.getPoster().isEmpty()) {
                    String oldFilePath = getServletContext().getRealPath("") + File.separator + existingFilm.getPoster();
                    try {
                        Files.deleteIfExists(Paths.get(oldFilePath));
                    } catch (IOException e) {
                        
                        e.printStackTrace();
                    }
                }

               
                filePart.write(filePath);
                
               
                posterPath = UPLOAD_DIRECTORY + "/" + fileName;
            }

            
            Film film = new Film(filmId, titre, description, genre, anneeSortie, 
                               posterPath != null ? posterPath : "", realisateurId);
            filmDAO.modifierFilm(film, acteurIds);

            connection.commit();
            response.sendRedirect(request.getContextPath() + "/films");

        } catch (Exception e) {
            try {
                if (connection != null) {
                    connection.rollback();
               
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating film: " + e.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}