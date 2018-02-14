/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author Duy Le
 */
import db.DBConnection;
import java.sql.*;
import model.*;
import java.util.*;

public class LogDAO {
    private final Connection dbConnection;
    public LogDAO() throws SQLException, ClassNotFoundException{
        dbConnection = DBConnection.getConnection();
    }
    public ArrayList<WatchLog> getAllWatchLogOfMember(int memberID) throws SQLException{
//        String sqlQuery = "select * from "
//                + "(select l.idlog,l.logtime,w.idmember,w.idmovie" +
//                 "from log as l join watchlog as w on l.idLog = w.idLog "
//                + "where w.idmember = ?);";
        String sqlQuery = "select * from log l join watchLog w on l.idLog = w.idLog where w.idmember = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        ResultSet resultSet  = sqlStatement.executeQuery();
        ArrayList<WatchLog> result = new ArrayList<>();
        while(resultSet.next()){
            result.add(new WatchLog(resultSet.getInt("idmovie"),resultSet.getInt("idmember"),resultSet.getInt("idlog"),resultSet.getString("logtime")));
        }
        return result;
    }
    public ArrayList<AdminLog> getAllAdminLogOfMember(int memberID) throws SQLException{
        String sqlQuery = "select * from "
                + "(select l.idlog,l.logtime,a.idmember,a.actiontaken" +
                 "from log as l join adminlog as a on l.idLog = a.idLog "
                + "where a.idmember = ?);";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        ResultSet resultSet  = sqlStatement.executeQuery();
        ArrayList<AdminLog> result = new ArrayList<>();
        while(resultSet.next()){
            result.add(new AdminLog(resultSet.getString("actiontaken"),resultSet.getInt("idmember"),resultSet.getInt("idlog"),resultSet.getString("logtime")));
        }
        return result;
    }
    public ArrayList<AdminLog> getAllAdminLog() throws SQLException{
        String sqlQuery = "select l.idlog,l.logtime,a.idmember,a.actiontaken from log l join adminlog a on l.idLog = a.idLog";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        ResultSet resultSet  = sqlStatement.executeQuery();
        ArrayList<AdminLog> result = new ArrayList<>();
        while(resultSet.next()){
            result.add(new AdminLog(resultSet.getString("actiontaken"),resultSet.getInt("idmember"),resultSet.getInt("idlog"),resultSet.getString("logtime")));
        }
        return result;
    }
    public void addWatchLog(int memberID,int movieID) throws SQLException{
        String sqlQuery = "insert into log (logtime) values(now());";
        Statement statement = dbConnection.createStatement();
        statement.execute(sqlQuery);
        sqlQuery = "insert into watchlog (idlog,idmember,idmovie) values (last_insert_id(),?,?);";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        sqlStatement.setInt(2, movieID);
        sqlStatement.execute();
    }
    public void addAdminLog(int memberID,String actionTaken) throws SQLException{
        String sqlQuery = "insert into log (logtime) values(now());";
        Statement statement = dbConnection.createStatement();
        statement.execute(sqlQuery);
        sqlQuery="insert into adminlog (idlog,idmember,actiontaken) values (last_insert_id(),?,?);";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        sqlStatement.setString(2, actionTaken);
        System.out.println(123);
        sqlStatement.execute();
    }
    public void deleteWatchLog(int logID) throws SQLException{
        String sqlQuery = "delete from watchlog where idlog = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, logID);
        sqlStatement.execute();
    }
    public static void main (String[] args) throws SQLException, ClassNotFoundException{
        LogDAO test = new LogDAO();
        test.addAdminLog(1, "Delete member with id 2");
    }
}