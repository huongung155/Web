<%-- 
    Document   : header
    Created on : Dec 5, 2017, 9:06:39 AM
    Author     : huong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Watching Movie Website</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        
        
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.8.0.min.js"></script>
        <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/js/bootstrap.js'></script>
        
        <script type="text/javascript" src="../javascript/jquery.autocomplete.js"></script>
        
        <script language="javascript" type="text/javascript">

            jQuery(function () {
                $("#advSearch").autocomplete("list.jsp");
            });
        </script>
        
        <link rel="stylesheet" href="../css/style.css">
        <script type="text/javascript" src="../javascript/script.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-default">
<%
    Admin admin = (Admin)session.getAttribute("admin");
%>            
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-nav-demo" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../admin/index.jsp"><span class="glyphicon glyphicon-film" aria-hidden="true"></span>Movie Watching <small>for Admin</small></a>
                </div>
                <div class="collapse navbar-collapse" id="bs-nav-demo">
                    <ul class="nav navbar-nav">
                        <li id="category" class="dropdown">
                            <a id="categoryName" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Category<span class="caret"></span></a>
                            <ul class="dropdown-menu">
<%  
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategory();
    for(Category category: categories){
%>    
                                <li><a href="../user/categoryMovie.jsp?id=<%=category.getCategoryID()%>" class="btn"><%=category.getCategoryName()%></a></li>

<%
    }

%>              
                            <form action="../CategoryController?action=add" method="POST">
                                <div style="position: relative;" class="form-group">
                                    <input type="text" name="categoryName" class="form-control" placeholder="Name" required>
                                    <button style="position: absolute; right: 0%; top: 2%;" type="submit" class="btn btn-success" title="Add Category"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
                                </div>
                                
                            </form>
                            </ul>
                        </li>
                    </ul>
                    <div class='nav navbar-nav navbar-right'>
                        <li id="adSearch"><a href="../user/advanceSearch.jsp">Advance Search</a></li>
                        <li id="removeAcc"><a href="../admin/removeAcc.jsp">Remove Account</a></li>
                        <li id="addMovie"><a href="../admin/addMovie.jsp">Add Movies</a></li>
                        <li id="adminLog"><a href="../admin/admin.jsp">Admin Log</a></li>
                        <li id="profile"><a href="../member/member.jsp?id=<%=admin.getMemberID()%>" title="View your profile">Hello <%=admin.getUserName()%></a></li>
                        <li><a href="../MemberController?action=logout">Logout</a></li>
                    </div>
                </div>
            </div>
        </nav>
        <div class="container-fluid">