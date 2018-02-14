/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author Duy Le
 */
import db.DBConnection;
import java.sql.*;
import model.*;
import java.util.*;
public class MovieDAO {
    private final Connection dbConnection;
    public MovieDAO() throws SQLException, ClassNotFoundException{
        dbConnection = DBConnection.getConnection();
    }
    public double calculateAverageRatingByID(int idMovie) throws SQLException{
        double res = 0;
        String sqlQuery = "select avg(rating)\n" +
                            "from rating\n" +
                            "where rating.idMovie = ?;";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, idMovie);
        ResultSet resultSet = sqlStatement.executeQuery();
        while(resultSet.next()){
            res = resultSet.getDouble(1);
        }
        return res;
    }
    public Movie getMovieByID(int movieID) throws SQLException{
        String sqlQuery = "select * from movie where movie.idmovie = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, movieID);
        ResultSet resultSet = sqlStatement.executeQuery();
        Movie resultMovie = null;
        while(resultSet.next()){
            resultMovie = new Movie(resultSet.getInt("idMovie"),resultSet.getString("movieName"),resultSet.getString("movieDescription"),
            resultSet.getString("moviePosterLink"),resultSet.getString("movieTrailerLink"),resultSet.getString("country"),
            resultSet.getString("year"),resultSet.getString("length"),resultSet.getInt("idCategory"),this.calculateAverageRatingByID(resultSet.getInt("idMovie")));
        }
        return resultMovie;
    }
    public ArrayList<Movie> getAllMovie()throws SQLException{
        ArrayList<Movie> allMovie = new ArrayList<Movie>();
        String sqlQuery = "select idmovie from movie order by idmovie desc";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        ResultSet resultSet = sqlStatement.executeQuery();
        while(resultSet.next()){
            allMovie.add(this.getMovieByID(resultSet.getInt("idMovie")));
        }
        return allMovie;
    }
    public void addMovie(String movieName, String movieDescription, String posterLink, String trailerLink, String country, String year, String length, int categoryID) throws SQLException {
        String sqlQuery = "insert into movie (moviename,moviedescription,movieposterlink,movietrailerlink,country,year,length,idcategory)\n" +
        "values (?,?,?,?,?,?,?,?);";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,movieName);
        sqlStatement.setString(2,movieDescription);
        sqlStatement.setString(3,posterLink);
        sqlStatement.setString(4,trailerLink);
        sqlStatement.setString(5,country);
        sqlStatement.setString(6,year);
        sqlStatement.setString(7,length);
        sqlStatement.setInt(8,categoryID);
        sqlStatement.execute();
    }
    public ArrayList<Movie> getAllFavoriteMovieOfAMemberByID (int memberID) throws SQLException{
        String sqlQuery = "select idmovie from movie where movie.idmovie in (select idmovie from favorite where favorite.idmember = ?)";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        ResultSet resultSet = sqlStatement.executeQuery();
        ArrayList<Movie> result = new ArrayList<>();
        while(resultSet.next()){
            result.add(this.getMovieByID(resultSet.getInt("idMovie")));
        }
        return result;
    }
    public void deleteMovieByID(int movieID)throws SQLException{
        String sqlQuery = "delete from movie where movie.idmovie = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, movieID);
        sqlStatement.execute();
    }
    
    public void updateMovieName(String movieName,int movieID) throws SQLException{
        String sqlQuery = "update movie set moviename = ? where idmovie = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, movieName);
        sqlStatement.setInt(2,movieID);
        sqlStatement.execute();
    }
    
    public void updateMovieDescription(String movieDescription,int movieID) throws SQLException{
        String sqlQuery = "update movie set movieDescription = ? where idmovie = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, movieDescription);
        sqlStatement.setInt(2,movieID);
        sqlStatement.execute();
    }
    public void updateMoviePosterLink(String moviePosterLink,int movieID) throws SQLException{
        String sqlQuery = "update movie set moviePosterLink = ? where idmovie = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, moviePosterLink);
        sqlStatement.setInt(2,movieID);
        sqlStatement.execute();
    }
    
    public void updateMovieTrailerLink(String movieTrailerLink,int movieID) throws SQLException{
        String sqlQuery = "update movie set movieTrailerLink = ? where idmovie = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, movieTrailerLink);
        sqlStatement.setInt(2,movieID);
        sqlStatement.execute();
    }
    public void updateCountry(String country,int movieID) throws SQLException{
        String sqlQuery = "update movie set country = ? where idmovie = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, country);
        sqlStatement.setInt(2,movieID);
        sqlStatement.execute();
    }
    public void updateYear(String year,int movieID) throws SQLException{
        String sqlQuery = "update movie set year = ? where idmovie = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,year);
        sqlStatement.setInt(2,movieID);
        sqlStatement.execute();
    }
    public void updateLength(String length,int movieID) throws SQLException{
        String sqlQuery = "update movie set length = ? where idmovie = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,length);
        sqlStatement.setInt(2,movieID);
        sqlStatement.execute();
    }
    public void updateCategoryID(int categoryID,int movieID) throws SQLException{
        String sqlQuery = "update movie set idcategory = ? where idmovie = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1,categoryID);
        sqlStatement.setInt(2,movieID);
        sqlStatement.execute();
    }
    
    public ArrayList<Movie> getMovieByCategory(int categoryID) throws SQLException{
        String sqlQuery = "select idmovie from movie where idcategory = ?" ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, categoryID);
        ResultSet resultSet = sqlStatement.executeQuery();
        ArrayList<Movie> result = new ArrayList<>();
        while(resultSet.next()){
            result.add(this.getMovieByID(resultSet.getInt("idmovie")));
        }
        return result;
    }
    public ArrayList<Movie> getMovieByKeyword(String keyword) throws SQLException{
        keyword = keyword.toUpperCase();
        String sqlQuery = "select idmovie from movie where upper(moviename) like ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,"%"+ keyword +"%");
        ArrayList<Movie> result = new ArrayList<>();
        ResultSet resultSet = sqlStatement.executeQuery();
        while(resultSet.next()){
            result.add(this.getMovieByID(resultSet.getInt("idmovie")));
        }
        return result;
    }
    
    public ArrayList<Movie> getMovieByKeywordAndCategory(String keyword,int categoryID) throws SQLException{
        keyword = keyword.toUpperCase();
        String sqlQuery = "select idmovie from movie where upper(moviename) like ? and idcategory = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,"%"+ keyword +"%");
        sqlStatement.setInt(2, categoryID);
        ArrayList<Movie> result = new ArrayList<>();
        ResultSet resultSet = sqlStatement.executeQuery();
        while(resultSet.next()){
            result.add(this.getMovieByID(resultSet.getInt("idmovie")));
        }
        return result;
    }
    public ArrayList<Movie> getMovieByKeywordAndDescription(String keyword) throws SQLException{
        keyword = keyword.toUpperCase();
        String sqlQuery = "select idmovie from movie where upper(moviename) like ? or upper(moviedescription) like ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,"%"+ keyword +"%");
        sqlStatement.setString(2,"%"+ keyword +"%");
        ArrayList<Movie> result = new ArrayList<>();
        ResultSet resultSet = sqlStatement.executeQuery();
        while(resultSet.next()){
            result.add(this.getMovieByID(resultSet.getInt("idmovie")));
        }
        return result;
    }
    public ArrayList<Movie> getMovieByKeywordAndDescriptionAndCategory(String keyword, int categoryID) throws SQLException{
        keyword = keyword.toUpperCase();
        String sqlQuery = "select idmovie from movie where (upper(moviename) like ? or upper(moviedescription) like ?) and idcategory = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,"%"+ keyword +"%");
        sqlStatement.setString(2,"%"+ keyword +"%");
        sqlStatement.setInt(3, categoryID);
        ArrayList<Movie> result = new ArrayList<>();
        ResultSet resultSet = sqlStatement.executeQuery();
        while(resultSet.next()){
            result.add(this.getMovieByID(resultSet.getInt("idmovie")));
        }
        return result;
    }
    public void addToFavorite(int memberID,int movieID) throws SQLException{
        String sqlQuery = "insert into favorite (idmember,idmovie) values(?,?)" ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1,memberID);
        sqlStatement.setInt(2, movieID);
        sqlStatement.execute();
    }
    public void deleteFromFavorite(int memberID,int movieID) throws SQLException{
        String sqlQuery = "delete from favorite where idmember = ? and idmovie = ?" ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1,memberID);
        sqlStatement.setInt(2, movieID);
        sqlStatement.execute();
    }
    public void addRating(int rating,int movieID,int memberID) throws SQLException{
        String sqlQuery = "insert into rating (idmember,idmovie,rating) values (?,?,?)";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        sqlStatement.setInt(2, movieID);
        sqlStatement.setInt(3, rating);
        sqlStatement.execute();
    }
    public int getRating (int memberID,int movieID) throws SQLException{
        String sqlQuery = "select rating from rating where idmember = ? and idmovie = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        sqlStatement.setInt(2, movieID);
        ResultSet resultSet = sqlStatement.executeQuery();
        int result = 0;
        while(resultSet.next()){
            result = resultSet.getInt("rating");
        }
        return result;
    }
    public void updateRating(int rating,int movieID,int memberID) throws SQLException{
        String sqlQuery = "update rating set rating = ? where idmember = ? and idmovie = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(2, memberID);
        sqlStatement.setInt(3, movieID);
        sqlStatement.setInt(1, rating);
        sqlStatement.execute();
    }
    public int getLastInsertMovieID() throws SQLException{
        String sqlQuery = "select max(idMovie) from movie";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        ResultSet resultSet = sqlStatement.executeQuery();
        int result = 0 ;
        while(resultSet.next()){
            result = resultSet.getInt("max(idMovie)");
        }
        return result;
    }
    public static void main(String[] args) throws Exception{
        MovieDAO test = new MovieDAO();
        //System.out.println(test.lastInsertMovieID());
        //test.updateRating(2, 30, 2);
    }
}