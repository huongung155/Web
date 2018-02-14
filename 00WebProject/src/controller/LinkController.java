/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
 * @author Duy Le
 */
public class LinkController extends HttpServlet {

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
        MemberDAO memberDAO = new MemberDAO();
        LinkDAO linkDAO = new LinkDAO();
        LogDAO logDAO = new LogDAO();
        AdminDAO adminDAO = new AdminDAO();
        Member member;
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("../MemberController?action=logout");
            return;
        }
        member = (Member) session.getAttribute("admin");
        if (!adminDAO.isAdmin(member.getMemberID())) {
            response.sendRedirect("../MemberController?action=logout");
            return;
        }
        String movieIDString = request.getParameter("movieID");
        if (movieIDString == null) {
            response.sendRedirect("user/index.jsp");
            return;
        }
        int movieID = Integer.parseInt(movieIDString);
        String action = request.getParameter("action");
        switch (action) {
            case "add": {
                String movieLink = request.getParameter("movieLink");
                String serverName = request.getParameter("serverName");
                //out.println(serverName);
                linkDAO.addLink(movieLink, serverName, movieID);
                logDAO.addAdminLog(member.getMemberID(), "Add " + serverName + " link for movie with id " + movieID);
                response.sendRedirect("member/viewMovie.jsp?id=" + movieID + "&server=Google Drive");
                return;
            }
            case "delete": {
                String linkIDString = request.getParameter("linkID");
                int linkID = Integer.parseInt(linkIDString);
                linkDAO.deleteLink(linkID);
                logDAO.addAdminLog(member.getMemberID(), "Delete link with id " + linkID +" of movie with id "+movieID);
                response.sendRedirect("member/viewMovie.jsp?id=" + movieID + "&server=Google Drive");
                return;
            }
            default: {
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
            Logger.getLogger(LinkController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LinkController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(LinkController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LinkController.class.getName()).log(Level.SEVERE, null, ex);
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