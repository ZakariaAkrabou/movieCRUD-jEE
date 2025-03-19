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

/**
 * Servlet implementation class ActeurEditServlet
 */
@WebServlet("/edit-acteur")
public class ActeurEditServlet extends HttpServlet {
	 @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        int id = Integer.parseInt(request.getParameter("id"));

	        try (Connection connection = DatabaseConnection.getConnection()) {
	        	ActeurDAO acteurDAO = new ActeurDAO(connection);
	            Acteur acteur = acteurDAO.getActeurById(id);
	            request.setAttribute("acteur", acteur);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        request.getRequestDispatcher("/views/acteurs/edit.jsp").forward(request, response);
	    }

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String nom = request.getParameter("nom");
	        String prenom = request.getParameter("prenom");
	        String nationalite = request.getParameter("nationalite");

	        try (Connection connection = DatabaseConnection.getConnection()) {
	            ActeurDAO acteurDAO = new ActeurDAO(connection);
	            Acteur acteur = new Acteur(id, nom, prenom, nationalite);
	            acteurDAO.modifierActeur(acteur);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }


	        response.sendRedirect(request.getContextPath() + "/acteurs");
	    }

}
