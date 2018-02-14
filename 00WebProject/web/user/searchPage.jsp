<%-- 
    Document   : searchPage
    Created on : Dec 19, 2017, 9:22:08 AM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    int pageNo = Integer.parseInt(request.getParameter("page"));
    int noOfPage = Integer.parseInt(request.getParameter("noOfPage"));
    int count = 0;
    String keyword = request.getParameter("id");
    
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> foundMovies = movieDAO.getMovieByKeyword(keyword);
%>
<jsp:include page="../include/header.jsp" flush="true" />
    <div class="row text-center" style="display: flex; flex-wrap: wrap;">
<%
    for(Movie foundMovie: foundMovies){
        if((count < pageNo*12) && (count >= (pageNo-1) * 12)){
%>        
        <div class="col-md-3 col-sm-6 col-xs-12">
            <div class="thumbnail show-image">
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
        count++;
    }
%> 
    </div>
        <nav style="text-align: center;" aria-label="Page navigation">
        <ul class="pagination">
            <li><a href="../user/search.jsp?keyword=<%=keyword%>">1</a></li>
<%
    count = 2;
    while(count <= noOfPage){
        if(count == pageNo){
%>   
            <li class="active"><a href="searchPage.jsp?id=<%=keyword%>&page=<%=count%>&noOfPage=<%=noOfPage%>"><%=count%></a></li>
<%
        }else{
%>
            <li><a href="searchPage.jsp?id=<%=keyword%>&page=<%=count%>&noOfPage=<%=noOfPage%>"><%=count%></a></li>
<%      }
        count++;
    }
%>            
        </ul>
    </nav>
<jsp:include page="../include/footer.jsp" flush="true" />