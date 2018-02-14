<%-- 
    Document   : memberPage
    Created on : Dec 16, 2017, 8:09:31 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member member = (Member)session.getAttribute("member");
    if(member != null){
%>
        <jsp:include page="../include/header.jsp" flush="true" />
<%
        int idMember = Integer.parseInt(request.getParameter("id"));
        int pageNo = Integer.parseInt(request.getParameter("page"));
        int noOfPage = Integer.parseInt(request.getParameter("noOfPage"));
        MovieDAO movieDAO = new MovieDAO();
        List<Movie> allMovie = movieDAO.getAllFavoriteMovieOfAMemberByID(idMember);
        int numOfMovie = allMovie.size(), count = 0;

        MemberDAO memberDAO = new MemberDAO();
        Member foundMember = memberDAO.getMemberByID(idMember);
%>
    <div class="row">
        <div class="col-md-3 col-sm-4 col-xs-0">
            <p class="lead">
                <img src="<%=foundMember.getProfilePictureLink()%>">
            </p>
            <ul class="list-group">
                <li style="text-align: center;" class="list-group-item"><%=foundMember.getUserName()%></li>
                <li style="text-align: center;" class="list-group-item"><%=foundMember.getEmail()%></li>
            </ul>

            <fieldset class="title">
                <legend>Request Movie</legend>
            </fieldset>
            <form action="../EmailSendingServlet" method="post">
                <div class="form-group">
                    Movie Name
                    <br>
                    <input type="text" name="subject" class="form-control" placeholder="Casablanca" required>
                </div>
                <div class="form-group">
                    Movie Link
                    <br>
                    <input type="text" name="content" class="form-control" placeholder="http://" pattern="https?://.+" title="Include http://">
                </div>
                <button type="submit" class="btn btn-primary btn-block">Submit</button>
                <div class="form-group">
                    <input type="hidden" name="id" class="form-control" value="<%=idMember%>">
                </div>
                <div class="form-group">
                    <input type="hidden" name="recipient" class="form-control" value="huongung155@gmail.com" required>
                </div>
            </form>
        </div>
        <div class="col-md-9 col-sm-8 col-xs-12">
            <div class="row text-center" style="display: flex; flex-wrap: wrap;">
<%
        for(Movie movie: allMovie){
            if((count < pageNo*12) && (count >= (pageNo-1) * 12)){
%>            
                <div class="col-md-4 col-sm-6 col-xs-12">
                    <div class="thumbnail show-image">
                        <p>
                            <a href="delete.jsp?idMember=<%=idMember%>&idMovie=<%=movie.getMovieID()%>" class="btn btn-block"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
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
                    <li><a href="member.jsp?id=<%=idMember%>">1</a></li>
<%
        count = 2;
        while(count <= noOfPage){
            if(count == pageNo){
%>   
                    <li class="active"><a href="memberPage.jsp?id=<%=idMember%>&page=<%=count%>&noOfPage=<%=noOfPage%>"><%=count%></a></li>
<%
            }else{
%>
                    <li><a href="memberPage.jsp?id=<%=idMember%>&page=<%=count%>&noOfPage=<%=noOfPage%>"><%=count%></a></li>
<%
            }
            count++;
        }
%>            
                </ul>
            </nav>
        </div>
    </div>
    <jsp:include page="../include/footer.jsp" flush="true" />
<%
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>    

