<%-- 
    Document   : member
    Created on : Dec 16, 2017, 6:51:15 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member member = (Member)session.getAttribute("member");
    Admin admin = (Admin)session.getAttribute("admin");
    Member foundMember = null;
    int idMember = Integer.parseInt(request.getParameter("id"));
    
    if(member != null || admin != null){
        MovieDAO movieDAO = new MovieDAO();
        List<Movie> allMovie = movieDAO.getAllFavoriteMovieOfAMemberByID(idMember);
        int numOfMovie = allMovie.size(), count = 0;
        int numOfPage = (int)Math.ceil(numOfMovie/12.0);

        MemberDAO memberDAO = new MemberDAO();
        foundMember = memberDAO.getMemberByID(idMember);
        if(member != null && member.getMemberID() == idMember){
            
%>
            <jsp:include page="../include/header.jsp" flush="true" />
<%
        }else if(admin != null && admin.getMemberID() == idMember){
%>
            <jsp:include page="../admin/include/header.jsp" flush="true" />
<%
        }else{
            response.sendRedirect("../MemberController?action=logout");
        }
%>        
        <div class="row">
            <div class="col-md-3 col-sm-4 col-xs-0">
                <p class="lead">
                    <div class="wrapper">
<%
                        String profileLink = foundMember.getProfilePictureLink();
                        if(profileLink.isEmpty()){
                            
%>                        
                        <img src="http://mahasethu.com/user_content/tn-acc/member.png">
<%
                        }else{
%>                        
                        <img src="<%=foundMember.getProfilePictureLink()%>">
<%
                        }
%>
                        <a href="../member/editInfo.jsp?idMember=<%=idMember%>&result=" title="Edit your info"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
                    </div>

                </p>
                <ul class="list-group">
                    <li style="text-align: center;" class="list-group-item"><%=foundMember.getUserName()%></li>
                    <li style="text-align: center;" class="list-group-item"><%=foundMember.getEmail()%></li>
                </ul>
<%
                if(member != null && member.getMemberID() == idMember){
%>        
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
<%
                }
%>                    
            </div>
            <div class="col-md-9 col-sm-8 col-xs-12">
                <div class="row text-center" style="display: flex; flex-wrap: wrap;">
<%
            for(Movie movie: allMovie){
                if(count < 12){
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
                        <li class="active"><a href="member.jsp?id=<%=idMember%>">1</a></li>
<%
            count = 2;
            while(count <= numOfPage){
%>   
                        <li><a href="memberPage.jsp?id=<%=idMember%>&page=<%=count%>&noOfPage=<%=numOfPage%>"><%=count%></a></li>
<%
                count++;
            }
%>            
                    </ul>
                </nav>
            </div>
        </div>
        <jsp:include page="../include/footer.jsp" flush="true" />
        <script>
            $("#profile").addClass("active");
            $("#categoryName").html("Favorite<span class=\"caret\"></span>");
            $("#categoryName + .dropdown-menu").html("<li><a href=\"../member/history.jsp\" class=\"btn\">History</a></li>");
        </script>
<%
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>

