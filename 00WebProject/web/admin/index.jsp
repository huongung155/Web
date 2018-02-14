<%-- 
    Document   : index
    Created on : Dec 11, 2017, 6:01:12 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Admin admin = (Admin)session.getAttribute("admin");
    if(admin != null){
%>
    <jsp:include page="include/header.jsp" flush="true" />
<%
        MovieDAO movieDAO = new MovieDAO();
        List<Movie> allMovie = movieDAO.getAllMovie();
        int numOfMovie = allMovie.size(), count = 0;
        int numOfPage = (int)Math.ceil(numOfMovie/12.0);
%>
    <div style="text-align: center;" class="page-header">
        <h1>Hello Admin, <%=admin.getUserName()%></small></h1>
    </div>
        <div class="row text-center" style="display: flex; flex-wrap: wrap;">
<%
        for(Movie movie: allMovie){
            if(count < 12){
%>        
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="thumbnail show-image">
                        <p>
                            <a href="../MovieController?action=delete&movieID=<%=movie.getMovieID()%>" class="btn btn-block"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
                        </p>
                        <img src="<%=movie.getPosterLink()%>">
                        <div class="caption">
                            <h4><%=movie.getMovieName()%></h4>
                        </div>
                        <p>
                            <a href="../user/viewMovieDetail.jsp?id=<%=movie.getMovieID()%>" class="btn btn-default btn-block detailButton">Details</a>
                        </p>
                    </div>
                </div>
<%
            }
            count++;
        }
%>
        </div>
        <nav style="text-align: center;" aria-label="Page navigation">
            <ul class="pagination">
                <li class="active"><a href="index.jsp">1</a></li>
<%
        count = 2;
        while(count <= numOfPage){
%>   
                <li><a href="indexPage.jsp?page=<%=count%>&noOfPage=<%=numOfPage%>"><%=count%></a></li>
<%
            count++;
        }
%>            
            </ul>
        </nav>
    <jsp:include page="include/footer.jsp" flush="true" />
    <script>
        $("#removeMovie").addClass("active");
    </script>
<%
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>    