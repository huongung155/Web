/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import db.DBConnection;
import java.sql.*;
import java.util.*;
import model.*;
import security.AES;
/**
 *
 * @author Duy Le
 */
public class MemberDAO {
    private final Connection dbConnection;
    public MemberDAO() throws SQLException, ClassNotFoundException{
        dbConnection = DBConnection.getConnection();
    }
    public ArrayList<Member> getAllMember() throws SQLException{
        Statement sqlStatement = dbConnection.createStatement();
        ResultSet allMember = sqlStatement.executeQuery("select * from member where idMember not in (select idMember from admin)");
        ArrayList<Member> memberList = new ArrayList<>();
        while(allMember.next()){
            memberList.add(new Member(allMember.getInt("idMember"),allMember.getString("userName"),allMember.getString("password")
                    ,allMember.getString("email"),allMember.getString("profilePictureLink")));
            
        }
        return memberList;
    }
    public boolean isMemberWithEmailExist (String email) throws SQLException{
        Statement  sqlStatement = dbConnection.createStatement();
        ResultSet resultSet = sqlStatement.executeQuery("select * from member where member.email = '"+email+"'");
        return resultSet.next();
    }
    
    public void addMember(String userName,String password,String email,String profilePictureLink) throws SQLException,ClassNotFoundException{
        String sqlQuery = "insert into member (userName,password,email,profilePictureLink) values (?,?,?,?)";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,userName);
        sqlStatement.setString(2, password);
        sqlStatement.setString(3,email);
        sqlStatement.setString(4,profilePictureLink);
        sqlStatement.execute();
    }
    public void addMember(String userName,String password,String email) throws SQLException,ClassNotFoundException{
        String sqlQuery = "insert into member (userName,password,email) values (?,?,?)";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,userName);
        sqlStatement.setString(2, password);
        sqlStatement.setString(3,email);
        sqlStatement.execute();
    }
    public boolean isMemberWithUserNameExist (String userName) throws SQLException{
        Statement  sqlStatement = dbConnection.createStatement();
        ResultSet resultSet = sqlStatement.executeQuery("select * from member where member.userName = '"+userName+"'");
        return resultSet.next();
    }
    
    public boolean isLoginInformationCorrect(String userName,String password) throws SQLException{
        String sqlQuery = "select * from member where member.userName = ? and member.password = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, userName);
        sqlStatement.setString(2, password);
        ResultSet resultSet = sqlStatement.executeQuery();
        return resultSet.next();
    }
    
    public void deleteMember(int memberID) throws SQLException{
        String sqlQuery = "delete from member where member.idMember = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,Integer.toString(memberID));
        sqlStatement.execute();
    }
    
    public Member getMemberByID(int memberID) throws SQLException{
        String sqlQuery = "select * from member where member.idMember = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,Integer.toString(memberID));
        ResultSet resultSet = sqlStatement.executeQuery();
        Member resultMember = null;
        while(resultSet.next()){
            resultMember = new Member(resultSet.getInt("idMember"),resultSet.getString("userName"),resultSet.getString("password"),
                    resultSet.getString("email"),resultSet.getString("profilePictureLink"));
        }
        return resultMember;
    }
    public Member getMemberByUserName(String userName) throws SQLException{
        String sqlQuery = "select * from member where member.userName = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,userName);
        ResultSet resultSet = sqlStatement.executeQuery();
        Member resultMember = null;
        while(resultSet.next()){
            resultMember = new Member(resultSet.getInt("idMember"),resultSet.getString("userName"),resultSet.getString("password"),
                    resultSet.getString("email"),resultSet.getString("profilePictureLink"));
        }
        return resultMember;
    }
    public void updateUserPassword(String password,int memberID) throws SQLException{
        password = AES.encrypt(password, "bestmoviesite");
        String sqlQuery = "update member set password = ? where idMember = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, password);
        sqlStatement.setInt(2,memberID);
        sqlStatement.execute();
    }
    public void updateProfilePictureLink(String profilePictureLink,int memberID) throws SQLException{
        String sqlQuery = "update member set profilePictureLink = ? where idMember = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, profilePictureLink);
        sqlStatement.setInt(2,memberID);
        sqlStatement.execute();
    }
    public boolean isInFavorite(int memberID,int movieID) throws SQLException{
        String sqlQuery = "select * from favorite where favorite.idMember = ? and favorite.idMovie = ? ;" ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1,Integer.toString(memberID));
        sqlStatement.setString(2,Integer.toString(movieID));
        ResultSet resultSet = sqlStatement.executeQuery();
        return resultSet.next();
    }
    
    public void addMovieToFavorite(int memberID,int movieID) throws SQLException{
        String sqlQuery = "insert into favorite (idmember,idmovie) values(?,?)" ;
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, memberID);
        sqlStatement.setInt(2, movieID);
        sqlStatement.execute();
    }
    
    public void updateEmail(String email,int memberID) throws SQLException{
        String sqlQuery = "update member set email = ? where idMember = ? ; " ;      
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, email);
        sqlStatement.setInt(2,memberID);
        sqlStatement.execute();
    }
//    public static void main(String[] args) throws SQLException, ClassNotFoundException{
//        MemberDAO test = new MemberDAO();
//        test.addMember("TD2106", "lutden", "thanhduy2106@gmail.com");
//    }
}