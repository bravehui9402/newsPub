<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${requestScope.news.title}</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript">
               $(function(){
                   $.get(
                       "${pageContext.request.contextPath}/comment?method=huoqupinglun",
                        {newsid:${requestScope.news.id}},
                        function (data) {

                            var obj = eval(data);
                            for(var i = 0;i<obj.length;i++)
                            {
                                $("#pldiv").append("<div class=\"panel-body\">"+obj[i].commentpersion+"评论说:"+obj[i].comment +"<br>评论时间："+obj[i].commenttime+"</div>");
                            }
                        }
                   );

                  $("#fbpl").click(function () {
                       if(${sessionScope.user.id == null} ){
                            alert("请先登录！");
                           $(location).attr("href", "http://localhost:8080/jsp/login.jsp");
                       }else{
                           $.post(
                               "${pageContext.request.contextPath}/comment?method=fabiaopinglun",
                               {userid:${sessionScope.user.id}+"",newsid:${requestScope.news.id},comment:$("#comment").val()},
                               function (result) {
                                   if(result == "nologin"){
                                       alert("请先登录！！");
                                       $(location).attr("href", "http://localhost:8080/jsp/login.jsp");
                                   }else if(result == "true"){
                                       $("#pldiv").empty();
                                       $("#comment").val(" ");
                                       $.get(
                                           "${pageContext.request.contextPath}/comment?method=huoqupinglun",
                                           {newsid:${requestScope.news.id}},
                                           function (data) {

                                               var obj = eval(data);
                                               for(var i = 0;i<obj.length;i++)
                                               {
                                                   $("#pldiv").append("<div class=\"panel-body\"></div>").append(obj[i].commentpersion+"评论说:"+obj[i].comment +"<br>评论时间："+obj[i].commenttime);
                                               }
                                           }
                                       );

                                   }else{
                                       alert("评论失败，请重新操作");
                                   }
                               });
                       }
                   });
               });
    </script>
</head>
<body>
<%--页面头开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/top.jsp"/>
<%--页面头结束--%>
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <p  class="lead" style="border-bottom: 1px solid darkgrey;margin-bottom: 0px;padding-bottom: 0px">${requestScope.news.title}</p>
            <small style="color:#888888;margin-top: 0px">作者：${requestScope.news.author}   发布时间：${requestScope.news.pubtime}  </small>
            <div style="height: 15px"></div>

            <div>${requestScope.news.content}</div>

            <div style="font-weight: bold;font-size: 40px;border-bottom: 2px solid #888888">
                评论
            </div>
            <%--评论显示--%>
            <div id="pldiv" style="padding-top: 0px;margin-top: 0px">

            </div>
            <%--评论发表--%>
            <div>
                    <textarea class="form-control" rows="3" name="comment" id="comment"></textarea>
                    <a class="btn btn-default"  href="javascript:void(0)"  id="fbpl" >发表评论</a>
                    <a href="javascript:void(0)" id="a">adadadada</a>
            </div>

            <div style="height: 30px"></div>



        </div>
    </div>



<%--页面尾开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/foot.jsp"/>
<%--页面尾结束--%>
</body>
</html>
