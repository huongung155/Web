<%-- 
    Document   : list
    Created on : Dec 22, 2017, 7:11:35 AM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    String query = (String)request.getParameter("q");
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> allMovie = movieDAO.getAllMovie();
    
    for(Movie movie: allMovie){
        if(movie.getMovieName().toUpperCase().startsWith(query.toUpperCase())){
            out.print(movie.getMovieName() + "\n");
        }
    }
%>