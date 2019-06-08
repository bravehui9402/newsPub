<%--
  Created by IntelliJ IDEA.
  User: 刘晖
  Date: 2019/5/22
  Time: 2:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
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
            var obj = eval(${newstypeList});
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
        })
    </script>
</head>
<body>
<%--页面头开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/top.jsp"/>
<%--页面头结束--%>

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <div class="list-group" id="newsdiv">

        </div>

    </div>

</div>

<%--页面尾开始--%>
<jsp:include page="${pageContext.request.contextPath}/common/foot.jsp"/>
<%--页面尾结束--%>
</body>
</html>
