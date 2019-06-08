<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员平台</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/manager.js"></script>
    <script type="text/javascript">
        /*-----------------------------------------新闻管理----------------------------------------------------------------*/
        $(function () {
            $.fn.serializeObject = function()
            {
                var o = {};
                var a = this.serializeArray();
                $.each(a, function() {
                    if (o[this.name] !== undefined) {
                        if (!o[this.name].push) {
                            o[this.name] = [o[this.name]];
                        }
                        o[this.name].push(this.value || '');
                    } else {
                        o[this.name] = this.value || '';
                    }
                });
                return o;
            };
        });
        function getMyDate(str){
            var oDate = new Date(str),
                oYear = oDate.getFullYear(),
                oMonth = oDate.getMonth()+1,
                oDay = oDate.getDate(),
                oHour = oDate.getHours(),
                oMin = oDate.getMinutes(),
                oSen = oDate.getSeconds(),
                oTime = oYear +'-'+ getzf(oMonth) +'-'+ getzf(oDay) +' '+ getzf(oHour) +':'+ getzf(oMin) +':'+getzf(oSen);//最后拼接时间
            return oTime;
        };
        //补0操作
        function getzf(num){
            if(parseInt(num) < 10){
                num = '0'+num;
            }
            return num;
        }
        /*加载新闻列表*/
        function newsload() {
            $("#newstb").empty();
            $.post(
                "${pageContext.request.contextPath}/manager1?method=loadNewsList",
                function (data) {
                    var obj = eval(data);
                    for (var i = 0;i<obj.length;i++){
                        var newstype = "";
                        if(obj[i].newstype == "1")
                        {
                            newstype = "国内";
                        }else if(obj[i].newstype == "2"){
                            newstype = "国外";
                        }else if(obj[i].newstype == "3"){
                            newstype = "军事";
                        }else if(obj[i].newstype == "4"){
                            newstype = "科技";
                        }
                        $("#newstb").append("<tr></tr>").append("<td>"+obj[i].id+"</td>" +
                            "<td>"+newstype+"</td>"+
                            "<td>"+obj[i].title+"</td>"+
                            "<td>"+obj[i].author+"</td>"+
                            "<td>"+getMyDate(obj[i].pubtime)+"</td>"+
                            "<td><button type=\"button\" class=\"btn btn-default \"  onclick='newsupdateopen("+obj[i].id+")'>修改</button><button type=\"button\" class=\"btn btn-danger\" onclick='newsdelete("+obj[i].id+")'>删除</td>"
                        );
                    }
                }
            );
        }
        /*新闻修改操作*/
        function newsupdateopen(data) {
            $.post(
                "${pageContext.request.contextPath}/manager1?method=findnewsByid",
                {newsupdateid:data},
                function (result){
                    result = $.parseJSON(result);

                    $("#news-update-newstitle").val(result.title);
                    $("#news-update-newsauthor").val(result.author);
                    $("#news-update-newstype").val(result.newstype);
                    $("#news-update-newscontent").val(result.content);
                    $("#news-update-newsid").val(result.id);
                    $('#newsupdatediv').modal('show');
                }
            );

        };
        /*新闻修改操作*/
        function newsupdate() {
            var jsonObj = $("#newsupdateform").serializeObject();
            $.post(
                "${pageContext.request.contextPath}/manager1?method=updateNews",
                jsonObj,
                function (result) {
                    $('#newsupdatediv').modal('hide');
                    alert(result);
                    newsload();
                }
            );
        }
        /*新闻添加操作*/
        function addnewsopen() {
            $('#addnewsDIV').modal('show');
        };
        /*添加新闻*/
        function addnews() {
            var jsonObj = $("#newsinsertform").serializeObject();
            $.post(
                "${pageContext.request.contextPath}/manager1?method=addNews",
                jsonObj,
                function (result) {
                    $('#addnewsDIV').modal('hide');
                    alert(result);
                    newsload();
                }
            );
        }
        /*删除新闻*/
        function newsdelete(data) {

            if(confirm("确认删除？")){
                $.get(
                    "${pageContext.request.contextPath}/manager1?method=deleteNews",
                    {newsdeleteid:data},
                    function (result) {
                        alert(result);
                        newsload();
                    }
                );
            }


        }
        $(function () {
            $("#userdiv").hide();
            $("#commentdiv").hide();



            newsload();
            $("#newsbutton").click(function () {
                $("#newsdiv").show(); $("#commentdiv").hide(); $("#userdiv").hide();
                $("#newstb").empty();
                newsload();
            });
            $("#userbutton").click(function () {
                $("#userdiv").show();$("#newsdiv").hide();$("#commentdiv").hide();
                userload();
            });
            $("#commentbutton").click(function () {
                $("#newsdiv").hide();$("#userdiv").hide();  $("#commentdiv").show();
                commentload();
            });
        });

        /*------------------------------------------用户管理-----------------------------------------------------------------*/
        /*用户信息加载*/
        function userload() {
            $("#usertb").empty();
            $.post(
                "${pageContext.request.contextPath}/manager1?method=loadUserList",
                function (data) {
                    var obj = eval(data);
                    for (var i = 0;i<obj.length;i++){
                        var gender = "";
                        if(obj[i].gender == "1")
                        {
                            gender = "男";
                        }else if(obj[i].gender == "0"){
                            gender = "女";
                        }
                        $("#usertb").append("<tr></tr>").append("<td>"+obj[i].id+"</td>" +
                            "<td>"+obj[i].username+"</td>"+
                            "<td>"+gender+"</td>"+
                            "<td>"+obj[i].resume+"</td>"+
                            "<td><button type=\"button\" class=\"btn btn-danger \"  onclick='deleteuser("+obj[i].id+")'>删除</button></td>"
                        );
                    }
                }
            );
        }
        /*删除用户*/
        function deleteuser(data) {
            if(confirm("确认删除？")){
                $.get(
                    "${pageContext.request.contextPath}/manager1?method=deleteUser",
                    {userdeleteid:data},
                    function (result) {
                        alert(result);
                        userload();
                    }
                );
            }
        }
        /*------------------------------------------评论管理-----------------------------------------------------------------*/
        /*评论信息加载*/
        function commentload() {
            $("#commenttb").empty();
            $.post(
                "${pageContext.request.contextPath}/manager1?method=loadCommentList",
                function (data) {
                    var obj = eval(data);
                    for (var i = 0;i<obj.length;i++){
                        $("#commenttb").append("<tr></tr>").append(
                            "<td>"+obj[i].id+"</td>" +
                            "<td>"+obj[i].comment+"</td>"+
                            "<td>"+obj[i].commentid+"</td>"+
                            "<td>"+getMyDate(obj[i].commenttime)+"</td>"+
                            "<td>"+obj[i].newsid+"</td>"+
                            "<td><button type=\"button\" class=\"btn btn-danger\" onclick='commentdelete("+obj[i].id+")'>删除</button></td>"
                        );
                    }
                }
            );
        }
        /*删除评论*/
        function commentdelete(data) {
            if(confirm("确认删除？")){
                $.get(
                    "${pageContext.request.contextPath}/manager1?method=deleteComment",
                    {commentdeleteid:data},
                    function (result) {
                        alert(result);
                        commentload();
                    }
                );
            }
        }
    </script>
</head>
<body>
<%--页面头开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/top.jsp"/>
<%--页面头结束--%>

<%--修改新闻--%>
<div class="modal fade" id="newsupdatediv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel" onclick='addnewsopen()'>新闻修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="newsupdateform">
                    <input type="hidden"  id ="news-update-newsid"name="id">

                    <div class="form-group">
                        <label for="news-update-newstitle" class="col-sm-2 control-label">新闻标题</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="news-update-newstitle" name="title">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="news-update-newsauthor" class="col-sm-2 control-label">新闻作者</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="news-update-newsauthor" name="author">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="news-update-newstype" class="col-sm-2 control-label">新闻类型</label>
                        <div class="col-sm-10">
                            <select id="news-update-newstype" class="form-control" name="newstype">
                                <option value="1" >国内</option>
                                <option value="2">国外</option>
                                <option value="3">军事</option>
                                <option value="4">科技</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="news-update-newscontent" class="col-sm-2 control-label">新闻内容</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="10" id="news-update-newscontent" name="content"></textarea>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="newsupdate()">提交</button>
            </div>
        </div>
    </div>
</div>
<%--添加新闻--%>
<div class="modal fade" id="addnewsDIV" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"  >新闻添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="newsinsertform">
                    <div class="form-group">
                        <label for="news-insert-newstitle" class="col-sm-2 control-label">新闻标题</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="news-insert-newstitle" name="title">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="news-insert-newsauthor" class="col-sm-2 control-label">新闻作者</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="news-insert-newsauthor" name="author">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="news-insert-newstype" class="col-sm-2 control-label">新闻类型</label>
                        <div class="col-sm-10">
                            <select id="news-insert-newstype" class="form-control" name="newstype">
                                <option value="1" >国内</option>
                                <option value="2">国外</option>
                                <option value="3">军事</option>
                                <option value="4">科技</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="news-insert-newscontent" class="col-sm-2 control-label">新闻内容</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="10" id="news-insert-newscontent" name="content"></textarea>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="addnews()">提交</button>
            </div>
        </div>
    </div>
</div>
<%--全页面--%>
<div class="row">
    <%--左侧--%>
    <div class="col-sm-3 col-md-2 sidebar" style="margin-left:50px">
        <a href="#" class="list-group-item" id="newsbutton">新闻管理</a>
        <a href="#" class="list-group-item" id="userbutton">用户管理</a>
        <a href="#" class="list-group-item" id="commentbutton">评论管理</a>
    </div>
    <%--右侧--%>
    <div class="col-sm-9 col-md-9 main" style="margin-left:0px">
        <%--新闻面板--%>
        <div class="panel panel-default" style="margin-left:-30px" id="newsdiv">
            <div class="panel-heading">新闻管理</div>
            <button type="button" class="btn btn-info" onclick='addnewsopen()' >添加新闻</button>
            <table class="table  table-hover table-condensed" style="text-align: center">
                <thead style="font-weight: bold">
                    <tr>
                        <td>新闻ID</td><td>新闻类型</td><td>新闻题目</td><td>新闻作者</td><td>发布时间</td><td>操作</td>
                    </tr>
                </thead>
                <tbody id="newstb">

                </tbody>
            </table>
        </div>

        <%--用户面板--%>
         <div class="panel panel-default" style="margin-left:-30px" id="userdiv">
                    <div class="panel-heading">用户管理</div>
                    <table class="table  table-hover table-condensed" style="text-align: center">
                        <thead style="font-weight: bold">
                        <tr>
                            <td>用户ID</td><td>用户名称</td><td>用户性别</td><td>用户自我介绍</td><td>操作</td>
                        </tr>
                        </thead>
                        <tbody id="usertb">

                        </tbody>
                    </table>

            </div>
            <%--评论面板--%>
            <div class="panel panel-default" style="margin-left:-30px" id="commentdiv">
                <div class="panel-heading">评论管理</div>
                <table class="table  table-hover table-condensed" style="text-align: center">
                    <thead style="font-weight: bold">
                    <tr>
                        <td>评论ID</td><td>评论内容</td><td>评论人ID</td><td>评论时间</td><td>评论新闻ID</td><td>操作</td>
                    </tr>
                    </thead>
                    <tbody id="commenttb">

                    </tbody>
                </table>
            </div>


    </div>


</div>









<%--页面尾开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/foot.jsp"/>
<%--页面尾结束--%>
</body>
</html>
