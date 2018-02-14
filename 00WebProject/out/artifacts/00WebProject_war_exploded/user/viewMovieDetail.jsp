<%-- 
    Document   : viewMovieDetail
    Created on : Dec 16, 2017, 2:07:08 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    int idMovie = Integer.parseInt(request.getParameter("id"));
    MovieDAO movieDAO = new MovieDAO();
    Movie foundMovie = movieDAO.getMovieByID(idMovie);
    Admin admin = (Admin)session.getAttribute("admin");
    Member member = (Member)session.getAttribute("member");
    String server = "Google Drive";
    if(admin != null){
%>
        <jsp:include page="../admin/include/header.jsp" flush="true" />
<%
    }else{
%>
        <jsp:include page="../include/header.jsp" flush="true" />
<%
    }
%>
<div class="row">
    <div class="col-md-3 col-sm-4 col-xs-0">
        <p class="lead"><%=foundMovie.getMovieName()%></p>     
        <ul class="list-group">
            <li class="list-group-item">Country: <%=foundMovie.getCountry()%></li>
            <li class="list-group-item">Year: <%=foundMovie.getYear()%></li>
            <li class="list-group-item">Length: <%=foundMovie.getLength()%></li>
<%
    CategoryDAO categoryDAO = new CategoryDAO();
    Category foundCategory = categoryDAO.getCategoryByID(foundMovie.getCategoryID());
    String category = foundCategory.getCategoryName();
%>            
            <li class="list-group-item">Category: <%=category%></li>
        </ul>
        <ul class="list-group">
            <a href=<%= "\"viewMovieDetail.jsp?id=" + idMovie + "\"" %> id="trailer" class="btn list-group-item active">Trailer</a>
        </ul>
<%
    if(admin != null){
%>
        <ul class="list-group">
            <a href="../admin/editMovieProcess.jsp?id=<%=foundMovie.getMovieID()%>" class="btn list-group-item">Edit movie</a>
        </ul>
<%
    }
    LinkDAO linkDAO = new LinkDAO();
    List<Link> movieLinks = linkDAO.getLinkByMovieID(idMovie);
%>        
        <ul class="list-group">
<%
        if(movieLinks.size() == 0){
%>            
            <a href="../MovieController?action=watch&movieID=<%=idMovie%>" class="btn list-group-item server" disabled>Watch Movie</a>
<%
        }else{
%>
            <a href="../MovieController?action=watch&movieID=<%=idMovie%>&server=<%=server%>" class="btn list-group-item server">Watch Movie</a>
<%            
        }
%>            
        </ul>
<%
    if(admin != null || member != null){
        int rating = 0;
        if(admin != null){
            rating = movieDAO.getRating(admin.getMemberID(), idMovie);
        }else if(member != null){
            rating = movieDAO.getRating(member.getMemberID(), idMovie);
        }
%>
        <ul class="list-group">
<%
                if(rating == 0){
%>             
            <li style="text-align: center;" class="list-group-item">Your first movie Rating</li>
            <li class="list-group-item">
               
                <form action="../RatingController?action=rate&movieID=<%=idMovie%>" method="POST">
<%
                }else{
%>       
            <li style="text-align: center;" class="list-group-item">Movie Rating</li>
            <li class="list-group-item">
               
                <form action="../RatingController?action=update&movieID=<%=idMovie%>" method="POST">
<%
                }
%>
                    <input type="hidden" name="movieID" value="<%=idMovie%>" class="form-control">
                    <select name="rating" class="form-control">
                        <option value="1">So bad</option>
                        <option value="2">Bad</option>
                        <option value="3">Quite Good</option>
                        <option value="4">Good</option>
                        <option value="5">Excellent</option>
                    </select>
                    <br>
                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                </form>
            </li>
        </ul>
<%
    }
%>         
    </div>
    <div class="col-md-9 col-sm-8 col-xs-12">
     
        <div class="thumbnail">
            <div class="embed-responsive embed-responsive-16by9">
                <iframe src="<%=foundMovie.getTrailerLink()%>" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
            </div>
            <div class="caption-full">
                <p><%=foundMovie.getMovieDescription()%></p>
            </div>
            <div id="fb-root"></div>
            <script>(function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = 'https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.11&appId=150972212340653';
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));</script>
            <div class="fb-comments" data-href="viewMovieDetail.jsp?id=<%=idMovie%>" width="100%" data-numposts="5"></div>
        </div>
    </div>    
</div>
<jsp:include page="../include/footer.jsp" flush="true" />
