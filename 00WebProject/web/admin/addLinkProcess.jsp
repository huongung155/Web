<%-- 
    Document   : addLinkProcess
    Created on : Dec 18, 2017, 12:37:29 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member admin = (Admin)session.getAttribute("admin");
    if(admin != null){
        int idMovie = Integer.parseInt(request.getParameter("id"));
        String linkName = request.getParameter("linkName");
        String linkMovie = request.getParameter("linkMovie");
        //out.println(linkName + "<br>" + linkMovie + "<br>" + idMovie);
        LinkDAO linkDAO = new LinkDAO();
        if(linkName != null && linkMovie != null){
            linkDAO.addLink(linkName, linkMovie, idMovie);
        }
        response.sendRedirect("member/viewMovie.jsp?id=" + idMovie);
    }else{
        response.sendRedirect("../member/notMember.jsp");
    }
%>
