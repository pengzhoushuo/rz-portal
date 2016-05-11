<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.pmec.ygy.portal.model.login.LoginUser" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>新增</title>
</head>
<body>
<div class="col-md-12">
	<div class="row">
	    <div class="col-md-12">
			<div class="loc">
				<a href="${ctx}/main">主页</a>
				<span class="loc_mark">&frasl;</span>
				<a href="${ctx}/appbanner/list">Banner页设置</a>
				<span class="loc_mark">&frasl;</span>
				新增Banner
			</div>
		</div>
	</div>
	<div class="row">
	    <div class="col-md-12">
	    	<div class="app-table-box" style="margin-top:20px;">
	    		<form id="addForm" action="${ctx}/appbanner/add" method="post" class="form-horizontal">
					<input type="hidden" name="memberCode" value=""/>
					<div class="form-group">
						<label class="col-sm-2 control-label">公司名称：</label>
						<div class="col-sm-8">
							<select id="memberId" name="memberId" class="form-control required" class="form-control" style="width:300px;display:inline">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">开始时间：</label>
						<div class="col-sm-8">
							<input type="text" id="startTime" name="startTime" size="16"  placeholder="点击选择开始时间" onclick="WdatePicker({minDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="form-control input-large required" maxlength="50" readonly="readonly" style="cursor:pointer;"/>
						</div>
					</div>
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">结束时间：</label>
						<div class="col-sm-8">
							<input type="text" id="endTime" name="endTime"  placeholder="点击选择结束时间" onclick="WdatePicker({minDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss'})" size="16" class="form-control input-large required" maxlength="50" readonly="readonly"  style="cursor:pointer;"/>
						</div>
					</div>
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">链接地址：</label>
						<div class="col-sm-8">
							<input type="text" id="linkUrl" name="linkUrl" placeholder="请输入链接地址" class="form-control input-large"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">描述：</label>
						<div class="col-sm-8">
							<input type="text" id="adDesc" name="adDesc" placeholder="请输入描述" class="form-control input-large required"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">创建人：</label>
						<div class="col-sm-8">
							<input type="text" id="creator" name="creator" value="${sessionScope.loginUser.userName}" class="form-control input-large required"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">图片：</label>
						<div class="col-sm-8">
							<img id="img" src="${ctx}/appbanner/showImg/${imgId}" height="200px"></img>
				   	        <input type="button" id="selFileBtn" name="file" data-theme="b" value="更换图片" class="btn btn-primary"/><br /><br />
				   	        <input type="text" id="imgUrl" name="imgUrl" class="form-control input-large" readonly="readonly" maxlength="50"/>
					    </div>
					</div>	
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-8">
							<input id="submit_btn" class="btn btn-primary" type="submit" value="提交" style="min-width:8em;"/>
						</div>
					</div>
				</form>
	    	</div>
	    </div>
	</div>
</div>
	
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true">
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
	    	init();
		});
	    
	    function init(){
	    	new AjaxUpload($('#selFileBtn'), {
				action:'${ctx}/appbanner/upload',
				data:{},
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
						$("#img").attr('src','${ctx}/appbanner/showImg/' + jrsp.obj + '?t=' + new Date().getTime());
						$("#imgUrl").val(jrsp.obj);
						$("#msgLbl").html('图片上传成功'); 
						$("#myModal").modal('show'); 
					}else{
						$("#msgLbl").html(jrsp.message); 
						$("#myModal").modal('show'); 
					}						
				}
			});
	    	
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
			 				$("<option value=\"" + msg[i].memberId + "\">" + msg[i].orgName+ "</option>").appendTo($("#memberId"));
			 			}
			 		}
			 });
	    }
	 </script>
</body>
</html>