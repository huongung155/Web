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
        
        
        <script id="jqVer" type="text/javascript" src="https://code.jquery.com/jquery-1.8.0.min.js"></script>
        <script id="btVer" type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/js/bootstrap.js'></script>
        
        
        
        
        <script type="text/javascript" src="../javascript/jquery.autocomplete.js"></script>
        <script language="javascript" type="text/javascript">

            jQuery(function () {
                $("#search").autocomplete("../user/list.jsp");
            });
        </script>
        
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
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-nav-demo" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../user/index.jsp"><span class="glyphicon glyphicon-film" aria-hidden="true"></span>Movie Watching</a>
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
                            </ul>
                        </li>
                    </ul>
                    <form action="../user/search.jsp" method="POST" class="navbar-form navbar-left">
                        <div class="form-group">
                            <input name="keyword" type="text" class="form-control" id="search" placeholder="Search Movie">
                            
                            
                        </div>
                        <button type="submit" id="searchButton" class="btn btn-default">Search</button>
                    </form>
                    <div class='nav navbar-nav navbar-right'>
<%
    Member member = (Member)session.getAttribute("member");
%>    
                        <li id="adSearch"><a href="../user/advanceSearch.jsp">Advance Search</a></li>
<%                        
    if(member == null){
%>                        
                        <li id="login"><a href="../user/login.jsp?result=">Login</a></li>
                        <li id="register"><a href="../user/register.jsp?result=">Sign up</a></li>
<%
    }else{
%>        
                        <li id="profile"><a href="../member/member.jsp?id=<%=member.getMemberID()%>" title="View your profile">Hello <%=member.getUserName()%></a></li>
                        <li><a href="../MemberController?action=logout">Logout</a></li>
<%                      
    }
%>                        
                    </div>
                </div>
            </div>
        </nav>
        <div class="container-fluid">