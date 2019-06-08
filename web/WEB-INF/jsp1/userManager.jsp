<%--
  Created by IntelliJ IDEA.
  User: 刘晖
  Date: 2019/5/22
  Time: 3:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人管理</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function dodelete(data) {
        if(confirm("确认删除？"))
        {
            $.get(
                "${pageContext.request.contextPath}/comment?method=deleteCommentById",
                {commentid:data},
                function (data12) {
                    $("#tbo").empty();
                    $.post(
                        "${pageContext.request.contextPath}/comment?method=loadComforMana",
                        {userid:${sessionScope.user.id}},
                        function (data1) {
                            var obj = eval(data1);
                            for(var i = 0;i<obj.length;i++)
                            {
                                $("#tbo").append("<tr><td>"+obj[i].comment+"</td><td>"+obj[i].commenttome+"</td><td>"+obj[i].newsName+"</td><td><button type=\"button\" class=\"btn  btn-danger\" onclick='dodelete("+obj[i].id+")'>删除</button></td></tr>");
                            }
                            alert(data12);
                        }
                    );
                }
            );
        }else{
            return false;
        }
        };
        $(function (){
            $("#userfmdiv").hide();
            $("#pinglundiv").hide();
            if(${message != null}){
                alert(${message});

            };
            $("#userBut").click(function () {
                $("#userfmdiv").show();
                $("#pinglundiv").hide();
            });


            $("#plBut").click(function () {
                $("#tbo").empty();
                $.post(
                    "${pageContext.request.contextPath}/comment?method=loadComforMana",
                    {userid:${sessionScope.user.id}},
                    function (data) {
                        var obj = eval(data);
                        for(var i = 0;i<obj.length;i++)
                        {
                            $("#tbo").append("<tr><td>"+obj[i].comment+"</td><td>"+obj[i].commenttome+"</td><td>"+obj[i].newsName+"</td><td><button type=\"button\" class=\"btn  btn-danger\" onclick='dodelete("+obj[i].commentid+")'>删除</button></td></tr>");
                        }
                    }
                );
                $("#userfmdiv").hide();
                $("#pinglundiv").show();
            });
            function dodelete(data) {
                alert(data);
            }
            $("#sunmitClick").click(function () {
                $(".error").empty();
                var pwVal = $("#password").val();
                var resumeVal = $("#resume").val();
                if(pwVal=null||pwVal==""|| !pwVal.match(/^[a-z0-9_-]{6,12}$/)){
                    $("#errorforpassword").append("密码不能为空，长度6-12位以上，不能包含特殊字符")
                    return false;
                }else if (resumeVal=null||resumeVal==""){
                    $("#errorforresume").append("求你写点啥把！！！")
                    return false;
                }else{
                    $.post(
                        "${pageContext.request.contextPath}/user?method=update",
                        {id:${sessionScope.user.id},password:$("#password").val(),resume:$("#resume").val()},
                        function (data) {
                            if(data > 0)
                            {
                                alert("修改成功");
                            }else {
                                alert("修改失败，请尝试重新操作");
                            }
                        }
                    );
                }
            });
        })
    </script>
</head>
<body>
<%--页面头开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/top.jsp"/>
<%--页面头结束--%>
    <div class="row" style="margin-top: 0px">
        <%--导航栏--%>
        <div class="col-md-2  " style="background-color: #afd9ee">
            <button type="button" class="btn btn-info" style="margin: 10px 60px" id="userBut">个人信息</button>

            <br>
            <button type="button" class="btn btn-info" style="margin: 10px 60px" id="plBut">评论信息</button>
        </div>
            <%--面板栏--%>
        <div class="col-md-10  " style="background-color: #afd9ee" >
            <%--评论处盒子--%>
            <div id="pinglundiv" >
                <table class="table table-condensed table-hover" style="" id="pltable">
                   <thead >
                        <tr>
                            <td>评论内容</td>
                            <td>评论时间</td>
                            <td>评论新闻</td>
                            <td>操作</td>
                        </tr>
                   </thead>
                    <tbody id="tbo"></tbody>
                </table>
            </div>
            <div style="margin-top: 50px;" id="userfmdiv" >
            <%--注册表单--%>
            <form action="${pageContext.request.contextPath}/user?method=update" method="post" id="fm" >
                <input type="hidden" value="${sessionScope.user.id}" name="id">
                <div class="form-group">
                    <label for="username">用户名：</label>

                    <input type="text" readonly class="form-control" id="username" name="username" value="${user.username}" placeholder="请输入您的用户名">
                    <p style="color: red" id="errorforusername" ></p>
                </div>
                <div class="form-group">
                    <label for="password">密码：</label>
                    <input type="password" class="form-control" id="password" value="${user.password}" name="password" placeholder="请输入您的密码">
                    <p style="color: red" id="errorforpassword" class="error"></p>
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
                <textarea class="form-control" rows="3" name="resume"  id="resume">${user.resume}</textarea>
                <p style="color: red" id="errorforresume"  class="error"></p>

                <a class="btn btn-default"  id="sunmitClick" style="margin-left: 46%;margin-top: 20px" role="button">修改</a>
            </form>
            </div>
        </div>
    </div>

<%--页面尾开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/foot.jsp"/>
<%--页面尾结束--%>
</body>
</html>
