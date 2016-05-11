<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ page import="com.pmec.ygy.portal.model.login.LoginUser" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>修改个人信息</title>
</head>

<body>
<div class="col-md-12">
	<div class="row">
	    <div class="col-md-12">
			<div class="loc">
				<a href="${ctx}/main">主页</a>
				<span class="loc_mark">&frasl;</span>
				修改个人信息
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			<div class="app-table-box" style="margin-top:20px;">
				<form id="addExpressForm" action="${ctx}/user/updateInfo" method="post" class="form-horizontal" onsubmit="return check();">	
					<%
					     LoginUser loginUser = (LoginUser)request.getSession().getAttribute("loginUser");
					     String userName = loginUser.getUserName();
					 %>
					<div class="form-group">
						<label for="phone" class="col-sm-2 control-label">用户名：</label>
						<div class="col-sm-8">
							<input type="text" id="phone" name="phone" class="form-control input-large" value=<%=userName%>   maxlength="20"  readonly="readonly"/>
						</div>
					</div>			
					
					<div class="form-group">
						<label for="phone" class="col-sm-2 control-label">手机号码：</label>
						<div class="col-sm-8">
							<input type="text" id="phone" name="phone" class="form-control input-large number" value="${memberUser.phone}"  maxlength="11" minlength="11"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="shortPohone" class="col-sm-2 control-label">短号：</label>
						<div class="col-sm-8">
							<input type="text" id="shortPohone" name="shortPhone" class="form-control input-large number" placeholder="如：5290" value="${memberUser.shortPhone}" maxlength="20" minlength="3"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="inviteCode" class="col-sm-2 control-label">邀请码：</label>
						<div class="col-sm-8">
							<input type="text" id="inviteCode" name="inviteCode" value="${memberUser.inviteCode}" placeholder="9位邀请码，前3位为会员编码" class="form-control input-large number" maxlength="9" minlength="9"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="mail" class="col-sm-2 control-label">邮箱：</label>
						<div class="col-sm-8">
							<input type="text" id="mail" name="mail" value="${memberUser.mail}" class="form-control input-large email" placeholder="如：xxx@xx.com"  maxlength="50"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="title" class="col-sm-2 control-label">职位：</label>
						<div class="col-sm-8">
							<input type="text" id="title" name="title" value="${memberUser.title}"  class="form-control input-large" placeholder="请输入职位" maxlength="50" minlength="1"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="sex" class="col-sm-2 control-label">性别：</label>
						<div class="col-sm-8">
							<select id="sex" name="sex" class="form-control input-large">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-sm-2 control-label">备注：</label>
						<div class="col-sm-8">
							<input type="text" id="remark" name="remark" value="${memberUser.remark}" class="form-control input-large" maxlength="500"/>
						</div>
					</div>
					<div class="form-group">
						<label for="birthday" class="col-sm-2 control-label">生日：</label>
						<div class="col-sm-8">
							<input type="text" id="birthday" name="birthday" size="16" onclick="WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" value="${memberUser.birthday}" class="form-control input-large" maxlength="50" readonly="readonly"  style="cursor:pointer;"/>
						</div>
					</div>			
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input id="submit_btn" class="btn btn-primary" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;"/>	
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
	<script>
		$(document).ready(function() {
			var sex = ${memberUser.sex};
		   	$.ajax({
		 		url:'${ctx}/dict/qryByGroup',
		 		type:'POST',
		 		data:{"group":"sex"},
		 		success:function (msg) {
		 			$("#sex").empty();
		 			for(var i=0;i<msg.obj.length;i++){
		 				$('<option value="' + msg.obj[i].val + '">' + msg.obj[i].name + '</option>').appendTo($("#sex"));
		 			}
		 			$("#sex").val(sex);
		 		}
			 });
			//为inputForm注册validate函数
			$("#addExpressForm").validate();
			var msg = '${msg}';
			if(msg != ''){
				$("#msgLbl").html(msg); 
				$("#myModal").modal('show'); 
			}
		});
		
		function check()
		{
			$("#submit_btn").attr('disabled', true); 
		}
	</script>
</body>
</html>
