<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>二维码LOGO</title>
</head>
<body>
	 <form method="POST" enctype="multipart/form-data"
		class="form-horizontal">
		<fieldset>
			<legend>
				<small>二维码LOGO</small>
			</legend>
			<div class="control-group">
				<div class="content-primary" align="center">
					<img id="img" src="${ctx}/user/showBarCodeLogoImg" height="128px"></img>
		   	        <input type="button" id="selFileBtn" name="file" data-theme="b" value="更换图片"/>
			    </div>
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
	$(document).ready(function(){
		init();
	});
	
	 function init(){
	    	new AjaxUpload($('#selFileBtn'), {
				action:'${ctx}/user/uploadBarcodeLogo',
				data:{},
				onSubmit : function(file, ext){
				   if(ext=='png' || ext=='PNG' || ext=='jpg' || ext=='JPG' || ext =='jpeg' || ext=='JPEG')
				   {
				   	 this.disable();
				   }else{
					   	$("#msgLbl").html('不支持的文件格式，请上传PNG、JPG或JPEG格式的图片'); 
						$("#myModal").modal('show'); 
					   	 return false;
				   }
				},
				onComplete: function(file, response){
					this.enable();//上传可用
					var jrsp = $.parseJSON(response);
					if(jrsp.code==1)
					{
						$("#img").attr('src','${ctx}/user/showBarCodeLogoImg?t=' + new Date().getTime());
						$("#msgLbl").html('图片上传成功'); 
						$("#myModal").modal('show'); 
					}else{
						$("#msgLbl").html(jrsp.message); 
						$("#myModal").modal('show'); 
					}						
				}
			});
	    }
</script>
</body>

</html>