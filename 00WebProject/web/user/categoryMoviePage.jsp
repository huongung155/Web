<%-- 
    Document   : categoryMoviePage
    Created on : Dec 16, 2017, 6:01:32 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<jsp:include page="../include/header.jsp" flush="true" />
<%
    int idCategory = Integer.parseInt(request.getParameter("id"));
    int pageNo = Integer.parseInt(request.getParameter("page"));
    int noOfPage = Integer.parseInt(request.getParameter("noOfPage"));
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> allMovie = movieDAO.getMovieByCategory(idCategory);
    int numOfMovie = allMovie.size(), count = 0;
%>
    <div class="row text-center" style="display: flex; flex-wrap: wrap;">
<%  for(Movie movie: allMovie){
        if((count < pageNo*12) && (count >= (pageNo-1) * 12)){
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
            <li><a href="categoryMovie.jsp?id=<%=idCategory%>">1</a></li>
<%
    count = 2;
    while(count <= noOfPage){
        if(count == pageNo){
%>   
            <li class="avtive"><a href="categoryMoviePage.jsp?id=<%=idCategory%>page=<%=count%>&noOfPage=<%=noOfPage%>"><%=count%></a></li>
<%
        }else{
%>
            <li><a href="categoryMoviePage.jsp?id=<%=idCategory%>page=<%=count%>&noOfPage=<%=noOfPage%>"><%=count%></a></li>
<%            
        }
        count++;
    }
%>            
        </ul>
    </nav>
<jsp:include page="../include/footer.jsp" flush="true" />
