<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
   <link href="${ctx}/static/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
  	<link href="${ctx}/static/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
  	
    <!-- Custom styles for this template -->
    <link href="${ctx}/static/styles/default.css" rel="stylesheet"/>
  	<script src="${ctx}/static/jquery/jquery-1.11.2.min.js"></script> 
  	<script src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js"></script>
  	<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js"></script>
  	
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
<head>
  <title>聊天</title>
</head>
<body>
		<div class="modal fade" id="talkDiglog" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<h3> <span style="font-size:14px;">(欢迎你 <span class="text-info">${userName}</span>)</span></h3>
		</div>
		<div class="modal-body">
			<ul class="nav nav-tabs" id="areaTab">
				<li class="active"><a href="#wordMsg" data-toggle="tab">世界</a></li>
			</ul>
			<div class="tab-content">
				<div class="msgPanel tab-pane active" id="wordMsg"></div>
			</div>
		</div>
		<div class="modal-footer text-left">
			<div class="input-append input-prepend">
				<span class="add-on">@世界</span>
				<input style="width:400px" type="text" name="message"/>
				<button id="sendBtn" class="btn btn-primary">发送</button>
			</div>
		</div>
	</div>
</body>
</html>
<style type="text/css">
	.msgPanel{
		height:300px;
		overflow-y:scroll;
	}
</style>
<script>
   $(document).ready(function() {
		$("#talkDiglog").modal('show');
   });
</script>
