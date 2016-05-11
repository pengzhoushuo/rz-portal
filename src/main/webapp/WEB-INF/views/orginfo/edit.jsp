<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>修改</title>
</head>
<body>
<div class="col-md-12">
	<div class="row">
	    <div class="col-md-12">
	    	<div class="loc">
				<a href="${ctx}/main">主页</a>
				<span class="loc_mark">&frasl;</span>
				<a href="${ctx}/orginfo/list">组织架构管理</a>
				<span class="loc_mark">&frasl;</span>
				修改组织架构
			</div>
	    </div>
	</div>
	<div class="row">
	    <div class="col-md-12">
	    	<div class="app-table-box" style="margin-top:20px;">
	    		<form id="editForm" action="${ctx}/orginfo/edit" method="post" class="form-horizontal">
					<input type="hidden" name="id" value="${orgInfo.id}" />
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">名称：</label>
						<div class="col-sm-8">
							<input type="text" id="orgName" name="orgName" value="${orgInfo.orgName}" class="form-control input-large required" maxlength="50" minlength="1"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">备注：</label>
						<div class="col-sm-8">
							<input type="text" id="remark" name="remark" value="${orgInfo.remark}" class="form-control input-large" maxlength="500" minlength="1"/>
						</div>
					</div>		
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-8">
							<input id="submit_btn" class="btn btn-primary" type="submit" value="提交" style="min-width:8em;" />
						</div>
					</div>
				</form>
	    	</div>
	    </div>
	</div>
</div>
	
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
	<script type="text/javascript">
	   $(document).ready(function() {
		  init();	
	   });
	   
	   function init(){
	   		$("#editForm").validate();
		   	var msg = '${msg}';
			if(msg != ''){
				$("#msgLbl").html(msg); 
				$("#myModal").modal('show'); 
			}
	   }
	</script>
</body>

</html>