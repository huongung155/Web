<%-- 
    Document   : search
    Created on : Dec 19, 2017, 9:01:03 AM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    String keyword = request.getParameter("keyword");
    
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> foundMovies = movieDAO.getMovieByKeyword(keyword);
    
    int numOfMovie = foundMovies.size(), count = 0;
    int numOfPage = (int)Math.ceil(numOfMovie/12.0);
%>
<jsp:include page="../include/header.jsp" flush="true" />
<%
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
            if(count < 12){
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
                <li class="active"><a href="index.jsp">1</a></li>
<%
        count = 2;
        while(count <= numOfPage){
%>       
            <li><a href="searchPage.jsp?id=<%=keyword%>&page=<%=count%>&noOfPage=<%=numOfPage%>"><%=count%></a></li>
<%
            count++;
        }
%>            
            </ul>
        </nav>
<%
    }
%>
<jsp:include page="../include/footer.jsp" flush="true" />
