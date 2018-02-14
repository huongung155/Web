/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Duy Le
 */
public class Movie {
    private int movieID;
    private String movieName;
    private String movieDescription;
    private String posterLink;
    private String trailerLink;
    private String country;
    private String year;
    private String length;
    private int categoryID;
    private double averageRating;

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }
    public Movie(){}

    public Movie(int movieID, String movieName, String movieDescription, String posterLink, String trailerLink, String country, String year, String length, int categoryID) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.movieDescription = movieDescription;
        this.posterLink = posterLink;
        this.trailerLink = trailerLink;
        this.country = country;
        this.year = year;
        this.length = length;
        this.categoryID = categoryID;
        this.averageRating = -1;
    }

    public Movie(int movieID, String movieName, String movieDescription, String posterLink, String trailerLink, String country, String year, String length, int categoryID, double averageRating) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.movieDescription = movieDescription;
        this.posterLink = posterLink;
        this.trailerLink = trailerLink;
        this.country = country;
        this.year = year;
        this.length = length;
        this.categoryID = categoryID;
        this.averageRating = averageRating;
    }
    
    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getMovieDescription() {
        return movieDescription;
    }

    public void setMovieDescription(String movieDescription) {
        this.movieDescription = movieDescription;
    }

    public String getPosterLink() {
        return posterLink;
    }

    public void setPosterLink(String posterLink) {
        this.posterLink = posterLink;
    }

    public String getTrailerLink() {
        return trailerLink;
    }

    public void setTrailerLink(String trailerLink) {
        this.trailerLink = trailerLink;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }
    
}
