<%-- 
    Document   : categoryMovie
    Created on : Dec 16, 2017, 5:56:26 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>

<%
    Admin admin = (Admin)session.getAttribute("admin");
    if(admin != null){
%>
        <jsp:include page="../admin/include/header.jsp" flush="true" />
<%
    }else{
%>
        <jsp:include page="../include/header.jsp" flush="true" />
<%
    }
    int idCategory = Integer.parseInt(request.getParameter("id"));
    CategoryDAO categoryDAO = new CategoryDAO();
    Category foundCategory = categoryDAO.getCategoryByID(idCategory);
    Boolean hasMovie = categoryDAO.isCategoryHasMovie(idCategory);
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> allMovie = movieDAO.getMovieByCategory(idCategory);
    int numOfMovie = allMovie.size(), count = 0;
    int numOfPage = (int)Math.ceil(numOfMovie/12.0);
%>
<div class="page-header">
    <h1 style="display: inline;"><%=foundCategory.getCategoryName()%></h1>
<%
    if(admin != null){
%>    
    <a style="float: left;" href="../CategoryController?action=delete&categoryID=<%=idCategory%>" class="btn" id="delMovie" title="Delete Category"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a> 
<%
    }
%>    
</div>
<div class="row text-center" style="display: flex; flex-wrap: wrap;">
<%
    for(Movie movie: allMovie){
        if(count < 12){
%>        
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="thumbnail show-image">
                    <img src="<%=movie.getPosterLink()%>">
                    <div class="caption">
                        <h4><%=movie.getMovieName()%></h4>
                    </div>
                    <p>
                        <a href="viewMovieDetail.jsp?id=<%=movie.getMovieID()%>" class="btn btn-default btn-block detailButton">Details</a>
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
            <li class="active"><a href="categoryMovie.jsp?id=<%=idCategory%>">1</a></li>
<%
    count = 2;
    while(count <= numOfPage){
%>   
            <li><a href="categoryMoviePage.jsp?id=<%=idCategory%>page=<%=count%>&noOfPage=<%=numOfPage%>"><%=count%></a></li>
<%
        count++;
    }
%>            
        </ul>
    </nav>    
<jsp:include page="../include/footer.jsp" flush="true" />
<script>
    $("#category").addClass("active");
<%
    if(hasMovie){
%>
    $("#delMovie").attr("disabled", true);
<%
    }
%>    
</script>
