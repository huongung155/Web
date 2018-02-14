<%-- 
    Document   : deleteLinkProcess
    Created on : Dec 18, 2017, 12:21:16 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member admin = (Admin)session.getAttribute("admin");
    if(admin != null){
        int idMovie = Integer.parseInt(request.getParameter("id"));
        LinkDAO linkDAO = new LinkDAO();
        String[] deleteLinks = request.getParameterValues("delLink");
        if(deleteLinks != null){
            for(String deleteLink: deleteLinks){
                linkDAO.deleteLink(Integer.parseInt(deleteLink));
            }
        }
        response.sendRedirect("../member/viewMovie.jsp?id=" + idMovie);
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>
