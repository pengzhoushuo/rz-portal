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
						<small>用户登陆日志</small>
					</legend>
					<div class="control-group">
						<div>
							<label>用户名：</label>
							<input type="text" id="userName" name="userName" class="form-control" class="form-control" style="width:300px;display:inline"/>
							<input type="button" onclick="search();" value="查找" class="btn btn-primary btn-success" id="search_btn">
						</div>
					</div>
				</fieldset>
		    </form>
	  	</div>
	</div> 
   <br><br>
	<table id="grid-data" class="table table-condensed table-hover table-striped" data-form-id="my-form-search" data-toggle="bootgrid"  data-ajax="true" data-url="${ctx}/loglogin/page" >
    <thead>
        <tr>
        	<th data-column-id="id" >ID</th>
            <th data-column-id="userName" >用户名</th>
            <th data-column-id="ip">IP</th>
            <th data-column-id="result" data-formatter="result">状态</th>
            <th data-column-id="remark">备注</th>
            <th data-column-id="createTime">创建时间</th>
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
	        "result":function(column,row){
	        	if(row.result==1){
	        		return '登陆成功';
	        	}else{
	        		return '登陆失败';
	        	}
	        }
	    }
	});
}

 function search()
 {
	 $("#grid-data").bootgrid("reload");
 }
 
</script>
</body>
</html>
