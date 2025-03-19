package com.orange.moviemanagement.dao;

import com.orange.moviemanagement.model.Film;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FilmDAO {
    private Connection connection;

    public FilmDAO(Connection connection) {
        this.connection = connection;
    }

    public void ajouterFilm(Film film, List<Integer> acteurIds) throws SQLException {
        String sqlFilm = "INSERT INTO film (titre, description, genre, annee_sortie, poster, realisateur_id) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmtFilm = connection.prepareStatement(sqlFilm, Statement.RETURN_GENERATED_KEYS);
        stmtFilm.setString(1, film.getTitre());
        stmtFilm.setString(2, film.getDescription());
        stmtFilm.setString(3, film.getGenre());
        stmtFilm.setInt(4, film.getAnneeSortie());
        stmtFilm.setString(5, film.getPoster());
        stmtFilm.setInt(6, film.getRealisateurId());
        stmtFilm.executeUpdate();

        ResultSet generatedKeys = stmtFilm.getGeneratedKeys();
        int filmId = 0;
        if (generatedKeys.next()) {
            filmId = generatedKeys.getInt(1);
        }

        String sqlFilmActeur = "INSERT INTO film_acteur (film_id, acteur_id) VALUES (?, ?)";
        PreparedStatement stmtFilmActeur = connection.prepareStatement(sqlFilmActeur);
        for (int acteurId : acteurIds) {
            stmtFilmActeur.setInt(1, filmId);
            stmtFilmActeur.setInt(2, acteurId);
            stmtFilmActeur.executeUpdate();
        }
    }

    public Film getFilmById(int id) throws SQLException {
        String sql = "SELECT * FROM film WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return new Film(
                    rs.getInt("id"),
                    rs.getString("titre"),
                    rs.getString("description"),
                    rs.getString("genre"),
                    rs.getInt("annee_sortie"),
                    rs.getString("poster"),
                    rs.getInt("realisateur_id")
            );
        }
        return null;
    }

    public List<Film> getTousLesFilms() throws SQLException {
        List<Film> films = new ArrayList<>();
        String sql = "SELECT * FROM film";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            films.add(new Film(
                    rs.getInt("id"),
                    rs.getString("titre"),
                    rs.getString("description"),
                    rs.getString("genre"),
                    rs.getInt("annee_sortie"),
                    rs.getString("poster"),
                    rs.getInt("realisateur_id")
            ));
        }
        return films;
    }

    public void modifierFilm(Film film, List<Integer> acteurIds) throws SQLException {
        String sqlFilm = "UPDATE film SET titre = ?, description = ?, genre = ?, annee_sortie = ?, poster = ?, realisateur_id = ? WHERE id = ?";
        PreparedStatement stmtFilm = connection.prepareStatement(sqlFilm);
        stmtFilm.setString(1, film.getTitre());
        stmtFilm.setString(2, film.getDescription());
        stmtFilm.setString(3, film.getGenre());
        stmtFilm.setInt(4, film.getAnneeSortie());
        stmtFilm.setString(5, film.getPoster());
        stmtFilm.setInt(6, film.getRealisateurId());
        stmtFilm.setInt(7, film.getId());
        stmtFilm.executeUpdate();

        String deleteFilmActeur = "DELETE FROM film_acteur WHERE film_id = ?";
        PreparedStatement deleteStmt = connection.prepareStatement(deleteFilmActeur);
        deleteStmt.setInt(1, film.getId());
        deleteStmt.executeUpdate();

        String sqlFilmActeur = "INSERT INTO film_acteur (film_id, acteur_id) VALUES (?, ?)";
        PreparedStatement stmtFilmActeur = connection.prepareStatement(sqlFilmActeur);
        for (int acteurId : acteurIds) {
            stmtFilmActeur.setInt(1, film.getId());
            stmtFilmActeur.setInt(2, acteurId);
            stmtFilmActeur.executeUpdate();
        }
    }

    public void supprimerFilm(int id) throws SQLException {
        String sqlFilmActeur = "DELETE FROM acteur_film WHERE film_id = ?";
        PreparedStatement stmtFilmActeur = connection.prepareStatement(sqlFilmActeur);
        stmtFilmActeur.setInt(1, id);
        stmtFilmActeur.executeUpdate();

        String sqlFilm = "DELETE FROM film WHERE id = ?";
        PreparedStatement stmtFilm = connection.prepareStatement(sqlFilm);
        stmtFilm.setInt(1, id);
        stmtFilm.executeUpdate();
    }
}