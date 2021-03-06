<%-- 
    Document   : login
    Created on : Dec 11, 2017, 4:15:53 AM
    Author     : huong
--%>
<%@page import="java.sql.*, dao.*, model.*, db.*, email.*, java.util.*"%>

<%
    
    String result = request.getParameter("result");
%>
<jsp:include page="../include/header.jsp" flush="true" />
<div class="row">
    <div class="col-md-4 col-sm-6 col-xs-0">
        <div class="page-header">
            <h1>User sign in</h1>
        </div>
        <form action="../MemberController?action=login" method="POST">
            <div class="form-group">
                Username
                <br>
                <input type="text" name="username" class="form-control" placeholder="Username" required autofocus>
            </div>
            <div class="form-group">
                Password
                <br>
                <input type="password" name="password" class="form-control" placeholder="Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required>
            </div>
            <div id="invalidPass" role="alert">
                
            </div>
            <button type="submit" class="btn btn-primary btn-block">Submit</button>
        </form>
        
        <fieldset class="title">
            <legend>Ads Contact</legend>
        </fieldset>
        <div id="containerAdsContact">
            <abbr title="Gmail">
                <a href="mailto:huongung155@gmail.com">
                    <img class="contactAds" src="https://cdn1.iconfinder.com/data/icons/metro-ui-dock-icon-set--icons-by-dakirby/512/Gmail.png">
                </a>
            </abbr>
            <abbr title="Facebook">
                <a href="https://www.facebook.com/luuminhquan1609">
                    <img class="contactAds" src="http://wp.vcu.edu/davinci/wp-content/uploads/sites/4705/2014/11/square-facebook-512.png">
                </a>
            </abbr>
            <abbr title="Yahoo">
                <a href="mailto:huongung155@yahoo.com">
                    <img class="contactAds" src="http://www.pvhc.net/img147/tlspbmomtixepccjdpce.png">
                </a>
            </abbr>
        </div>
    </div>
    <div class="col-md-8 col-sm-6 col-xs-12">
    <%
        List<String> listAds = new ArrayList<String>();
        List<String> listAdsLink = new ArrayList<String>();
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=1310a150f7f614d7b8ebce8226a56b0af&authkey=ASN-LCW97POjOzF4EGRIfJ0&e=3b541e99a49044b6926f1f542a543e4e");
        listAdsLink.add("https://aws.amazon.com/free/?sc_ichannel=ha&sc_icampaign=signin_prospects&sc_isegment=en&sc_iplace=sign-in&sc_icontent=freetier&sc_segment=-1");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=1c2890311abca4874b7a6cec818a85e84&authkey=AXaF91cQqWAzVL-qnPrX8lM&e=a0c5646036a5496183d966ff550760b7");
        listAdsLink.add("https://aws.amazon.com/new/reinvent/#compute?sc_ichannel=ha&sc_icampaign=launch_reinvent_2017_category-compute&sc_isegment=en&sc_iplace=signin&sc_icontent=launch_reinvent_2017_category-compute");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=1434d055affa54e1eb5cc57b10e064f65&authkey=AcWy9YuNjWFWkhH6bs9DbFw&e=27b0f7ace26e4e888899d5a0cd17e03d");
        listAdsLink.add("https://aws.amazon.com/polly/?&trk=ha_a131L000005Cvf5QAC&sc_ichannel=ha&sc_icampaign=pac_q4_site_merch_sign-in_polly&sc_ioutcome=Product_Adoption_Campaigns&sc_iplace=SignInPage");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=10ccb7ef7e28f4eeea97f92fe26ee0fbf&authkey=Ac2j0B_k9__PABHq_UHIsnk&e=4ddca4a5d7744033b9d86ce9c6ed2475");
        listAdsLink.add("https://aws.amazon.com/dms/?sc_ichannel=ha&sc_icampaign=aware_aws_dms_q4_2017&sc_iplace=signin&sc_icontent=awssm-399");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=10ccb7ef7e28f4eeea97f92fe26ee0fbf&authkey=Ac2j0B_k9__PABHq_UHIsnk&e=4ddca4a5d7744033b9d86ce9c6ed2475");
        listAdsLink.add("https://aws.amazon.com/rekognition/getting-started/?&trk=ha_a131L000005Cvf0QAC&sc_ichannel=ha&sc_icampaign=pac_q4_site_merch_sign-in_rekognition&sc_ioutcome=Product_Adoption_Campaigns&sc_iplace=SignInPage");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=167c06021592b43b0b3f93dfa918d699f&authkey=AdS4d2J7pMr0pnjdYJWCrMI&e=777b2a436c2a4f569335861e71782bb5");
        listAdsLink.add("https://aws.amazon.com/lambda/?&trk=ha_a131L000005CveqQAC&sc_ichannel=ha&sc_icampaign=pac_q4_site_merch_sign-in_lambda&sc_ioutcome=Product_Adoption_Campaigns&sc_iplace=SignInPage");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=1aa3bef5a55114f5790c093d266741088&authkey=AQjzGSB9ytmTLMIHU_0oeOY&e=9b23daef912341a587d807f6acea21a6");
        listAdsLink.add("https://aws.amazon.com/new/reinvent/#containers?sc_ichannel=ha&sc_icampaign=launch_reinvent_2017_category-containers&sc_isegment=en&sc_iplace=signin&sc_icontent=launch_reinvent_2017_category-containers");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=1fde7a10633d04e17995216ab2f6e452f&authkey=AemNvz1YeTxfE424ac-Amf8&e=c88d7dfc28ad4e738c968201140f1fd2");
        listAdsLink.add("https://aws.amazon.com/new/reinvent/?sc_ichannel=ha&sc_icampaign=event_recap_reinvent17&sc_iplace=sign-in&sc_icontent=recap_reinvent17");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=153a023151ad041c7970bab2dfa7c94a5&authkey=Acmk-qj3wtchcK1nZh9dl6s&e=c5395f987553469a85329115ee4be535");
        listAdsLink.add("https://aws.amazon.com/new/reinvent/#databases?sc_ichannel=ha&sc_icampaign=launch_reinvent_2017_category-databases&sc_isegment=en&sc_iplace=signin&sc_icontent=launch_reinvent_2017_category-databases");
        
        listAds.add("https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=15fc0d87b7258406da734c00f9be7ea8c&authkey=ASX9DwtGR9wjJ7ckjsxJl_M&e=8f8721d617104622b676a9028eb13550");
        listAdsLink.add("https://aws.amazon.com/kinesis/getting-started/?&trk=ha_a131L000005CvfPQAS&sc_ichannel=ha&sc_icampaign=pac_q4_site_merch_sign-in_kinesis&sc_ioutcome=Product_Adoption_Campaigns&sc_iplace=SignInPage");
        
        int n = new Random().nextInt(listAds.size());
        
        String ad = listAds.get(n);
        String adLink = listAdsLink.get(n);
    %>
        <div class="thumbnail">
            <a href="<%=adLink%>" target="_blank">
                <img style="padding-top: 5%;" src="<%=ad%>">
            </a>
        </div>
    </div>
</div>
<jsp:include page="../include/footer.jsp" flush="true" />
<script>
    $("#login").addClass("active");
<%
    if(result.equals("invalid")){
%>
    $("#invalidPass").addClass("alert alert-danger");
    $("#invalidPass").text("User doess not exist");
    $("#invalidPass").css("padding", "2%");
<%    
    }
%>    
</script>
