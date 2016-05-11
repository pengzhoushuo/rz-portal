<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.pmec.ygy.portal.model.login.LoginUser" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>批量导入用户</title>
</head>
<body>

<div class="col-md-12">
	<div class="row">
	    <div class="col-md-12">
			<div class="loc">
				<a href="${ctx}/main">主页</a>
				<span class="loc_mark">&frasl;</span>
				<a href="${ctx}/memberuser/list">员工用户管理</a>
				<span class="loc_mark">&frasl;</span>
				批量导入用户
			</div>
		</div>
	</div>
	<div class="row">
	    <div class="col-md-12">
	    	<div class="app-table-box" style="margin-top:20px;">
	    		<form id="addForm" action="${ctx}/memberuser/add" method="post" class="form-horizontal">
					<input type="hidden" name="memberCode" />
					<div class="form-group">
						<label for="memberCode" class="col-sm-2 control-label">公司名称：</label>
						<div class="col-sm-8">
							<select id="memberCode" name="memberCode" class="form-control required" onchange="changeMember();">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="selFileBtn" class="col-sm-2 control-label">用户名单：</label>
						<div class="col-sm-8">
				   	        <input class="btn btn-default" type="button" id="selFileBtn" name="file" data-theme="b" value="上传文件"/>
				   	        <span style="display:none" id="batchImportPercent"></span>
				   	    </div>
					</div>	
					<div class="form-group for-link">
						<p class="col-sm-offset-2 col-sm-8">
							<a href="${ctx}/static/template/memberuser.xls">下载模板文件</a>
							<span class="text-muted" style="margin-left:20px;">注意： 不要修改Excel表的表头信息</span>
						</p>
					</div>	
					<div id="tipsDiv" style="display:none">
						<div class="form-group">
							<label class="col-sm-2 control-label">
					  			<font>未通过检查记录数：</font>
					  		</label>
					  		<div class="col-sm-8">
					  			<label id="lblFailure" style="color:red"></label>，<span class="text-muted" >请修正错误后重新上传</span>
					  		</div>
				  		</div>
				  		<div class="form-group">
				  			<label class="col-sm-2 control-label">
				  				错误详情：
				  			</label>
					  		<div class="col-sm-8">
					  			<textarea id="txtWrong" readonly="readonly" class="form-control" rows="10"></textarea>
				  			</div>
			  			</div>
			  		</div>
				</form>
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

	<script type="text/javascript">
	    $(document).ready(function() {
		    init();	
	      });
	    
	    var timer;
	    function init(){
	    	$("#addForm").validate();
	    	var msg = '${msg}';
			if(msg != ''){
				$("#msgLbl").html(msg); 
				$("#myModal").modal('show'); 
			};
			
			 $.ajax({
			 		url:'${ctx}/orginfo/listTopOrgList',
			 		type:'POST',
			 		data:{},
			 		success:function (msg) {
			 			$("#memberCode").empty();
			 			for(var i=0;i<msg.length;i++){
			 				$("<option value=\"" + msg[i].memberCode + "\">" + msg[i].orgName+ "</option>").appendTo($("#memberCode"));
			 			}
			 		}
			 })
			
			new AjaxUpload($('#selFileBtn'), {
				action:'${ctx}/memberuser/batchImport',
				data:{memberCode: ''},
				onSubmit : function(file, ext){
				   if(ext=='xls' || ext=='XLS')
				   {
					 $("#tipsDiv").hide();
				   	 this.disable();
				   	 hideProgress();
				   	 timer = window.setInterval(showProgress, 100);
				   }else{
					   	$("#msgLbl").html('不支持的文件格式，请上传xls格式的EXCEL文件'); 
						$("#myModal").modal('show'); 
					   	 return false;
				   }
				},
				onComplete: function(file, response){
					this.enable();//上传可用
					hideProgress();
					var jrsp = $.parseJSON(response);
					if(jrsp.code == 1)
					{
						$("#msgLbl").html(jrsp.obj.message); 
						$("#myModal").modal('show'); 
					}else{
						$("#tipsDiv").show();
						$("#lblFailure").html(jrsp.obj.failure);
						$("#txtWrong").val(jrsp.obj.wrongMessage);
					}
				}
			});
	    }
	    
		function changeMember()
		{
			new AjaxUpload($('#selFileBtn'), {
				action:'${ctx}/memberuser/batchImport',
				data:{memberCode:$("#memberCode").val()},
				onSubmit : function(file, ext){
				   if(ext=='xls' || ext=='XLS')
				   {
					 $("#tipsDiv").hide();
				   	 this.disable();
					 hideProgress();
				   	 timer = window.setInterval(showProgress, 100);
				   }else{
					   	$("#msgLbl").html('不支持的文件格式，请上传xls格式的EXCEL文件'); 
						$("#myModal").modal('show'); 
					   	 return false;
				   }
				},
				onComplete: function(file, response){
					this.enable();//上传可用
					hideProgress();
					var jrsp = $.parseJSON(response);
					if(jrsp.code == 1)
					{
						$("#msgLbl").html(jrsp.obj.message); 
						$("#myModal").modal('show'); 
					}else{
						$("#tipsDiv").show();
						$("#lblFailure").html(jrsp.obj.failure);
						$("#txtWrong").val(jrsp.obj.wrongMessage);
					}
				}
			});
		}
		
	 	function showProgress()
 	 	{
 	 	 	$.post('${ctx}/memberuser/showProgress', 
 	 	 	function(data) {
 	 	 		$("#batchImportPercent").show();
 	 	 		$("#batchImportPercent").text(data+"%");
 	 	 	});
 	 	}
	 	
	 	function hideProgress()
	 	{
	 		if(timer != null){
	 			clearInterval(timer);
	 		}
	 		$("#batchImportPercent").hide();
	 	}
	 </script>
</body>
</html>