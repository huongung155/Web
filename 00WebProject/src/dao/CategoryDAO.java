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
public class CategoryDAO {
    private final Connection dbConnection;
    public CategoryDAO() throws SQLException, ClassNotFoundException{
        dbConnection = DBConnection.getConnection();
    }
    public ArrayList<Category> getAllCategory() throws SQLException{
        ArrayList<Category> result = new ArrayList<>();
        String sqlQuery = "select * from category";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        ResultSet resultSet = sqlStatement.executeQuery();
        while(resultSet.next()){
            result.add(new Category(resultSet.getInt("idcategory"),resultSet.getString("categoryname")));
        }
        return result;
    }
    public void addCategory(String categoryName) throws SQLException{
        String sqlQuery = "insert into category (categoryname) values (?)";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setString(1, categoryName);
        sqlStatement.execute();
    }
    public void deleteCategory(int categoryID) throws SQLException{
        String sqlQuery = "delete from category where idcategory = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, categoryID);
        sqlStatement.execute();
    }
    
    public Category getCategoryByID(int categoryID) throws SQLException{
        String sqlQuery = "select * from category where idcategory = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, categoryID);
        ResultSet resultSet = sqlStatement.executeQuery();
        Category category = null;
        while(resultSet.next()){
            category = new Category(resultSet.getInt("idcategory"),resultSet.getString("categoryname"));
        }
        return category;
    }
    public boolean isCategoryHasMovie(int categoryID) throws SQLException{
        String sqlQuery = "select idmovie from movie where idcategory = ?";
        PreparedStatement sqlStatement = dbConnection.prepareStatement(sqlQuery);
        sqlStatement.setInt(1, categoryID);
        ResultSet resultSet = sqlStatement.executeQuery();
        return resultSet.next();
    }
//    public static void main(String[] args) throws SQLException,ClassNotFoundException{
//        CategoryDAO test = new CategoryDAO();
//        Category t = test.getCategoryByID(0);
//        if(t == null) System.out.println(123);
//    }
}