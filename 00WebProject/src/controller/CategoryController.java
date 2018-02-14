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
public class CategoryController extends HttpServlet {

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
        CategoryDAO categoryDAO = new CategoryDAO();
        LogDAO logDAO = new LogDAO();
        AdminDAO adminDAO = new AdminDAO();
        Member member;
        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect("notMember.jsp");
            return;
        }
        member = (Member) session.getAttribute("admin");
        if (!adminDAO.isAdmin(member.getMemberID())) {
            response.sendRedirect("notMember.jsp");
            return;
        }
        String action = request.getParameter("action");
        switch(action){
            case "add":{
                String categoryName = request.getParameter("categoryName");
                categoryDAO.addCategory(categoryName);
                logDAO.addAdminLog(member.getMemberID(), "Add category "+categoryName);
                response.sendRedirect("admin/index.jsp");
                return;
            }
            case "delete":{
                String categoryIDString = request.getParameter("categoryID");
                int categoryID = Integer.parseInt(categoryIDString);
                if(categoryDAO.isCategoryHasMovie(categoryID)){
                    response.sendRedirect("admin/index.jsp");
                    return;
                }
                categoryDAO.deleteCategory(categoryID);
                logDAO.addAdminLog(member.getMemberID(), "Delete category with id "+categoryID);
                response.sendRedirect("admin/index.jsp");
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