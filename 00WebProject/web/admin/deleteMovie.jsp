<%-- 
    Document   : delete
    Created on : Dec 16, 2017, 7:57:17 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member admin = (Admin)session.getAttribute("admin");
    if(admin != null){
        int idMovie = Integer.parseInt(request.getParameter("idMovie"));
        MovieDAO movieDAO = new MovieDAO();
        movieDAO.deleteMovieByID(idMovie);
        response.sendRedirect("index.jsp");
        //response.sendRedirect("../user/index.jsp");
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>
