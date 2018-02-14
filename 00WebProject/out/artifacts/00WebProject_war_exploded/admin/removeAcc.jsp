<%-- 
    Document   : removeAcc
    Created on : Dec 11, 2017, 6:08:39 PM
    Author     : huong
--%>

<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Member admin = (Admin)session.getAttribute("admin");
    if(admin != null){
        MemberDAO memberDAO = new MemberDAO();
        List<Member> allMember = memberDAO.getAllMember();
    
//out.println("Subjects: <br>");
//String[] subjects = request.getParameterValues("subject");
//if(subjects != null){
//    for(int i = 0; i < subjects.length; i++){
//        out.println(subjects[i] + "<br>");
//    }
//}
%>
    <jsp:include page="include/header.jsp" flush="true" />
    <div style="text-align: center;" class="page-header">
        <h1>Remove Account</h1>
    </div>
    <form action="../MemberController?action=delete" method="POST">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th></th>
                    <th>User Name</th>
                    <th>Password</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
<%
            for(Member member: allMember){
%>            
                <tr>
                    <td style="text-align: center;">
                        <input type="checkbox" name="account" value="<%=member.getMemberID()%>">
                    </td>
                    <td><%=member.getUserName()%></td>
                    <td><%=member.getPassword()%></td>
                    <td><%=member.getEmail()%></td>
                </tr>
<%
            }
%>            
            </tbody>
        </table>
        <button style="margin-left: 30%; width: 40%;" class="btn btn-danger btn-lg btn-block">Delete</button>
    </form>
    <jsp:include page="include/footer.jsp" flush="true" />
    <script>
        $("#removeAcc").addClass("active");
    </script>
<%
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>