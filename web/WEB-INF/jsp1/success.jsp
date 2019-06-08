<%--
  Created by IntelliJ IDEA.
  User: 刘晖
  Date: 2019/5/22
  Time: 4:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript">
       $(function () {
           alert("操作成功！");
           $(location).attr("href", "http://localhost:8080/user?method=refect");
       })
    </script>
</head>
<body>

</body>
</html>
