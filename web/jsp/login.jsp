<%--
  Created by IntelliJ IDEA.
  User: 刘晖
  Date: 2019/5/20
  Time: 19:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        var errorMsg = "";

        $(function(){
            errorreturn();
            $("#errWindow").hide();
            $("#errWindow").empty();
            $("#sunmitClick").click(function (){
                $("#errWindow").empty();
                $.post("${pageContext.request.contextPath}/user?method=yzm",{yzm:$("#yzm").val()},function (result) {
                    if(result != 'true'){
                        errorMsg = "验证码错误";
                        $("#errWindow").show();
                        $("#errWindow").append(errorMsg);
                    }else{
                        errorMsg = "";
                        if($("#yzm").val()== "" ||$("#yzm").val() == null||$("#yzm").val().length == 0 ||$("#username").val().length == 0 || $("#username").val() == null || $("#username").val() == "" ||$("#password").val().length == 0|| $("#password").val()==null|| $("#password").val() == "" )
                        {
                            errorMsg = "输入不能为空";
                            $("#errWindow").show();
                            $("#errWindow").append(errorMsg);
                        }else{
                            $("#fm").submit();
                        }
                    }
                });
            });
        });
        function changeImg(){
            document.getElementById("validateCodeImg").src="${pageContext.request.contextPath}/drawImage?"+Math.random();
        }
        function errorreturn(){
            if($("#errortext").val() != null && $("#errortext").val() != "")
            {
                alert($("#errortext").val());
            }
        };
    </script>
</head>
<body>
<%--页面头开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/top.jsp"/>
<%--页面头结束--%>
<input type="hidden" value="${requestScope.loginError}" id="errortext">
<%--页面正式开始--%>
    <div class="row">

        <%--错误信息提示栏--%>
            <div class="alert alert-success" role="alert" id="errWindow"></div>
            <div class="col-md-8 col-md-offset-2 col-xs-8 col-xs-offset-2" style="margin-top: 2%">
            <%--注册表单--%>
            <form action="${pageContext.request.contextPath}/user?method=login" method="post" id="fm">
               <%--用户名：--%>
                <div class="form-group">
                    <label for="username">用户名：</label>
                    <input type="text" class="form-control" id="username" name="username" value="${user.username}" placeholder="请输入您的用户名">
                </div>
                <%--密码：--%>
                 <div class="form-group">
                       <label for="password">密码：</label>
                       <input type="password" class="form-control" id="password" value="${user.password}" name="password" placeholder="请输入您的密码">
                 </div>
                   <div class="form-group">
                       <label for="yzm" >验证码：</label>
                       <div >
                           <input type="text" class="form-control" id="yzm" placeholder="请输入验证码">
                           <img alt="验证码看不清，换一张" src="${pageContext.request.contextPath}/drawImage" id="validateCodeImg" onclick="changeImg()">
                           <a href="javascript:void(0)" onclick="changeImg()">看不清，换一张</a>
                       </div>
                   </div>
                   <a class="btn btn-default"  id="sunmitClick" onclick="doSubmit()" style="margin-left: 46%;margin-top: 20px;display: inline-block" >登录</a>
                   <a class="btn btn-default" href="${pageContext.request.contextPath}/jsp/regist.jsp" style="margin-top: 20px;"   role="button">注册</a>

            </form>
        </div>

    </div>

<%--页面正式开始--%>

<%--页面尾开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/foot.jsp"/>
<%--页面尾结束--%>
</body>
</html>
