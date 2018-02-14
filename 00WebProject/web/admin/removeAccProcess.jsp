<%-- 
    Document   : removeAccProcess
    Created on : Dec 17, 2017, 12:10:30 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member admin = (Admin)session.getAttribute("admin");
    if(admin != null){
        MemberDAO memberDAO = new MemberDAO();
        String[] deleteMembers = request.getParameterValues("account");
        if(deleteMembers != null){
            for(String deleteMember: deleteMembers){
                memberDAO.deleteMember(Integer.parseInt(deleteMember));
            }
        }
        response.sendRedirect("removeAcc.jsp");
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>
