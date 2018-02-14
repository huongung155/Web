/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import db.DBConnection;
import java.sql.*;
/**
 *
 * @author Duy Le
 */
public class AdminDAO {
    private final Connection dbConnection;
    public AdminDAO() throws SQLException, ClassNotFoundException{
        dbConnection = DBConnection.getConnection();
    }
    public boolean isAdmin(String userName,String password) throws SQLException{
        String sqlQuery = "select idMember from Admin where Admin.idMember in "
                +"(select idMember from member where member.userName = ? and member.password = ?)";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, userName);
        sqlStatement.setString(2, password);
        ResultSet resultSet = sqlStatement.executeQuery();
        return resultSet.next();
    }
    public void adAmin(int memberID) throws SQLException{
        String sqlQuery = "insert into admin (idMember) values (?)";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, Integer.toString(memberID));
        sqlStatement.execute();
    }
    public void deleteAdminRight(int memberID) throws SQLException{
        String sqlQuery = "delete from admin where Admin.idMember = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, Integer.toString(memberID));
        sqlStatement.execute();
    }
    public boolean isAdmin(int memberID) throws SQLException{
        String sqlQuery = "select idMember from Admin where Admin.idMember = ? ";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        ResultSet resultSet = sqlStatement.executeQuery();
        return resultSet.next();
    }
//    public static void main(String[] args) throws SQLException, ClassNotFoundException{
//        AdminDAO test = new AdminDAO();
//        System.out.println(test.isAdmin(1));
//    }
}