<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>启动页设置</title>
</head>
<body>
	<div class="col-md-12">
		<div class="row">
		    <div class="col-md-12">
				<div class="loc">
					<a href="${ctx}/main">主页</a>
					<span class="loc_mark">&frasl;</span>
					启动页设置
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<form method="POST" enctype="multipart/form-data" class="form-inline">		
					<div class="control-group" style="padding:20px 0;text-align:center;">
						<label for="task_title" class="control-label">公司名称：</label>					
						<select id="memberId" name="memberId" class="form-control required" onchange="changeMember();">
						</select>					
					</div>
					<div class="control-group">
						<div class="content-primary" style="text-align:center">
							<img id="img" src="${ctx}/applogo/showImg/${sessionScope.loginUser.memberId}" width="330" />
							<br /><br />
				   	        <input type="button" id="selFileBtn" name="file" data-theme="b" value="更换图片" class="btn btn-primary"/>
					    </div>
					</div>					
				</form>
			</div>
			<div class="col-md-4"></div>
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
	$(document).ready(function(){
		new AjaxUpload($('#selFileBtn'), {
			action:'${ctx}/applogo/upload',
			data:{memberId: '${sessionScope.loginUser.memberId}'},
			onSubmit : function(file, ext){
			   if(ext=='png' || ext=='PNG' || ext=='jpg' || ext=='JPG' || ext =='jpeg' || ext=='JPEG')
			   {
			   	 this.disable();
			   }else{
				   	$("#msgLbl").html('不支持的文件格式，请上传PNG、JPG或JPEG格式的图片'); 
					$("#myModal").modal('show'); 
				   	 return false;
			   }
			},
			onComplete: function(file, response){
				this.enable();//上传可用
				var jrsp = $.parseJSON(response);
				if(jrsp.code==1)
				{
					$("#img").attr('src','${ctx}/applogo/showImg/${sessionScope.loginUser.memberId}' + '?t=' + new Date().getTime());
					$("#msgLbl").html('操作成功'); 
					$("#myModal").modal('show'); 
				}else{
					$("#msgLbl").html(jrsp.message); 
					$("#myModal").modal('show'); 
				}						
			}
		});
		
		 $.ajax({
		 		url:'${ctx}/orginfo/listTopOrgList',
		 		type:'POST',
		 		data:{},
		 		success:function (msg) {
		 			$("#memberId").empty();
		 			for(var i=0;i<msg.length;i++){
		 				$("<option value=\"" + msg[i].memberId + "\">" + msg[i].orgName+ "</option>").appendTo($("#memberId"));
		 			}
		 		}
		 })
	});
	
	function changeMember()
	{
		var memberId = $("#memberId").val();
		$("#img").attr('src','${ctx}/applogo/showImg/' + memberId + '?t=' + new Date().getTime());
		
		new AjaxUpload($('#selFileBtn'), {
			action:'${ctx}/applogo/upload',
			data:{memberId:$("#memberId").val()},
			onSubmit : function(file, ext){
			   if(ext=='png' || ext=='PNG' || ext=='jpg' || ext=='JPG' || ext =='jpeg' || ext=='JPEG')
			   {
			   	 this.disable();
			   }else{
				   	$("#msgLbl").html('不支持的文件格式，请上传PNG、JPG或JPEG格式的图片'); 
					$("#myModal").modal('show'); 
				   	 return false;
			   }
			},
			onComplete: function(file, response){
				this.enable();//上传可用
				var jrsp = $.parseJSON(response);
				if(jrsp.code==1)
				{
					$("#img").attr('src','${ctx}/applogo/showImg/'+ $("#memberId").val() + '?t=' + new Date().getTime());
					$("#msgLbl").html('操作成功'); 
					$("#myModal").modal('show'); 
				}else{
					$("#msgLbl").html(jrsp.message); 
					$("#myModal").modal('show'); 
				}						
			}
		});
	}
</script>
</body>

</html>