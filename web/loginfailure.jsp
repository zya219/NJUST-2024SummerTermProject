<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/7/11
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path =request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
    int errorCode=(Integer)request.getAttribute("errorCode");
%>
<html>
<head>
    <title>登陆失败</title>
    <jsp:useBean id="loginForm" class="bean.Visitor" scope="request"></jsp:useBean>
    <script>
        function getFailureInfo(){
            let failureInfo=document.getElementById("failureInfo");
            switch (<%=errorCode%>){
                case 1:
                    failureInfo.innerHTML="用户信息错误"
                    break;
                case 2:
                    failureInfo.innerHTML="用户信息错误"
                    break;
                case 3:
                    failureInfo.innerHTML="密码错误"
                    break;
            }

        }
    </script>
</head>
<body>
<p>登录失败！</p>
失败原因：<span id="failureInfo"></span>
<script>getFailureInfo();</script><br>

<a
       <%
       if(errorCode==1){%>
        href="./visitorlogin.jsp"
       <% }else{%>
        href="./managerlogin.jsp"
            <% }%>
        >重新登录</a>

</body>
</html>

