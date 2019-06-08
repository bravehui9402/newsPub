<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<html>
<head>
    <title>用户注册</title>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var errorMsg = "";/*错误信息显示*/
        $(function (){
            errorreturn();
            $("#errordiv").hide();
            $("#waror").empty();
            $("#sunmitClick").click(function (){
                $("#errordiv").hide();
                $("#waror").empty();
                var nameVal = $("#username").val();
                /*用户名异步请求验证是重复*/
                $.post("${pageContext.request.contextPath}/user?method=registOfVa",{username:nameVal},function (result) {
                    if(result != "true"){
                        errorMsg = "用户名格式不正确或已存在，请重新输入";
                        $("#errordiv").show();
                        $("#waror").append(errorMsg);
                    }else{
                        /*通过第一层校验，用户名不存在，进行第二步校验验证码*/
                        errorMsg = "";
                        var yzmVal = $("#yzm").val();
                        /*用户名异步请求验证是重复*/
                        $.post("${pageContext.request.contextPath}/user?method=yzm",{yzm:yzmVal},function (result) {
                            if(result != "true") {
                                errorMsg = "验证码不正确";
                                $("#errordiv").show();
                                $("#waror").append(errorMsg);
                            }else{
                                /*通过第二层校验，验证码和用户名通过，校验输入格式是否正确*/
                                errorMsg = "";
                                var nameVal = $("#username").val();
                                if(nameVal=null||nameVal==""|| !nameVal.match(/^[a-z0-9_-]{5,12}$/)){
                                    errorMsg = "用户名不能为空，长度6-12位以上，不能包含特殊字符";
                                    $("#errordiv").show();
                                    $("#waror").append(errorMsg);
                                    return false;
                                }
                                /*密码格式校验*/
                                var pwVal = $("#password").val();
                                if(pwVal=null||pwVal==""|| !pwVal.match(/^[a-z0-9_-]{6,12}$/)){
                                    errorMsg = "密码不能为空，长度6-12位以上，不能包含特殊字符";
                                    $("#errordiv").show();
                                    $("#waror").append(errorMsg);
                                    return false;
                                };

                                if($("#yzm").val()== "" ||$("#yzm").val() == null||$("#yzm").val().length == 0 ||$("#username").val().length == 0 || $("#username").val() == null || $("#username").val() == "" ||$("#password").val().length == 0|| $("#password").val()==null|| $("#password").val() == "" )
                                {
                                    errorMsg = "输入不能为空";
                                    $("#errWindow").show();
                                    $("#errWindow").append(errorMsg);
                                    return false;
                                }
                                /*描述校验*/
                                var rVal = $("#resume").val();
                                if(rVal=null||rVal==""){
                                    errorMsg = "求你写点啥把！！！";
                                    $("#errordiv").show();
                                    $("#waror").append(errorMsg);
                                }else{/*通过全部校验，允许提交*/
                                    $("#fm").submit();
                                    alert("注册成功，去登录吧！");
                                }
                            }
                        });
                    }
                });
        });
        });
            //刷新验证码
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
    <jsp:include page="${pageContext.request.contextPath}/common/top.jsp"/>
    <input type="hidden" value="${requestScope.registError}" id="errortext">
    <div class="row">
        <div class="alert alert-warning alert-dismissible" role="alert" id="errordiv">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong id="waror"></strong>
        </div>
            <%--注册栏--%>
        <div class="col-md-8 col-md-offset-2 col-xs-8 col-xs-offset-2" style="margin-top: 2%">
            <%--注册表单--%>
                <form action="${pageContext.request.contextPath}/user?method=regist" method="post" id="fm">
                    <div class="form-group">
                        <label for="username">用户名：</label>
                        <input type="text" class="form-control" id="username" name="username" value="${user.username}" placeholder="请输入您的用户名">
                    </div>
                    <div class="form-group">
                        <label for="password">密码：</label>
                        <input type="password" class="form-control" id="password" value="${user.password}" name="password" placeholder="请输入您的密码">
                    </div>
                    <div class="radio ">
                        <label style="font-weight: bold;padding-left: 0px">性别：</label>
                        <label>
                            <input type="radio" name="gender" id="optionsRadios1" value="0" checked>
                            男
                        </label>
                        <label>
                            <input type="radio" name="gender" id="optionsRadios2" value="1">
                            女
                        </label>
                    </div>
                    <label style="font-weight: bold;padding-left: 0px">自我介绍：</label>
                    <textarea class="form-control" rows="3" name="resume" value="${user.resume}" id="resume"></textarea>

                        <div class="form-group">
                            <label for="yzm" >验证码：</label>
                            <div >
                                <input type="text" class="form-control" id="yzm" placeholder="请输入验证码">
                                <img alt="验证码看不清，换一张" src="${pageContext.request.contextPath}/drawImage" id="validateCodeImg" onclick="changeImg()">
                                <a href="javascript:void(0)" onclick="changeImg()">看不清，换一张</a>
                            </div>
                        </div>
                        <a class="btn btn-default"  id="sunmitClick" style="margin-left: 46%;margin-top: 20px" role="button">注册</a>
                </form>

        </div>
    </div>


    <jsp:include page="${pageContext.request.contextPath}/common/foot.jsp"/>
</body>
</html>
