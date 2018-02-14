<%-- 
    Document   : advanceSearchProcess
    Created on : Dec 19, 2017, 12:21:05 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Admin admin = (Admin)session.getAttribute("admin");
    String keyword = request.getParameter("keyword");
    String[] isDescs = request.getParameterValues("isCheck");
    String category = request.getParameter("category");
    int idCategory = 0;
    if(category != null){
        idCategory = Integer.parseInt(request.getParameter("category"));
    }
    
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> foundMovies = null;
    if(isDescs != null){
        int isSize = isDescs.length;
        if(isSize == 2){
            foundMovies = movieDAO.getMovieByKeywordAndDescriptionAndCategory(keyword, idCategory);
        }else{
            if(isDescs[0].equals("cat")){
                foundMovies = movieDAO.getMovieByKeywordAndCategory(keyword, idCategory);
            }else{
                foundMovies = movieDAO.getMovieByKeywordAndDescription(keyword);
            }
        }
    }else{
        foundMovies = movieDAO.getMovieByKeyword(keyword);
    }
    int numOfMovie = foundMovies.size();
%>
<%
    if(admin != null){
%>
        <jsp:include page="../admin/include/header.jsp" flush="true" />
<%
    }else{
%>
        <jsp:include page="../include/header.jsp" flush="true" />
<%
    }
    if(foundMovies.isEmpty()){
%>
    <div class="page-header">
        <h1>Sorry, Your movie will be updated later</h1>
    </div>
<%
    }else{
%>
    <div class="page-header">
        <h1>Found <%=numOfMovie%> movies</h1>
    </div> 
    <div class="row text-center" style="display: flex; flex-wrap: wrap;">
<%
        for(Movie foundMovie: foundMovies){
%>  
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="thumbnail show-image">
<%
                        if(admin != null){
%>
                            <p>
                                <a href="../admin/deleteMovie.jsp?idMovie=<%=foundMovie.getMovieID()%>" class="btn btn-block"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
                            </p>
<%
                        }
%>
                        <img src="<%=foundMovie.getPosterLink()%>">
                    
                        <div class="caption">
                            <h4><%=foundMovie.getMovieName()%></h4>
                        </div>
                        <p>
                            <a href="viewMovieDetail.jsp?id=<%=foundMovie.getMovieID()%>" class="btn btn-default btn-block detailButton">Details</a>
                        </p>
                    </div>
                </div>
<%
        }
%>
    </div>
<%
    }
%>
<jsp:include page="../include/footer.jsp" flush="true" />
<script>
    $("#adSearch").addClass("active");
</script>	
