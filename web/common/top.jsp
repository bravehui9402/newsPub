<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function () {
		    $("#zhuxiao").click(function () {
                $.get(
                    "${pageContext.request.contextPath}/user?method=zhuxiao",
					function () {
                        $(location).attr("href", "http://localhost:8080/jsp/index.jsp");
                    }
				);
            });
        });

	</script>
</head>
<body style="padding-top: 50px;">

<div class="row" >
		<nav class="navbar navbar-inverse  navbar-fixed-top">
		  <div class="col-md-12">
		    <!-- 首页按钮 -->
		    <div class="navbar-header">
		      <button value="hh" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		      <a class="navbar-brand" href="/jsp/index.jsp" style="margin-left: 20px; font-weight: bolder;">首页</a>
		    </div>
		
		    <!-- 搜索框-->
		    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">		   
		      <form class="navbar-form navbar-left" action="${pageContext.request.contextPath}/news?method=newsshowbySearch" method="post">
		        <div class="form-group">
		          <input type="text" class="form-control" placeholder="Search" name="search">
		        </div>
		        <button type="submit" class="btn btn-default">搜索</button>
		      </form>
		      <ul class="nav navbar-nav navbar-right">
		        <li>

				<c:if test="${empty sessionScope.user}"><a href="${pageContext.request.contextPath}/jsp/login.jsp" id="login"  >登录</a></c:if>
				<c:if test="${sessionScope.user != null}"><a href="${pageContext.request.contextPath}/user?method=refect"  style="display: inline-block">${sessionScope.user.username}</a><a   style="display: inline-block" href="javascript:void(0)"  id="zhuxiao">注销</a></c:if>
				</li>
		        <!-- <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="#">Action</a></li>
		            <li><a href="#">Another action</a></li>
		            <li><a href="#">Something else here</a></li>
		            <li role="separator" class="divider"></li>
		            <li><a href="#">Separated link</a></li>
		          </ul>
		        </li> -->
		      </ul>
		    </div><!-- /.navbar-collapse -->
		  </div><!-- /.container-fluid -->
		</nav>
</div>



</body>
</html>