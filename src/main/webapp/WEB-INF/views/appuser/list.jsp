<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<header>
</header>
<body>
	<div class="col-md-12">
		<div class="row">
		    <div class="col-md-12">
				<div class="loc">
					<a href="${ctx}/main">主页</a>
					<span class="loc_mark">&frasl;</span>
					客户管理
				</div>
			</div>
		</div>
	    <div class="row">
			<div class="col-md-12">
				<form id="my-form-search" class="form-inline my-form-search" action="###" method="post">
					<div class="control-group">
						<div style="padding:20px 0;">
							<c:if test="${sessionScope.loginUser.role==1}"> 
								<label>公司名称：</label>
								<select id="memberCode" name="memberCode" class="form-control required" class="form-control">
								</select>
								&nbsp;&nbsp;
							</c:if> 
							 <c:if test="${sessionScope.loginUser.isAdmin()==true}"> 
								<label>客户经理：</label>
								<input type="text" name="nameReturn" id="nameReturn" onclick="openListMember();" class="form-control" readonly="readonly" />
								<input type="hidden" name="managerId" id="userCodeReturn"/>
								<input type="button" onclick="clearManagerId();" value="清空" class="btn btn-primary" id="search_btn" style="margin:0 1em;"/>
								<input type="button" onclick="search();" value="查找" class="btn btn-primary btn-success" id="search_btn"/>
							</c:if> 
						</div>
					</div>
				
			    </form>
		  	</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="app-table-box">
					<table id="grid-data" style="width:100%;" class="table table-condensed table-hover table-striped" data-form-id="my-form-search" data-toggle="bootgrid"  data-ajax="true" data-url="${ctx}/appuser/page" >
					    <thead>
					        <tr>
					            <th data-column-id="userName">用户名</th>
					            <th data-column-id="nickName">昵称</th>
					            <th data-column-id="memberCode">会员编码</th>
					            <th data-column-id="memberCode">会员公司名称</th>
					            <th data-column-id="managerName">客户经理</th>
					            <th data-column-id="status" data-formatter="status">状态</th>
					            <th data-column-id="createTime">创建时间</th>
					            <th data-column-id="action" data-formatter="action">操作</th>
					        </tr>
					    </thead>
					</table>
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

<div class="modal fade" id="myConfirm" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	确认框
            </h4>
         </div>
         <div class="modal-body" id="msgLblto">
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal" onclick="del();">确认
            </button>
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">取消
            </button>
         </div>
      </div>
  </div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		init();	
	});

	function init()
	{
		$("#grid-data").bootgrid({
			ajax: true,
			selection: true,
		    multiSelect: true,
		    post:function(){
		    	var formId=$("#grid-data").attr("data-form-id");
		    	return $("#"+formId).serializeJSON();
		    },
		    formatters: {
		    	"action": function(column, row)
		        {
		    		<c:if test="${sessionScope.loginUser.isAdmin()==true}"> 
	    				return '<a target="_blank" href="initChangeManagerId/'+row.userId+'" class="btn btn-primary">分配</a>';
	    			</c:if> 
	    			<c:if test="${sessionScope.loginUser.isAdmin()==false}">
	    				return '';
	    			</c:if> 
		        },
		        "status":function(column,row){
		        	if(row.status=="USE"){
		        		return '启用';
		        	}else{
		        		return '未启用';
		        	}
		        }
		    }
		});
		<c:if test="${sessionScope.loginUser.role==1}"> 
			 $.ajax({
			 		url:'${ctx}/orginfo/listTopOrgList',
			 		type:'POST',
			 		data:{},
			 		success:function (msg) {
			 			$("#memberCode").empty();
			 			if(msg.length > 1)
			 			{
			 				$("<option value=\"\"></option>").appendTo($("#memberCode"));
			 			}
			 			for(var i=0;i<msg.length;i++){
			 				$("<option value=\"" + msg[i].memberCode + "\">" + msg[i].orgName+ "</option>").appendTo($("#memberCode"));
			 			}
			 		}
			 });
		 </c:if> 
	}

	 function search()
	 {
		 $("#grid-data").bootgrid("reload");
	 }
	 <c:if test="${sessionScope.loginUser.isAdmin()==true}"> 
		function openListMember()
	    {
		    window.open('${ctx}/memberuser/listMember',this,"dialogWidth=800px,dialogHeight=300px,scrollbars=yes,resizable=yes");
	    }
	</c:if> 
	
	
	function clearManagerId()
	{
		$("#nameReturn").val("");
		$("#userCodeReturn").val("");
	}
</script>
</body>
</html>
