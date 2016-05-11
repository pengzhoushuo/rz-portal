<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.pmec.ygy.portal.model.login.LoginUser" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>咨询回复</title>
</head>
<body>
<div class="col-md-12">
	<div class="row">
	    <div class="col-md-12">
			<div class="loc">
				<a href="${ctx}/main">主页</a>
				<span class="loc_mark">&frasl;</span>
				<a href="${ctx}/consultationmsg/list">消息管理</a>
				<span class="loc_mark">&frasl;</span>
				查看消息
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="app-table-box" style="margin-top:15px;">
				<form id="addForm" action="${ctx}/consultationmsg/addreply" method="post" class="form-horizontal" onsubmit="return checkInput();">
					<input type="hidden" name="msgId" value="${consultationMsg.msgId}"/>
					<input type="hidden" name="msgType" value="TEXT"/>		
					<div class="form-group">
						<div>
							<label class="col-sm-2 control-label">对象：</label>
							<div class="col-sm-8">${appUser.nickName}</div>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div>
							<label class="col-sm-2 control-label">消息：</label>
							<div class="col-sm-8">${consultationMsg.msgContent}</div>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div>
							<label class="col-sm-2 control-label">创建时间：</label>
							<div class="col-sm-8">${consultationMsg.createTime}</div>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<div>
							<label class="col-sm-2 control-label">已回复列表：</label><br/>
								<c:forEach items="${consultationMsg.replyList}" var="reply">
									<div class="col-sm-8">${reply.msgContent}</div>
									<br/>
								</c:forEach>
						</div>
					</div>
					<c:if test="${consultationMsg.replyList.size()==0}">
						<div class="form-group">
							<label for="task_title" class="col-sm-2 control-label">回复内容：</label>
							<div class="col-sm-8">
								<textarea id="reply" name="reply" class="form-control required"></textarea>
							</div>
						</div>	
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-8">
								<input id="submit_btn" class="btn btn-primary" type="submit" value="添加回复"/>&nbsp;	
							</div>
						</div>
					</c:if>
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
	    
	    function checkInput()
	    {
	    	if($("#reply").val()=='')
	    	{
	    		$("#msgLbl").html('回复内容不能为空'); 
				$("#myModal").modal('show'); 
	    		return false;
	    	}
	    	return true;
	    }
	 </script>
</body>
</html>