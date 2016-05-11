<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>修改密码</title>
</head>

<body>
<div class="col-md-12">
	<div class="row">
	    <div class="col-md-12">
			<div class="loc">
				<a href="${ctx}/main">主页</a>
				<span class="loc_mark">&frasl;</span>
				修改密码
			</div>
		</div>
	</div>
	<div class="row">
	    <div class="col-md-12">
	    	<div class="app-table-box" style="margin-top:20px;">
	    		<form id="addExpressForm" action="${ctx}/user/changePassword" method="post" class="form-horizontal" onsubmit="return check();";>

					<div class="form-group">
						<label for="oldpwd" class="col-sm-2 control-label" >旧密码：</label>
						<div class="col-sm-8">
							<input type="password" id="oldpwd" name="oldpwd" class="form-control input-large required" placeholder="请输入旧密码" maxlength="50" minlength="1"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="password" class="col-sm-2 control-label">新密码：</label>
						<div class="col-sm-8">
							<input type="password" id="password" name="password" class="form-control input-large required" placeholder="请输入新密码" maxlength="50" minlength="6"/>
						</div>
					</div>
						<div class="form-group">
						<label for="password2" class="col-sm-2 control-label">再次输入新密码：</label>
						<div class="col-sm-8">
							<input type="password" id="password2" name="password2" class="form-control input-large required" placeholder="请再次输入新密码" maxlength="50" minlength="6"/>
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
			//聚焦第一个输入框
			$("#ruleNo").focus();
			//为inputForm注册validate函数
			$("#addExpressForm").validate();
			var msg = '${msg}';
			if(msg != ''){
				$("#msgLbl").html(msg); 
				$("#myModal").modal('show'); 
			}
		});
		
		function check(){
			if($("#password").val() != $("#password2").val()){
				$("#msgLbl").html("两次输入的密码不一致"); 
				$("#myModal").modal('show'); 
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
