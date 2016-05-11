<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%	
	//设置返回码200，避免浏览器自带的错误页面
	response.setStatus(200);
	//记录日志
	Logger logger = LoggerFactory.getLogger("500.jsp");
	logger.error(exception.getMessage(), exception);
%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>500</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="${ctx}/static/hplus/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx}/static/hplus/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="${ctx}/static/hplus/css/animate.css" rel="stylesheet">
    <link href="${ctx}/static/hplus/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">


    <div class="middle-box text-center animated fadeInDown">
        <h1>500</h1>
        <h3 class="font-bold">服务器内部错误</h3>

        <div class="error-desc">
            服务器好像出错了...
            <br/>您可以返回上一步看看
            <br/><a href="#" onclick="history.back();" class="btn btn-primary m-t">主页</a>
        </div>
    </div>

    <!-- 全局js -->
    <script src="${ctx}/static/hplus/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx}/static/hplus/js/bootstrap.min.js?v=3.3.6"></script>
</body>

</html>

