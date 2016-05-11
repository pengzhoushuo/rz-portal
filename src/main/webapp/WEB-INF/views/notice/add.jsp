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
				<a href="${ctx}/notice/list">公告管理</a>
				<span class="loc_mark">&frasl;</span>
				新增公告
			</div>
		</div>
	</div>
	<div class="row">
	    <div class="col-md-12">
	    	<div class="app-table-box" style="margin-top:20px;">
	    		<%--左边的预览框--%>
			    <div class="previewDiv" style="right: 245px; top: 40px;">
			        <h3 id="h3Title">标题</h3>
			
			        <p class="img">
			            <img id="imgPublicMsg" src="${ctx}/static/images/notice_preview_default.png" style="width: 235px;height: 120px"/>
			        </p>
			
			        <p class="text" id="psummary">摘要</p>
			    </div>
				<form id="addForm" action="${ctx}/notice/add" method="post" class="form-horizontal" onsubmit="return checkInput();">
					<input type="hidden" name="memberCode" value=""/>
					<input type="hidden" name="targetType" value="ORG"/>
					
					<%
				 		// 对会员屏蔽选择公司功能
						LoginUser loginUser = (LoginUser)request.getSession().getAttribute("loginUser");
					    int role = loginUser.getRole();
					    if( role < 2 ){
				    %>					
					<div class="form-group">
						<label class="col-sm-2 control-label">公司：</label>
						<div class="col-sm-8">
							<select id="memberId" name="targetId" class="form-control required" style="width:300px;display:inline">
							</select>
						</div>
					</div>
					<% } %>
					
					<br/>
					<div class="form-group">
						<label class="col-sm-2 control-label">标题：</label>
						<div class="col-sm-8">
							<input type="text" id="title" name="title" oninput="$('#h3Title').html($('#title').val())" class="form-control required" style="width:300px;display:inline"/>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<label class="col-sm-2 control-label">作者：</label>
						<div class="col-sm-8">
							<input type="text" id="author" name="author" class="form-control required" style="width:300px;display:inline"/>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<label class="col-sm-2 control-label">发布者：</label>
						<div class="col-sm-8">
							<input type="text" id="publisher" name="publisher" value="${sessionScope.loginUser.userName}" class="form-control required" readonly="readonly" style="width:300px;display:inline"/>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<label class="col-sm-2 control-label">封面图片：</label>
						<div class="col-sm-8">
				   	        <input type="text" id="imageFileId" name="imageFileId" readonly="readonly" class="form-control required" style="width:243px;display:inline" maxlength="50"/> 
				   	        <input type="button" id="selFileBtn" name="file" data-theme="b" value="选择" class="btn btn-primary" />
			   	        </div>
					</div>	
					<br/>
					<div class="form-group">
						<label for="summary" class="col-sm-2 control-label">摘要：</label>
						<div class="col-sm-8">
							<textarea id="summary" name="summary" oninput="$('#psummary').html($('#summary').val())" class="form-control required"></textarea>
						</div>
					</div>	
					<br/>
					<div class="form-group">
						<label for="text" class="col-sm-2 control-label">正文：</label>
						<div class="col-sm-8">
							<textarea id="text" name="text" class="form-control required">
							</textarea>
						</div>
					</div>	
					<br/>
					<div class="form-group">
						<label for="orignalTitle" class="col-sm-2 control-label">底部链接标题：</label>
						<div class="col-sm-8">
							<input type="text" id="orignalTitle" name="orignalTitle" class="form-control input-large"/>
						</div>
					</div>	
					<br/>
					<div class="form-group">
						<label for="orignalUrl" class="col-sm-2 control-label">文章底部链接：</label>
						<div class="col-sm-8">
							<input type="text" id="orignalUrl" name="orignalUrl" class="form-control input-large"/>
						</div>
					</div>	
					<br/>
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
		var editor;
	
	    $(document).ready(function(){
	    	init();
		});
	    
	    function init(){
	    	new AjaxUpload($('#selFileBtn'), {
				action:'${ctx}/notice/upload',
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
						$("#imgPublicMsg").attr('src','${ctx}/notice/showImg/' + jrsp.obj + '?t=' + new Date().getTime());
						$("#imageFileId").val(jrsp.obj);
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
			 
				KindEditor.ready(function(K) {
					editor = K.create('textarea[name="text"]', {
						items : [ 'source', '|', 'undo', 'redo', '|', 'preview', 'template', 'cut', 'copy', 'paste', 'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript', 'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'table', 'hr', 'pagebreak', 'anchor', 'link', 'unlink' ],
						
						allowFileManager : false,
						uploadJson : '${ctx}/file/upload',
						fileManagerJson : '${ctx}/file/fileManager'
					});
				});
	    }
	    
	    function checkInput()
	    {
	    	if(editor.isEmpty())
    		{
		    	$("#msgLbl").html('必须填写正文内容'); 
				$("#myModal").modal('show'); 
		    	return false;
    		}
	    	return true;
	    }
	 </script>
</body>
</html>