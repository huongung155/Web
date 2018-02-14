/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.*;
import java.math.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Duy Le
 */
public class MovieController extends HttpServlet {

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
        LinkDAO linkDAO = new LinkDAO();
        LogDAO logDAO = new LogDAO();
        AdminDAO adminDAO = new AdminDAO();
        Member member;
        HttpSession session = request.getSession();
        if (session.getAttribute("member") == null && session.getAttribute("admin") == null) {
            response.sendRedirect("member/notMember.jsp");
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
            response.sendRedirect("user/index.jsp");
            return;
        }
        String action = request.getParameter("action");
        switch (action) {
            case "watch": {
                String movieIDString = request.getParameter("movieID");
                String server = request.getParameter("server");
                if (movieIDString == null) {
                    response.sendRedirect("user/index.jsp");
                    return;
                }
                int movieID = Integer.parseInt(movieIDString);
                //out.println(server + "<br>" + movieID);
                ArrayList<Link> movieLinks = linkDAO.getLinkByMovieID(movieID);
                session.setAttribute("listOfLinks" + movieID, movieLinks);
                logDAO.addWatchLog(member.getMemberID(), movieID);
                response.sendRedirect("member/viewMovie.jsp?id=" + movieID + "&server=" + server);
                return;
            }
            case "edit": {
                String movieIDString = request.getParameter("movieID");
                if (movieIDString == null) {
                    response.sendRedirect("user/index.jsp");
                    return;
                }
                int movieID = Integer.parseInt(movieIDString);
                if (!adminDAO.isAdmin(member.getMemberID())) {
                    response.sendRedirect("../MemberController?action=logout");
                    return;
                }
                String movieName = request.getParameter("movieName");
                String movieDescription = request.getParameter("movieDescription");
                String moviePosterLink = request.getParameter("moviePosterLink");
                String movieTrailerLink = request.getParameter("movieTrailerLink");
                String country = request.getParameter("country");
                String year = request.getParameter("year");
                String length = request.getParameter("length");
                String categoryIDString = request.getParameter("category");
                int categoryID = Integer.parseInt(categoryIDString);
                //out.println(movieName + "<br>" + movieDescription + "<br>" + moviePosterLink + "<br>" + movieTrailerLink + "<br>" + country + "<br>" + year + "<br>" + length + "<br>" + categoryID);
                movieDAO.updateMovieName(movieName, movieID);
                movieDAO.updateCategoryID(categoryID, movieID);
                movieDAO.updateCountry(country, movieID);
                movieDAO.updateLength(length, movieID);
                movieDAO.updateMovieDescription(movieDescription, movieID);
                movieDAO.updateMoviePosterLink(moviePosterLink, movieID);
                movieDAO.updateYear(year, movieID);
                movieDAO.updateMovieTrailerLink(movieTrailerLink, movieID);
                logDAO.addAdminLog(member.getMemberID(), "Edit movie with id " + movieID);
                response.sendRedirect("user/viewMovieDetail.jsp?id=" + movieID);
                return;
            }
            case "delete": {
                String movieIDString = request.getParameter("movieID");
                if (movieIDString == null) {
                    response.sendRedirect("user/index.jsp");
                    return;
                }
                int movieID = Integer.parseInt(movieIDString);
                if (!adminDAO.isAdmin(member.getMemberID())) {
                    response.sendRedirect("../MemberController?action=logout");
                    return;
                }
                movieDAO.deleteMovieByID(movieID);
                logDAO.addAdminLog(member.getMemberID(), "Delete movie with id " + movieID);
                response.sendRedirect("admin/index.jsp");
                return;
            }
            case "add": {
                if (!adminDAO.isAdmin(member.getMemberID())) {
                    response.sendRedirect("../MemberController?action=logout");
                    return;
                }
                String movieName = request.getParameter("movieName");
                String movieDescription = request.getParameter("movieDescription");
                String moviePosterLink = request.getParameter("moviePosterLink");
                String movieTrailerLink = request.getParameter("movieTrailerLink");
                String country = request.getParameter("country");
                String year = request.getParameter("year");
                String length = request.getParameter("length");
                String categoryIDString = request.getParameter("category");
                int categoryID = Integer.parseInt(categoryIDString);
                movieDAO.addMovie(movieName, movieDescription, moviePosterLink, movieTrailerLink, country, year, length, categoryID);
                int movieID = movieDAO.getLastInsertMovieID();
                logDAO.addAdminLog(member.getMemberID(), "Add movie with id "+ movieID);
                response.sendRedirect("admin/index.jsp");
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
            Logger.getLogger(MovieController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MovieController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(MovieController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MovieController.class.getName()).log(Level.SEVERE, null, ex);
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