<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%response.setStatus(200);%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>404</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="${ctx}/static/hplus/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx}/static/hplus/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx}/static/hplus/css/animate.css" rel="stylesheet">
    <link href="${ctx}/static/hplus/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">


    <div class="middle-box text-center animated fadeInDown">
        <h1>404</h1>
        <h3 class="font-bold">页面未找到！</h3>

        <div class="error-desc">
            抱歉，页面好像去火星了~
        </div>
    </div>
    <!-- 全局js -->
    <script src="${ctx}/static/hplus/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx}/static/hplus/js/bootstrap.min.js?v=3.3.6"></script>
</body>

</html>
