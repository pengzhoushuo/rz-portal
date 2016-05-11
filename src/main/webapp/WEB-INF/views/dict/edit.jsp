<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>修改字典</title>
</head>
<body>
	<form id="addExpressForm" action="${ctx}/dict/edit" method="post"
		class="form-horizontal">
		<input type="hidden" name="id" value="${dict.id}" />
		<fieldset>
			<legend>
				<small>修改字典</small>
			</legend>
			<div class="control-group">
				<label for="task_title" class="control-label">字典组：</label>
				<div class="controls">
					<input type="text" id="dictGroup" name="dictGroup" value="${dict.dictGroup}"
						class="form-control input-large required" required="字典组不能为空" maxlength="50"/>
				</div>
			</div>
			<div class="control-group">
				<label for="task_title" class="control-label">字典名：</label>
				<div class="controls">
					<input type="text" id="name" name="name" value="${dict.name}"
						class="form-control input-large required" maxlength="50"/>
				</div>
			</div>
			<div class="control-group">
				<label for="task_title" class="control-label">字典值：</label>
				<div class="controls">
					<input type="text" id="val" name="val" value='${dict.val}'
						class="form-control input-large required" maxlength="100"/>
				</div>
			</div>
			<div class="control-group">
				<label for="task_title" class="control-label">顺序号：</label>
				<div class="controls">
					<input type="text" id="num" name="num" value="${dict.num}"
						class="form-control input-large required number" maxlength="4"/>
				</div>
			</div>
			<div class="control-group">
				<label for="task_title" class="control-label">是否只读：</label>
				<div class="controls">
					<select id="readonly"  name="readonly" value="dict.readonly" class="form-control input-large required number">
					  <option value="0">否</option>
					  <option value="1">是 </option>
					</select>
				</div>
			</div>
			<div class="control-group">
				<label for="description" class="control-label">备注：</label>
				<div class="controls">
					<textarea id="remark" rows="1" name="remark"
					class="form-control input-large" maxlength="200">${dict.remark}</textarea>
				</div>
			</div>
			<br />
			<div class="form-actions">
				<input id="submit_btn" class="btn btn-primary" type="submit"
					value="提交" />&nbsp;
			</div>
		</fieldset>
	</form>
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
	   		$("#addExpressForm").validate();
		   var readonly = ${dict.readonly};
		   var msg = '${msg}';
			if(msg != ''){
				$("#msgLbl").html(msg); 
				$("#myModal").modal('show'); 
			}
		   if(readonly == "1"){
			   $("#readonly").empty();
			   $("<option value='1'>否</option>").appendTo($("#readonly"));
			   $("#dictGroup").attr({ readonly: 'true' });
			   $("#name").attr({ readonly: 'true' });
			   $("#val").attr({ readonly: 'true' });
			   $("#num").attr({ readonly: 'true' });
			   $("#readonly").attr({ readonly: 'true' });
			   $("#remark").attr({ readonly: 'true' });
		   }
	   }
	</script>
</body>

</html>