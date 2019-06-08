<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>2019~加油鸭~</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

    <script type="text/javascript">
      $(function(){
          $.get(
              "${pageContext.request.contextPath}/comment?method=loadCommentforindex",function (data) {
                  var obj = eval(data);
                  for(var i = 0;i<obj.length;i++)
                  {
                    $("#pldiv").append("<a href='${pageContext.request.contextPath}/news?method=lookNewsById&id="+obj[i].newsid+"' class=\"list-group-item\">"+obj[i].commentpersion+"刚刚评论说："+obj[i].comment+"</a>");
                  }
              }
          );


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



          $.get("${pageContext.request.contextPath}/news?method=loadNewsListforindex",function (result) {
              var obj = eval(result);
              for(var i = 0 ;i < obj.length;i++)
              {
                  var newstype ;
                  if(obj[i].newstype == 1)
                  {
                      newstype="[国内]";
                  }else if(obj[i].newstype == 2){
                      newstype="[国际]";
                  }else if(obj[i].newstype == 3){
                      newstype="[军事]";
                  }else if(obj[i].newstype == 4){
                      newstype="[科技]";
                  }
                  $("#newsdiv").append("<a href='${pageContext.request.contextPath}/news?method=lookNewsById&id="+obj[i].id +"' class='list-group-item' style='font-weight: 500;color: #444444'>"+newstype+obj[i].title+"<span style='color: #888888;float: right'>发布时间："+getMyDate(obj[i].pubtime)+"</span>"+"</a>");
              }
          });
      });



    </script>


  </head>
  <body >
  <%--页面头开始--%>
  <jsp:include page="${pageContext.request.contextPath}/common/top.jsp"/>
  <%--页面头结束--%>

  <!-- -------------------------------------------------------------------------------------- -->
  <div class="container">
    <!--轮播图  -->
    <div class="row container-fruit" >
      <div class="container" >
        <%--轮播图模块--%>
        <div id="carousel-example-generic" class="carousel slide paddingtop" data-ride="carousel">

          <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" role="listbox"  style="height: 300px">
            <div class="item active">
              <img src="${pageContext.request.contextPath}/img/top-lun.jpg" class="img-responsive">

            </div>
            <div class="item">
              <img src="${pageContext.request.contextPath}/img/top-lun2.jpg" class="img-responsive">

            </div>
            <div class="item">
              <img src="${pageContext.request.contextPath}/img/top-lun3.jpg" class="img-responsive">

            </div>
          </div>

          <!-- Controls -->
          <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>
      </div>

    </div>
    <!-- -------------------------------------------------------------------------------------- -->
    <!--导航条  -->
    <div class="row container-fruit" style="margin-top:10px">
      <ul class="nav nav-tabs">
        <li role="presentation" style="margin-right: 200px"><a href="${pageContext.request.contextPath}/news?method=newsListShow&newstype=1">国内新闻</a></li>
        <li role="presentation" style="margin-right: 200px"><a href="${pageContext.request.contextPath}/news?method=newsListShow&newstype=2">国际新闻</a></li>
        <li role="presentation" style="margin-right: 200px"><a href="${pageContext.request.contextPath}/news?method=newsListShow&newstype=3">军事新闻</a></li>
        <li role="presentation" style="margin-right: 200px"><a href="${pageContext.request.contextPath}/news?method=newsListShow&newstype=4">科技新闻</a></li>
      </ul>

    </div>


    <!-- -------------------------------------------------------------------------------------- -->

    <!-- 信息部分 -->
    <div class="row container-fruit" style="margin-top:10px">
      <div class="col-sm-8" style="margin-right:0px">
        <span class="label label-default">热点新闻</span>
        <div class="list-group" id="newsdiv">

        </div>
      </div>
      <!-- 评论和广告部分 -->
      <div class="col-sm-4" >

        <div class="row container-fruit" >
          <span class="label label-default">最新评论</span>
          <div class="list-group" id="pldiv">


          </div>
        </div>
        <div class="row container-fruit" >
          <span class="label label-default">友情链接</span>
          <div class="list-group">
            <a href="#" class="list-group-item">百度</a>
            <a href="#" class="list-group-item">网易</a>
            <a href="#" class="list-group-item">华北科技学院</a>
            <a href="#" class="list-group-item">华北科技学院教务管理系统</a>
          </div>
        </div>
      </div>
    </div>






  <%--页面尾开始--%>
  <jsp:include page="${pageContext.request.contextPath}/common/foot.jsp"/>
  <%--页面尾结束--%>
  </body>
</html>
