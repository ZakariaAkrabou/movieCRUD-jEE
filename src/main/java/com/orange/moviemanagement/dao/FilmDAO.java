package com.orange.moviemanagement.dao;

import com.orange.moviemanagement.model.Film;
import com.orange.moviemanagement.model.Acteur;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FilmDAO {
    private Connection connection;

    public FilmDAO(Connection connection) {
        this.connection = connection;
    }

    public void ajouterFilm(Film film, List<Integer> acteurIds) throws SQLException {
        try {
            connection.setAutoCommit(false); 

          
            String sqlFilm = "INSERT INTO film (titre, description, genre, annee_sortie, poster, realisateur_id) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmtFilm = connection.prepareStatement(sqlFilm, Statement.RETURN_GENERATED_KEYS)) {
                stmtFilm.setString(1, film.getTitre());
                stmtFilm.setString(2, film.getDescription());
                stmtFilm.setString(3, film.getGenre());
                stmtFilm.setInt(4, film.getAnneeSortie());
                stmtFilm.setString(5, film.getPoster());
                stmtFilm.setInt(6, film.getRealisateurId());
                stmtFilm.executeUpdate();

               
                try (ResultSet generatedKeys = stmtFilm.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int filmId = generatedKeys.getInt(1);
                        
                      
                        String sqlFilmActeur = "INSERT INTO acteur_film (film_id, acteur_id) VALUES (?, ?)";
                        try (PreparedStatement stmtFilmActeur = connection.prepareStatement(sqlFilmActeur)) {
                            for (int acteurId : acteurIds) {
                                stmtFilmActeur.setInt(1, filmId);
                                stmtFilmActeur.setInt(2, acteurId);
                                stmtFilmActeur.addBatch();
                            }
                            stmtFilmActeur.executeBatch();
                        }
                    }
                }
            }
            connection.commit(); 
        } catch (SQLException e) {
            connection.rollback(); 
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }

    public Film getFilmById(int id) throws SQLException {
        String sql = "SELECT * FROM film WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Film film = new Film(
                        rs.getInt("id"),
                        rs.getString("titre"),
                        rs.getString("description"),
                        rs.getString("genre"),
                        rs.getInt("annee_sortie"),
                        rs.getString("poster"),
                        rs.getInt("realisateur_id")
                    );
                    film.setActeurs(getActeursForFilm(id));
                    return film;
                }
            }
        }
        return null;
    }

    public List<Film> getTousLesFilms() throws SQLException {
        List<Film> films = new ArrayList<>();
        String sql = "SELECT * FROM film";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Film film = new Film(
                    rs.getInt("id"),
                    rs.getString("titre"),
                    rs.getString("description"),
                    rs.getString("genre"),
                    rs.getInt("annee_sortie"),
                    rs.getString("poster"),
                    rs.getInt("realisateur_id")
                );
                film.setActeurs(getActeursForFilm(film.getId()));
                films.add(film);
            }
        }
        return films;
    }

    public void modifierFilm(Film film, List<Integer> acteurIds) throws SQLException {
        try {
            connection.setAutoCommit(false); 

            
            String sqlFilm = "UPDATE film SET titre = ?, description = ?, genre = ?, annee_sortie = ?, poster = ?, realisateur_id = ? WHERE id = ?";
            try (PreparedStatement stmtFilm = connection.prepareStatement(sqlFilm)) {
                stmtFilm.setString(1, film.getTitre());
                stmtFilm.setString(2, film.getDescription());
                stmtFilm.setString(3, film.getGenre());
                stmtFilm.setInt(4, film.getAnneeSortie());
                stmtFilm.setString(5, film.getPoster());
                stmtFilm.setInt(6, film.getRealisateurId());
                stmtFilm.setInt(7, film.getId());
                stmtFilm.executeUpdate();
            }

           
            String deleteFilmActeur = "DELETE FROM acteur_film WHERE film_id = ?";
            try (PreparedStatement deleteStmt = connection.prepareStatement(deleteFilmActeur)) {
                deleteStmt.setInt(1, film.getId());
                deleteStmt.executeUpdate();
            }

            String sqlFilmActeur = "INSERT INTO acteur_film (film_id, acteur_id) VALUES (?, ?)";
            try (PreparedStatement stmtFilmActeur = connection.prepareStatement(sqlFilmActeur)) {
                for (int acteurId : acteurIds) {
                    stmtFilmActeur.setInt(1, film.getId());
                    stmtFilmActeur.setInt(2, acteurId);
                    stmtFilmActeur.addBatch();
                }
                stmtFilmActeur.executeBatch();
            }

            connection.commit(); 
        } catch (SQLException e) {
            connection.rollback(); 
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }

    public void supprimerFilm(int id) throws SQLException {
        try {
            connection.setAutoCommit(false);

            
            String sqlFilmActeur = "DELETE FROM acteur_film WHERE film_id = ?";
            try (PreparedStatement stmtFilmActeur = connection.prepareStatement(sqlFilmActeur)) {
                stmtFilmActeur.setInt(1, id);
                stmtFilmActeur.executeUpdate();
            }

           
            String sqlFilm = "DELETE FROM film WHERE id = ?";
            try (PreparedStatement stmtFilm = connection.prepareStatement(sqlFilm)) {
                stmtFilm.setInt(1, id);
                stmtFilm.executeUpdate();
            }

            connection.commit(); 
        } catch (SQLException e) {
            connection.rollback(); 
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }

    private List<Acteur> getActeursForFilm(int filmId) throws SQLException {
        List<Acteur> acteurs = new ArrayList<>();
        String sql = "SELECT a.* FROM acteur a " +
                     "JOIN acteur_film af ON a.id = af.acteur_id " +
                     "WHERE af.film_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, filmId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Acteur acteur = new Acteur(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("prenom"),
                        rs.getString("nationalite")
                    );
                    acteurs.add(acteur);
                }
            }
        }
        return acteurs;
    }
}