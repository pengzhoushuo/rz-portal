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
					Banner页设置
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<form id="my-form-search" class="form-inline my-form-search" action="###" method="post">
					<div style="padding:20px 0;">
						<div class="form-group">						
							<label>公司名称：</label>
							<select id="memberId" name="memberId" class="form-control required" class="form-control">
							</select>							
						</div>
						<input type="button" onclick="search();" value="&nbsp;&nbsp;查找&nbsp;&nbsp;" class="btn btn-primary btn-success" id="search_btn">
					</div>
			    </form>
		  	</div>
		</div> 
		
		<div class="app-table-box">
			<div class="table-responsive app-border-top app-border-bottom">
				<div class="action-btn-bar">
					<a target="_top" class="btn btn-primary btn-success" href="${ctx}/appbanner/initAdd">新增</a>
		  			&nbsp;&nbsp;<input type="button"  class="btn btn-danger" value="删除" onclick="dele();">
		  		</div>
				<table id="grid-data" style="max-width: 120%; width: 120%;" class="table table-condensed table-hover table-striped" data-form-id="my-form-search" data-toggle="bootgrid"  data-ajax="true" data-url="${ctx}/appbanner/page" >
				    <thead>
				        <tr>
				            <th data-column-id="check" data-formatter="check">选择</th>
				            <th data-column-id="status" data-formatter="status">状态</th>
				            <th data-column-id="startTime">开始时间</th>
				            <th data-column-id="endTime">结束时间</th>
				            <th data-column-id="imgUrl">图片</th>
				            <th data-column-id="linkUrl">链接地址</th>
				            <th data-column-id="adDesc">描述</th>
				            <th data-column-id="creator">创建人</th>
				            <th data-column-id="createTime">创建时间</th>
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
		    	"action": function(column, row)
		        {
	    			if(row.status=="0") 
		        	{	
		    			return '<a target="_top" href="initEdit/'+row.id+'" class="btn btn-primary">修改</a>&nbsp;&nbsp;'+
					 	'<a href="###" class="btn btn-primary" onclick="changestatus(\'' + row.id + '\',1);">启用</href>';
		        	}else{
		        		return '<a target="_top" href="initEdit/'+row.id+'" class="btn btn-primary">修改</a>&nbsp;&nbsp;'+
					 	'<a href="###" class="btn btn-primary" onclick="changestatus(\'' + row.id + '\',0);">禁用</href>';
		        	}
		        },
		        "status":function(column,row){
		        	if(row.status=="0"){
		        		return '未启用';
		        	}else{
		        		return '已启用';
		        	}
		        },
		        "check":function(column,row){
	        		return '<input type="checkbox" name="check_name" value="'+row.id+'"/>';
		        }
		    }
		});
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
	}

	 function search()
	 {
		 $("#grid-data").bootgrid("reload");
	 }
 
	 function getCheckAdIds()
	 {  
	     var adIds = "";  
	     $("input:checkbox[name=check_name]:checked").each(function(i){  
	         if(0==i){  
	             adIds = $(this).val();  
	         }else{  
	             adIds += (","+$(this).val());  
	         }  
	     });  
	     return adIds;  
	 } 

	function del()
	{
		var ids = getCheckAdIds();
		$.ajax({
			type:"post",
			url: "${ctx}/appbanner/delete",
			data:  {"ids":ids},
			success:function(result){
				$("#grid-data").bootgrid("reload");
				$("#msgLbl").html(result.message); 
				$("#myModal").modal('show'); 
			}
		});
	}
	
	function dele(){
		var ids = getCheckAdIds();
		if(ids == ""){
			$("#msgLbl").html("请选择记录"); 
			$("#myModal").modal('show'); 
			return;
		}
		$("#msgLblto").html('是否确定删除');
		$("#myConfirm").modal('show');
	}
	
	function changestatus(id,status)
	{
		$.ajax({
			type:"post",
			url: "${ctx}/appbanner/changeStatus",
			data:  {"status":status,"id":id},
			success:function(result){
				$("#grid-data").bootgrid("reload");
				$("#msgLbl").html(result.message); 
				$("#myModal").modal('show'); 
			}
		});
	}
</script>
</body>
</html>
