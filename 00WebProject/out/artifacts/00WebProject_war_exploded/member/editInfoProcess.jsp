<%-- 
    Document   : editInfoProcess
    Created on : Dec 17, 2017, 11:30:04 AM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member member = (Member)session.getAttribute("member");
    if(member != null){
        int idMember = Integer.parseInt(request.getParameter("idMember"));
        MemberDAO memberDAO = new MemberDAO();
        Member foundMember = memberDAO.getMemberByID(idMember);
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String profilePicture = request.getParameter("profilePicture");
        if(!(foundMember.getPassword().equals(password))){
            memberDAO.updateUserPassword(password, idMember);
        }
        if(!(foundMember.getEmail().equals(email))){
            memberDAO.updateEmail(email, idMember);
        }
        if(!(foundMember.getProfilePictureLink().equals(profilePicture))){
            memberDAO.updateProfilePictureLink(profilePicture, idMember);
        }
        response.sendRedirect("member.jsp?id=" + idMember);
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>
