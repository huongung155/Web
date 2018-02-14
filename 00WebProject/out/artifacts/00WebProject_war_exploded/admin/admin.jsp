<%-- 
    Document   : admin
    Created on : Dec 20, 2017, 8:28:04 PM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>
<%
    Admin admin = (Admin)session.getAttribute("admin");
    if(admin != null){
        LogDAO logDAO = new LogDAO();
        List<AdminLog> allAdminLog = logDAO.getAllAdminLog();
%>
<jsp:include page="include/header.jsp" flush="true" />
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Member ID</th>
                    <th>Action</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>
<%
                for(AdminLog adminLog: allAdminLog){
%>                  
                <tr>
                    <td><%=adminLog.getMemberID()%></td>
                    <td><%=adminLog.getActionTaken()%></td>
                    <td><%=adminLog.getTime()%></td>
                </tr>
<%
                }
%>
            </tbody>
        </table>
<jsp:include page="include/footer.jsp" flush="true" />            
<script>
    $("#adminLog").addClass("active");
</script>
<%
    }else{
        response.sendRedirect("../MemberController?action=logout");
    }
%>
