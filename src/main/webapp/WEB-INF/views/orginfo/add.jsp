<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.pmec.ygy.portal.model.login.LoginUser" %>
<%@ page import="com.pmec.ygy.portal.util.Constants" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<header>
  <title>新增</title>
</header>
<body>
<div class="col-md-12">
	<div class="row">
	    <div class="col-md-12">
	    	<div class="loc">
				<a href="${ctx}/main">主页</a>
				<span class="loc_mark">&frasl;</span>
				<a href="${ctx}/orginfo/list">组织架构管理</a>
				<span class="loc_mark">&frasl;</span>
				新增组织架构
			</div>
	    </div>
	</div>
	<div class="row">
	    <div class="col-md-12">
	    	<div class="app-table-box" style="margin-top:20px;">
		    	<form id="addForm" action="${ctx}/orginfo/add" method="post" class="form-horizontal">
					<div class="form-group">
						<label for="orgName" class="col-sm-2 control-label">名称：</label>
						<div class="col-sm-8">
							<input type="text" id="orgName" name="orgName" placeholder="请输入名称" class="form-control input-large required" maxlength="50" minlength="1"/>
						</div>
					</div>	
					<div class="form-group">
						<label for="orgNameReturn" class="col-sm-2 control-label">上层节点：</label>
						<div class="col-sm-8">
							<input type="text" id="orgNameReturn" name="orgNameReturn" class="form-control input-large required" maxlength="50" minlength="1" readonly="readonly" onclick="openOrgTree();" style="cursor:pointer;"/>
							<input type="hidden" id="orgCodeReturn" name="parentOrgCode"/>
						</div>
					</div>	
					<%
		          	LoginUser loginUser = (LoginUser)request.getSession().getAttribute("loginUser");
		          	int role = loginUser.getRole();
		          	if(role==Constants.ROLE_CENTER_ADMIN){
		          	%>
						<div class="form-group">
							<label for="memberCode" class="col-sm-2 control-label">会员编码：</label>
							<div class="col-sm-8">
								<input type="text" id="memberCode" name="memberCode" class="form-control input-large required" maxlength="10" minlength="1"/>
							</div>
						</div>	
					<%
		          		}else{
					%>
						<input type="hidden" name="memberCode" value=""/>
					<%
		          		}
					%>
					<div class="form-group">
						<label for="remark" class="col-sm-2 control-label">备注：</label>
						<div class="col-sm-8">
							<input type="text" id="remark" name="remark" class="form-control input-large" maxlength="500" minlength="1"/>
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
	    	initDefaultOrg();
	    	$("#addForm").validate();
	    	var msg = '${msg}';
			if(msg != ''){
				$("#msgLbl").html(msg); 
				$("#myModal").modal('show'); 
			}
	    }
	    
	    function initDefaultOrg()
	    {
	   	 	$.ajax({
		 		url:'${ctx}/orginfo/defaultorg',
		 		type:'POST',
		 		data:{"val":$("#dict").val()},
		 		success:function (result) {
		 			$("#orgNameReturn").val(result.orgName);
		 			$("#orgCodeReturn").val(result.orgCode);
		 		}
		 	})
	    }
	    function openOrgTree()
	    {
	    	window.open('${ctx}/orginfo/listtree',this,"dialogWidth=800px,dialogHeight=300px,scrollbars=yes,resizable=yes");
	    }
	</script>
</body>
</html>