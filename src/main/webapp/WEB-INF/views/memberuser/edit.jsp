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
				<a href="${ctx}/memberuser/list">员工用户管理</a>
				<span class="loc_mark">&frasl;</span>
				修改
			</div>
	    </div>
	</div>
	<div class="row">
	    <div class="col-md-12">
	    	<div class="app-table-box" style="margin-top:20px;">
	    		<form id="editForm" action="${ctx}/memberuser/edit" method="post" class="form-horizontal">
					<input type="hidden" name="id" value="${memberUser.id}" />
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">用户名：</label>
						<div class="col-sm-8">
							<input type="text" id="userName" name="userName" value="${memberUser.userName}" class="form-control input-large" maxlength="50" readonly="readonly"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">姓名：</label>
						<div class="col-sm-8">
							<input type="text" id="name" name="name" value="${memberUser.name}" class="form-control input-large" maxlength="50"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">组织机构：</label>
						<div class="col-sm-8">
							<input type="text" id="orgNameReturn" name="orgName" value="${orgInfo.orgName}" class="form-control input-large required" maxlength="50" minlength="1" readonly="readonly" onclick="openOrgTree();" style="cursor:pointer;"/>
							<input type="hidden" id="orgCodeReturn" name="orgCode" value="${orgInfo.orgCode}"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">角色：</label>
						<div class="col-sm-8">
							<select id="role" name="role" class="form-control input-large required">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">状态：</label>
						<div class="col-sm-8">
							<select id="status" name="status" class="form-control input-large required">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">手机号码：</label>
						<div class="col-sm-8">
							<input type="text" id="phone" name="phone" class="form-control input-large number" value="${memberUser.phone}"  maxlength="11" placeholder="请输入手机号码" minlength="11"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">短号：</label>
						<div class="col-sm-8">
							<input type="text" id="shortPohone" name="shortPhone" class="form-control input-large number" value="${memberUser.shortPhone}"  placeholder="如：5290" maxlength="50" minlength="3"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">邀请码：</label>
						<div class="col-sm-8">
							<input type="text" id="inviteCode" name="inviteCode" value="${memberUser.inviteCode}"  class="form-control input-large number" placeholder="9位邀请码，前3位为会员编码" maxlength="9" minlength="9"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">邮箱：</label>
						<div class="col-sm-8">
							<input type="text" id="mail" name="mail" value="${memberUser.mail}" class="form-control input-large email" maxlength="50" placeholder="如：xxx@xx.com" minlength="3"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">职位：</label>
						<div class="col-sm-8">
							<input type="text" id="title" name="title" value="${memberUser.title}"  class="form-control input-large" placeholder="请输入职位" maxlength="50" minlength="1"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">性别：</label>
						<div class="col-sm-8">
							<select id="sex" name="sex" class="form-control input-large">
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">备注：</label>
						<div class="col-sm-8">
							<input type="text" id="remark" name="remark" value="${memberUser.remark}" class="form-control input-large" maxlength="500"/>
						</div>
					</div>
					<div class="form-group">
						<label for="task_title" class="col-sm-2 control-label">生日：</label>
						<div class="col-sm-8">
							<input type="text" id="birthday" name="birthday" size="16" onclick="WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})"  value="${memberUser.birthday}" class="form-control input-large" maxlength="50" readonly="readonly" style="cursor:pointer;"/>
						</div>
					</div>
					<div class="form-group">
						<div class="content-primary" align="center">
							<img id="img" src="${ctx}/memberuser/showImg/${memberUser.barcode}" height="150px"></img>
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
	   
	   function init(){
		   var status = ${memberUser.status};
		   var sex = ${memberUser.sex};
		   var role = ${memberUser.role};
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
	    	$.ajax({
		 		url:'${ctx}/dict/qryByGroup',
		 		type:'POST',
		 		data:{"group":"status"},
		 		success:function (msg) {
		 			$("#status").empty();
		 			for(var i=0;i<msg.obj.length;i++){
		 				$('<option value="' + msg.obj[i].val + '">' + msg.obj[i].name + '</option>').appendTo($("#status"));
		 			}
		 		   $("#status").val(status);
		 		}
			 });
	    	$.ajax({
		 		url:'${ctx}/dict/qryByGroup',
		 		type:'POST',
		 		data:{"group":"role"},
		 		success:function (msg) {
		 			$("#role").empty();
		 			for(var i=0;i<msg.obj.length;i++){
		 				$('<option value="' + msg.obj[i].val + '">' + msg.obj[i].name + '</option>').appendTo($("#role"));
		 			}
		 			$("#role").val(role);
		 		}
			 });
	   		$("#editForm").validate();
		   var msg = '${msg}';
			if(msg != ''){
				$("#msgLbl").html(msg); 
				$("#myModal").modal('show'); 
			}
	   }
	   
	   function openOrgTree()
	    {
	    	window.open('${ctx}/orginfo/listtree',this,"dialogWidth=800px,dialogHeight=300px,scrollbars=yes,resizable=yes");
	    }
	</script>
</body>

</html>