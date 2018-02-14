<%-- 
    Document   : notMember
    Created on : Dec 17, 2017, 4:23:15 AM
    Author     : huong
--%>
<jsp:include page="../include/header.jsp" flush="true" />
<center>
        <h3>Please log in</h3>
</center>  
<img style="margin-left: 35%; width: 30%;" src="https://myslu.slu.edu/res/images/cas-padlock-icon.png" class="img-rounded">
<jsp:include page="../include/footer.jsp" flush="true" />
<script>
    setTimeout(function() {
        window.location.href = "/MovieStreamingProject/user/login.jsp?result=";
    }, 3000);
</script>