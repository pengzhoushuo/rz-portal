<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>粤贵易管理平台</title>

    <!-- Bootstrap core CSS -->
    <link href="${ctx}/static/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
  	<link href="${ctx}/static/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
  	
    <!-- Custom styles for this template -->
    <link href="${ctx}/static/styles/default.css?v=1" rel="stylesheet"/>
  	<script src="${ctx}/static/jquery/jquery-1.11.2.min.js"></script> 
  	<script src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js"></script>
  	<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js"></script>
  	<script src="${ctx}/static/jquery/ajax_upload3.6.js"></script>
  	
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- plugin -->
     <!-- grid -->
    <link href="${ctx}/static/plugin/bootgrid/jquery.bootgrid.min.css" type="text/css" rel="stylesheet" />
    <script src="${ctx}/static/plugin/bootgrid/jquery.bootgrid.js"></script>
    <!-- ajax form -->
    <script src="${ctx}/static/plugin/ajaxform/jquery.form.min.js"></script>
     <!-- serializeJSON -->
    <script src="${ctx}/static/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/plugin/serializeJSON/addIndexOfMethod.min.js"></script>
    <script src="${ctx}/static/plugin/serializeJSON/jquery.serializejson.min.js"></script>
   
	<script type="text/javascript" src="${ctx}/static/plugin/ztree/jquery.ztree.core-3.5.min.js"></script>
	<link rel="stylesheet" href="${ctx}/static/plugin/ztree/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="${ctx}/static/plugin/kindeditor/kindeditor-min.js"></script>
	<script type="text/javascript" src="${ctx}/static/plugin/kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript" src="${ctx}/static/plugin/DatePicker/WdatePicker.js"></script>
  </head>

  <body class="bg-color">

	<%@ include  file="/WEB-INF/layouts/header.jsp"%>
    <div class="container-fluid starter-template">	
		<div class="row"><sitemesh:body/></div>
    </div><!-- /.container -->
	<%@ include file="/WEB-INF/layouts/footer.jsp"%>
 
  </body>
</html>
