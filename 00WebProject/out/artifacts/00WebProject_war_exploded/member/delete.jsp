<%-- 
    Document   : delete
    Created on : Dec 16, 2017, 7:57:17 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member member = (Member)session.getAttribute("member");
    if(member != null){
        int idMember = Integer.parseInt(request.getParameter("idMember"));
        int idMovie = Integer.parseInt(request.getParameter("idMovie"));
        MovieDAO movieDAO = new MovieDAO();
        movieDAO.deleteFromFavorite(idMember, idMovie);
        response.sendRedirect("member.jsp?id=" + idMember);
        //response.sendRedirect("../user/index.jsp");
    }else{
        response.sendRedirect("notMember.jsp");
    }
%>
