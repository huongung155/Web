<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	 "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../include/header.jsp" flush="true" />
<%
    String status = (String)request.getAttribute("Message");
    int id = Integer.parseInt(request.getParameter("id"));
%>
	<center>
		<h3><%=status%></h3>
	</center>   
                
<%
    if(status.equals("The e-mail was sent successfully")){
%>
    <img style="margin-left: 35%; width: 30%;" src="http://timbergrove-staging.arsfutura.co/assets/icon-contact-success-d2727d4f41f54eb503c74f3b1216056d.png" class="img-rounded">
<%
    }else{
%>
    <img style="margin-left: 35%; width: 30%;" src="https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=1791bd73372e84ca48addc7f26b4412e4&authkey=AfWCDYZF2hhob4LYU_8KqFg&e=71d61e2700e8479287c7a5da6f188150" class="img-rounded">
<%
}
    
%>
<jsp:include page="../include/footer.jsp" flush="true" />
<script>
    setTimeout(function() {
        window.location.href = "/member/member.jsp?id=<%=id%>";
    }, 4000);
</script>