<%-- 
    Document   : editMovie
    Created on : Dec 17, 2017, 1:52:24 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member admin = (Admin)session.getAttribute("admin");
    if(admin != null){
%>
        <jsp:include page="include/header.jsp" flush="true" />
            <div style="text-align: center;" class="page-header">
                <h1>Edit Movie</h1>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th></th>
                        <th>Movie Name</th>
                        <th>Country</th>
                        <th>Year</th>
                        <th>Duration</th>
                        <th>Category</th>
                    </tr>
                </thead>
                <tbody>
<%
                    MovieDAO movieDAO = new MovieDAO();
                    List<Movie> allMovie = movieDAO.getAllMovie();
                    for(Movie movie: allMovie){
%>                    
                    <tr>
                        <td style="text-align: center;">
                            <a href="editMovieProcess.jsp?id=<%=movie.getMovieID()%>" class="btn btn-block"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                        </td>
                        <td><%=movie.getMovieName()%></td>
                        <td><%=movie.getCountry()%></td>
                        <td><%=movie.getYear()%></td>
                        <td><%=movie.getLength()%></td>
                        <td><%=movie.getCategoryID()%></td>
                    </tr>
<%
                    }
%>
                </tbody>
            </table>
        <jsp:include page="include/footer.jsp" flush="true" />
        <script>
            $("#editMovie").addClass("active");
        </script>
<%
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>
