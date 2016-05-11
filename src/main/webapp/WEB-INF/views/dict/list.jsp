<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<header>
</header>
<body>
    <br>
    <div class="row">
		<div class="col-md-12">
		<form id="my-form-search" class="my-form-search" action="###" method="post">
			<fieldset>
						<legend>
							<small>字典管理</small>
						</legend>
			</fieldset>
				&nbsp;<label>字典组：</label> <input type="text" name="dictGroup" value="" class="form-control" style="width:300px;display:inline" > 
				&nbsp;&nbsp;<label>字典名：</label> <input type="text" name="name" value="" class="form-control" style="width:300px;display:inline" > 
				<input type="button" onclick="findHitReByOrder();" value="模糊查找" class="btn btn-primary btn-success" id="search_btn">
		    </form>
		  </div>
	</div> 
   <br><br>
   <a target="_blank" class="btn btn-primary btn-success" href="${ctx}/dict/initAdd">+新增字典</a>
   &nbsp;&nbsp;<input type="button"  class="btn btn-danger" value="删除" onclick="dele();">
	<table id="grid-data" class="table table-condensed table-hover table-striped" data-form-id="my-form-search" data-toggle="bootgrid"  data-ajax="true" data-url="${ctx}/dict/page" >
    <thead>
        <tr>
            <th data-column-id="check" data-formatter="check">选择</th>
            <th data-column-id="dictGroup" >组名</th>
            <th data-column-id="name">名称</th>
            <th data-column-id="val">字典值</th>
            <th data-column-id="num">顺序号</th>
            <th data-column-id="readonly" data-formatter="read">只读</th>
            <th data-column-id="remark">备注</th>
            <th data-column-id="createTime">创建时间</th>
            <th data-column-id="action" data-formatter="action" ></th>
        </tr>
    </thead>
</table>
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
	    		if(row.readonly=="0"){
	    			 return '<a target="_blank" href="initEdit\\'+row.id+'" class="btn btn-primary">修改</a>';	
	    		}
	    	  
	        },
	        "read":function(column,row){
	        	if(row.readonly=="0"){
	        		return '否';
	        	}else{
	        		return '是';
	        	}
	        },
	        "check":function(column,row){
	        	if(row.readonly=="1")
	        	{
	        		return '<input type="checkbox" disabled="disabled" name="check_name" value="'+row.id+'">';
	        	}else{
	        		return '<input type="checkbox" name="check_name" value="'+row.id+'">';
	        	}	
	        }
	    }
	});
}

 function findHitReByOrder(){
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
			url: "${ctx}/dict/delete",
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
</body>
</html>
