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
  <title>选择员工</title>
</head>
<body>

<div class="row" style="margin:0;">
	<div class="col-md-12">
		<form id="my-form-search" class="form-inline my-form-search" action="###" method="post">
			<div class="form-group">
				<label>用户名：</label>
				<input type="text" name="userName" value="" class="form-control" >
			</div>
			<div class="form-group">
				<label>姓名：</label>
				<input type="text" name="name" value="" class="form-control" > 						
			</div>
			<input type="button" onclick="search();" value="查找" class="btn btn-primary btn-success" id="search_btn">
		</form>
	</div>
</div>
<div class="row" style="margin:0;">
	<div class="col-md-12">
		<div class="app-table-box">
			<div class="table-responsive app-border-top app-border-bottom">
				<table style="max-width: 100%; width: 100%;" id="grid-data" class="table table-condensed table-hover table-striped" data-form-id="my-form-search" data-toggle="bootgrid"  data-ajax="true" data-url="${ctx}/memberuser/listMemberPage" >
				    <thead>
				    	<tr>
				            <th data-column-id="userName" >用户名</th>
				            <th data-column-id="name">姓名</th>
				            <th data-column-id="phone">手机号码</th>
				            <th data-column-id="sex" data-formatter="sex">性别</th>
				            <th data-column-id="role" data-formatter="role">角色</th>
				            <th data-column-id="remark">备注</th>
				            <th data-column-id="action" data-formatter="action">操作</th>
				        </tr>
				    </thead>
				</table>
			</div>
		</div>
	</div>
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
<div class="modal fade" id="myConfirm" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	确认框
            </h4>
         </div>
         <div class="modal-body" id="msgLblto">
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal" onclick="del();">确认
            </button>
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">取消
            </button>
         </div>
      </div>
  </div>
</div>

    
<script type="text/javascript">
   
$(document).ready(function() {
	init();	
});

function init(){
	$("#grid-data").bootgrid({
		ajax: true,
		selection: true,
	    multiSelect: true,
	    post:function(){
	    	var formId=$("#grid-data").attr("data-form-id");
	    	return $("#"+formId).serializeJSON();
	    },
	    formatters: {
	    	"action": function(column, row)
	        {
    			 return '<a href="#" onclick=selectIt("'+row.userCode + '","' + row.name + '") class="btn btn-primary">选择</a>';	
	        },
	        "status":function(column,row){
	        	if(row.status=="0"){
	        		return '未启用';
	        	}else{
	        		return '已启用';
	        	}
	        },
	        "sex":function(column,row){
	        	if(row.sex=="1"){
	        		return '男';
	        	}if(row.sex=="2"){
	        		return '女';
	        	}else if(row.sex=="0"){
	        		return '不详';
	        	}
	        },
	        "role":function(column,row){
	        	if(row.role=="2"){
	        		return '超级管理员';
	        	}else if(row.role=="3"){
	        		return '管理员';
	        	}else if(row.role=="4"){
	        		return '客户经理';
	        	}else if(row.role=="5"){
	        		return '客服';
	        	}
	        },
	        "check":function(column,row){
        		return '<input type="checkbox" name="check_name" value="'+row.id+'"/>';
	        }
	    }
	});
}

 function search()
 {
	 $("#grid-data").bootgrid("reload");
 }
 
 function selectIt(userCode, name)
 {
	 window.opener.document.getElementById("userCodeReturn").value = userCode;
	 window.opener.document.getElementById("nameReturn").value = name;
	 window.close();
 }
</script>
</body>
</html>
