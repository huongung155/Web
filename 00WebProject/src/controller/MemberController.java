package controller;

import javax.servlet.annotation.WebServlet;
import dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.*;
import security.AES;

/**
 *
 * @author huong
 */
@WebServlet(name = "MemberController", urlPatterns = {"/MemberController"})
public class MemberController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        MemberDAO memberDAO = new MemberDAO();
        AdminDAO adminDAO = new AdminDAO();
        LogDAO logDAO = new LogDAO();
        HttpSession session = request.getSession();
        switch(action){
            case "login":{ 
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                password = AES.encrypt(password, "bestmoviesite");
                if(memberDAO.isLoginInformationCorrect(username, password)){
                    Member member = memberDAO.getMemberByUserName(username);
                    if(adminDAO.isAdmin(username, password)){
                        member = new Admin(member);
                        session.setAttribute("admin", member);
                        response.sendRedirect("admin/index.jsp");
                    }
                    else {
                        session.setAttribute("member", member);
                        response.sendRedirect("user/index.jsp");
                    }
                }
                else{
                    response.sendRedirect("user/login.jsp?result=invalid");
                }
                return;
            }
            case "register":{
                if(session.getAttribute("member") != null || session.getAttribute("admin") != null){
                    response.sendRedirect("user/index.jsp");
                    return;
                }
                else{
                    String username = request.getParameter("username");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String profilePictureLink = request.getParameter("profilePictureLink");
                    password = AES.encrypt(password, "bestmoviesite");
                    if(memberDAO.isMemberWithEmailExist(email)||memberDAO.isMemberWithUserNameExist(username)){
                        response.sendRedirect("user/register.jsp?result=exists");
                        return;
                    }
                    else{
                        if(profilePictureLink == null) memberDAO.addMember(username, password, email);
                        else memberDAO.addMember(username, password, email, profilePictureLink);
                        Member member = memberDAO.getMemberByUserName(username);
                        session.setAttribute("member", member);
                        response.sendRedirect("user/index.jsp");
                        return;
                    }
                }
            }
            case "logout":{
                session.removeAttribute("member");
                session.removeAttribute("admin");
                response.sendRedirect("member/notMember.jsp");
                return;
            }
            case "editprofile":{
                if(session.getAttribute("member") == null && session.getAttribute("admin") == null){
                    response.sendRedirect("member/notMember.jsp");
                    return;
                }
                Member member;
                if(session.getAttribute("member")!=null) member = (Member) session.getAttribute("member");
                else member = (Admin) session.getAttribute("admin");
                if (!memberDAO.isMemberWithUserNameExist(member.getUserName())) {
                    session.removeAttribute("member");
                    session.removeAttribute("admin");
                    response.sendRedirect("../MemberController?action=logout");
                    return;
                }
                String password = request.getParameter("password");
                String profilePictureLink = request.getParameter("profilePictureLink");
                String email = request.getParameter("email");
                if(memberDAO.isMemberWithEmailExist(email)&&!email.equals(member.getEmail())){
                    response.sendRedirect("member/editInfo.jsp?idMember=" + member.getMemberID() + "&result=emailexist");
                    return;
                }
                memberDAO.updateEmail(email, member.getMemberID());
                memberDAO.updateProfilePictureLink(profilePictureLink, member.getMemberID());
                memberDAO.updateUserPassword(password, member.getMemberID());
                member = memberDAO.getMemberByID(member.getMemberID());
                if (session.getAttribute("member") != null) {
                    session.setAttribute("member", member);
                } else {
                    session.setAttribute("admin", member);
                }
                response.sendRedirect("member/member.jsp?id="+member.getMemberID());
                return;
            }
            
            case "delete":{
                if (session.getAttribute("member") == null && session.getAttribute("admin") == null) {
                    response.sendRedirect("member/notMember.jsp");
                    return;
                }
                Member member;
                if (session.getAttribute("member") != null) {
                    member = (Member) session.getAttribute("member");
                } else {
                    member = (Member) session.getAttribute("admin");
                }
                if(!adminDAO.isAdmin(member.getMemberID())){
                    response.sendRedirect("../MemberController?action=logout");
                    return;
                }
                String[] deleteMembers = request.getParameterValues("account");
                if(deleteMembers != null){
                    for(String deleteMember: deleteMembers){
                        memberDAO.deleteMember(Integer.parseInt(deleteMember));
                        logDAO.addAdminLog(member.getMemberID(), "Delete member with id "+Integer.parseInt(deleteMember));
                    }
                }
                response.sendRedirect("admin/removeAcc.jsp");
                return;
            }
            
            case "addFavorite":{
                if (session.getAttribute("member") == null && session.getAttribute("admin") == null) {
                    response.sendRedirect("member/notMember.jsp");
                    return;
                }
                Member member;
                if(session.getAttribute("member")!=null) member = (Member)session.getAttribute("member");
                else member = (Member) session.getAttribute("admin");
                if(!memberDAO.isMemberWithUserNameExist(member.getUserName())){
                    session.removeAttribute("member");
                    session.removeAttribute("admin");
                    response.sendRedirect("../MemberController?action=logout");
                    return;
                }
                int movieID = Integer.parseInt(request.getParameter("id"));
                memberDAO.addMovieToFavorite(member.getMemberID(), movieID);
                response.sendRedirect("member/viewMovie.jsp?id=" + movieID + "&server=Google Drive");
                return;
            }
            
            default:{
                response.sendRedirect("user/index.jsp");
                return;
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(MemberController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MemberController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(MemberController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MemberController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
