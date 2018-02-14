/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
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
public class RatingController extends HttpServlet {

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
        MemberDAO memberDAO = new MemberDAO();
        MovieDAO movieDAO = new MovieDAO();
        Member member;
        HttpSession session = request.getSession();
        if (session.getAttribute("member") == null && session.getAttribute("admin") == null) {
            response.sendRedirect("user/notMember.jsp");
            return;
        }
        if (session.getAttribute("member") != null) {
            member = (Member) session.getAttribute("member");
        } else {
            member = (Member) session.getAttribute("admin");
        }
        if (!memberDAO.isMemberWithUserNameExist(member.getUserName())) {
            session.removeAttribute("member");
            session.removeAttribute("admin");
            response.sendRedirect("../MemberController?action=logout");
            return;
        }
        String action = request.getParameter("action");
        String movieIDString = request.getParameter("movieID");
        String ratingString = request.getParameter("rating");
        if(movieIDString == null || ratingString == null){
            response.sendRedirect("user/index.jsp");
            return;
        }
        switch(action){
            
            case "rate":{
                
                int movieID = Integer.parseInt(movieIDString);
                int rating = Integer.parseInt(ratingString);
                //int s = member.getMemberID();
                movieDAO.addRating(rating, movieID, member.getMemberID());
                response.sendRedirect("member/viewMovie.jsp?id="+movieID + "&server=Google Drive");
                return;
            }
            case "update":{
                int movieID = Integer.parseInt(movieIDString);
                int rating = Integer.parseInt(ratingString);
//                out.println(movieID + "<br>" + rating);
                movieDAO.updateRating(rating, movieID, member.getMemberID());
                response.sendRedirect("member/viewMovie.jsp?id="+movieID + "&server=Google Drive");
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
            Logger.getLogger(RatingController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RatingController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(RatingController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RatingController.class.getName()).log(Level.SEVERE, null, ex);
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