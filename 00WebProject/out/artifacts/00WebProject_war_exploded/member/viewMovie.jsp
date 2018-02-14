<%-- 
    Document   : viewMovie
    Created on : Dec 16, 2017, 1:43:43 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member member = (Member)session.getAttribute("member");
    Admin admin = (Admin)session.getAttribute("admin");
    int idMovie = Integer.parseInt(request.getParameter("id"));
    String serverName = request.getParameter("server");
    
    MemberDAO memberDAO = new MemberDAO();
    
    MovieDAO movieDAO = new MovieDAO();
    Movie foundMovie = movieDAO.getMovieByID(idMovie);
    LinkDAO linkDAO = new LinkDAO();
    List<Link> movieLinks = linkDAO.getLinkByMovieID(idMovie);
    
    int linkNo = 0, count = 0;
    if(admin != null){
%>
    <jsp:include page="../admin/include/header.jsp" flush="true" />
    <div class="row">
        <div class="col-md-3 col-sm-4 col-xs-0">
            <p class="lead"><%=foundMovie.getMovieName()%></p>
            <ul class="list-group">
                <li style="text-align: center;" class="list-group-item">Choose server to watch</li>
                <li class="list-group-item">
                    <form action="../MovieController?action=watch&movieID=<%=idMovie%>" method="POST">
                    <select style="text-align-last: center;" name="server" class="form-control">
<%
                    
                    for(Link movieLink: movieLinks){
                        if(movieLink.getServerName().equals(serverName)){
                            linkNo = count;
%>
                            <option value="<%=movieLink.getServerName()%>" selected><%=movieLink.getServerName()%></option>
<%
                        }else{
%>
                            <option value="<%=movieLink.getServerName()%>"><%=movieLink.getServerName()%></option>
<%
                        }
                        count++;
                    }
%>
                        </select>
                        <br>
                        <button type="submit" class="btn btn-primary btn-block">Submit</button>
                    </form>
                </li>
            </ul>
            <hr>
            <form action="../MemberController?action=delete" method="POST">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
<%
                        for(Link movieLink: movieLinks){
%>                        
                            <tr>
                                <td style="text-align: center;">
                                    <input type="checkbox" name="linkID" value="<%=movieLink.getLinkID()%>">
                                </td>
                                <td><%=movieLink.getServerName()%></td>
                            </tr>
<%
                        }
%>                            
                    </tbody>
                </table>
                <button class="btn btn-danger btn-block">Delete these links</button>
            </form>
            <hr>
            <form action="../LinkController?action=add&movieID=<%=idMovie%>" method="POST">
                <div class="form-group">
                    Movie Server
                    <br>
                    <input name="serverName" type="text" name="" class="form-control" placeholder="Movie Name" required autofocus>
                </div>
                <div class="form-group">
                    Movie Link
                    <br>
                    <input name="movieLink" type="text" class="form-control" placeholder="http://" pattern="https?://.+" title="Include http://">
                </div>
                <button class="btn btn-success btn-block">Add movie link</button>
            </form>
        </div>
        <div class="col-md-9 col-sm-8 col-xs-12">
            <div class="thumbnail">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe src="<%=movieLinks.get(linkNo).getMovieLink()%>" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../admin/include/footer.jsp" flush="true" /> 
<%
    }
    else if(member != null){
%>
    <jsp:include page="../include/header.jsp" flush="true" />
    <div class="row">
        <div class="col-md-3 col-sm-4 col-xs-0">
            <p class="lead"><%=foundMovie.getMovieName()%></p>
            <ul class="list-group">
<%
            if(memberDAO.isInFavorite(member.getMemberID(), foundMovie.getMovieID())){
%>
                <a class="btn list-group-item" disabled><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Added to favorite</a>
<%
            }else{
%>
                <a href="../MemberController?action=addFavorite&id=<%=idMovie%>" class="btn list-group-item" >Add to favorite</a>
<%                
            }
%>            
            </ul>
            <ul class="list-group">
                <li style="text-align: center;" class="list-group-item">Choose server to watch</li>
                <li class="list-group-item">
                    <form action="../MovieController?action=watch&movieID=<%=idMovie%>" method="POST">
                    <select style="text-align-last: center;" name="server" class="form-control">
<%
                    
                    for(Link movieLink: movieLinks){
                        if(movieLink.getServerName().equals(serverName)){
                            linkNo = count;
%>
                            <option value="<%=movieLink.getServerName()%>" selected><%=movieLink.getServerName()%></option>
<%
                        }else{
%>
                            <option value="<%=movieLink.getServerName()%>"><%=movieLink.getServerName()%></option>
<%
                        }
                        count++;
                    }
%>
                        </select>
                        <br>
                        <button type="submit" class="btn btn-primary btn-block">Submit</button>
                    </form>
                </li>
                

            </ul>
<%
        if(foundMovie.getAverageRating() != 0){
%>            
            <ul class="list-group">
                <li style="text-align: center;" class="list-group-item">Rating</li>
                <li style="text-align: center;" class="list-group-item"><%=foundMovie.getAverageRating()%></li>
            </ul>
<%
        }
        int rating = movieDAO.getRating(member.getMemberID(), foundMovie.getMovieID());
%>
        </div>
        <div class="col-md-9 col-sm-8 col-xs-12">
            <div class="thumbnail">
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe src="<%=movieLinks.get(linkNo).getMovieLink()%>" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../include/footer.jsp" flush="true" />
<%
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>    