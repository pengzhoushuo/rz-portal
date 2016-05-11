<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<header>
</header>
<body>
    <div class="col-md-3 left-side" id="leftDiv">
    	<div class="aside-sub-nav">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
    </div>
  	<div class="col-md-9 right-side" id="rightDiv">
  		<div class="row">
  			<div class="col-md-12">
  				<div class="loc">
					<a href="${ctx}/main">主页</a>
					<span class="loc_mark">&frasl;</span>
					组织架构管理
				</div>
  			</div>
  		</div>
	    <div class="row">
			<div class="col-md-12">
				<div style="padding:20px 0;">
					<form id="my-form-search" class="form-inline my-form-search" action="###" method="post">
						<div class="form-group">
							<label>名称：</label>
							<input type="text" name="orgName" class="form-control" placeholder="请输入名称"> 
						</div>
							<input type="hidden" id="parentOrgCode" name="parentOrgCode" value="${rootOrgInfo.orgCode}"/>
							<input type="button" onclick="search();" value="&nbsp;&nbsp;查找&nbsp;&nbsp;" class="btn btn-primary btn-success" id="search_btn">					
				    </form>
			    </div>
			</div>
		</div> 
   
	<div class="app-table-box">
		<div class="table-responsive app-border-top app-border-bottom">
			<div class="action-btn-bar">
				<a target="_top" class="btn btn-primary btn-success" href="${ctx}/orginfo/initAdd">新增</a>
				&nbsp;&nbsp;<input type="button" class="btn btn-danger" value="删除" onclick="dele();">
			</div>		
			<table style="max-width: 100%; width: 100%;" id="grid-data" class="table table-condensed table-hover table-striped" data-form-id="my-form-search" data-toggle="bootgrid"  data-ajax="true" data-url="${ctx}/orginfo/page" >
			    <thead>
			        <tr>
			            <th data-column-id="check" data-formatter="check">选择</th>
			            <th data-column-id="orgName" >名称</th>
			            <th data-column-id="memberCode" >会员编码</th>
			            <th data-column-id="remark">备注</th>
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

function init(){
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
    			 return '<a target="_top" href="initEdit/'+row.id+'" class="btn btn-primary">修改</a>';	
	    	  
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
			url: "${ctx}/orginfo/delete",
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
	
</script>

<SCRIPT type="text/javascript">
		<!--
		var setting = {
			data: {
				key: {
					title:"t"
				},
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onClick: onClick
			}
		};

		var zNodes = ${zNodes};
		

		var log, className = "dark";
		function beforeClick(treeId, treeNode, clickFlag) {
			className = (className === "dark" ? "":"dark");
			return (treeNode.click != false);
		}
		function onClick(event, treeId, treeNode, clickFlag) {
			$("#parentOrgCode").val(treeNode.code);
			search();
		}		

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		});
		//-->
	</SCRIPT>
</body>
</html>
