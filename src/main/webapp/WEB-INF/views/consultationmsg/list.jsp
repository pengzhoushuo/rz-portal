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
				消息管理
			</div>
		</div>
	</div>
    <div class="row">
		<div class="col-md-12">
			
			<form id="my-form-search" class="form-inline my-form-search" action="###" method="post">
				<c:if test="${sessionScope.loginUser.role==1}">
					<div style="padding:20px 0;">
						<div class="form-group">
							<label>公司名称：</label>
							<select id="memberId" name="memberId" class="form-control required" class="form-control">
							</select>
						</div>
						<input type="button" onclick="search();" value="查找" class="btn btn-primary btn-success" id="search_btn"/>
					</div>
				</c:if> 
		    </form>
			
	  	</div>
	</div> 
	<div class="app-table-box">
		<div class="table-responsive app-border-top app-border-bottom">
			<table id="grid-data" style="width:100%;" class="table table-condensed table-hover table-striped" data-form-id="my-form-search" data-toggle="bootgrid"  data-ajax="true" data-url="${ctx}/consultationmsg/page" >
			    <thead>
			        <tr>
			            <th data-column-id="flowTo" data-formatter="flowTo">接收方</th>
			            <th data-column-id="msgContent">消息内容</th>
			            <th data-column-id="msgType" data-formatter="msgType">消息类型</th>
			            <th data-column-id="createTime">创建时间</th>
			            <th data-column-id="hadReply" data-formatter="hadReply">已回复</th>
			            <th data-column-id="action" data-formatter="action">操作</th>
			        </tr>
			    </thead>
			</table>
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
		        "msgType":function(column,row){
		        	if(row.msgType=="TEXT"){
		        		return '文本';
		        	}else if(row.msgType=="MUSIC"){
		        		return '语音';
		        	}else if(rolw.msgType=="IMG"){
		        		return '图片';
		        	}else{
		        		return '其它';
		        	}
		        }, "flowTo":function(column,row){
		        	if(row.flowTo=="U2M"){
		        		return '客户';
		        	}else if(row.flowTo=="M2U"){
		        		return '会员';
		        	}
		        }, "hadReply":function(column,row){
		        	if(row.hadReply==true){
		        		return '是';
		        	}else if(row.hadReply==false){
		        		return '否';
		        	}
		        },"action": function(column, row)
		        {
    				return '<a target="_blank" href="detail/'+row.msgId+'" class="btn btn-primary">查看</a>';
		        }
		    }
		});
		<c:if test="${sessionScope.loginUser.role==1}"> 
			 $.ajax({
			 		url:'${ctx}/orginfo/listTopOrgList',
			 		type:'POST',
			 		data:{},
			 		success:function (msg) {
			 			$("#memberId").empty();
			 			if(msg.length > 1)
			 			{
			 				$("<option value=\"\"></option>").appendTo($("#memberId"));
			 			}
			 			for(var i=0;i<msg.length;i++){
			 				$("<option value=\"" + msg[i].memberId + "\">" + msg[i].orgName+ "</option>").appendTo($("#memberId"));
			 			}
			 		}
			 });
		 </c:if> 
	}

	 function search()
	 {
		 $("#grid-data").bootgrid("reload");
	 }
</script>
</body>
</html>
