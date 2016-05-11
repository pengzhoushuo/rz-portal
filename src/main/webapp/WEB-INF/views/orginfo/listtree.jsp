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
  <title>选择组织架构</title>
</head>
<body>
	<div>
		<ul id="treeDemo" class="ztree"></ul>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	消息
            </h4>
         </div>
         <div class="modal-body" id="msgLbl">
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
         </div>
      </div>
  </div>
</div>
	
<SCRIPT type="text/javascript">
		<!--
		var setting = {
			data: {
				key: {
					title:"t"
				},
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onClick: onClick,
				onDblClick : onDblClick
			}
		};

		var zNodes = ${zNodes};
		

		var log, className = "dark";
		function beforeClick(treeId, treeNode, clickFlag) {
			className = (className === "dark" ? "":"dark");
			return (treeNode.click != false);
		}
		function onClick(event, treeId, treeNode, clickFlag) {
			var orgCode = treeNode.code;
			var orgName = treeNode.name;
			if(orgCode != null && orgCode != '' && orgName!=null && orgName!='')
			{
				window.opener.document.getElementById("orgCodeReturn").value = orgCode;
				window.opener.document.getElementById("orgNameReturn").value = orgName;
				window.close();
			}
		}	
		function onDblClick(event, treeId, treeNode, clickFlag) {
		
		}		

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		});
		//-->
	</SCRIPT>
</body>
</html>