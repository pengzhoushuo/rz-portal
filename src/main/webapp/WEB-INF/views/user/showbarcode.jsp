<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>我的二维码</title>
</head>

<body>
<div class="col-md-12">
	<div class="row">
	    <div class="col-md-12">
			<div class="loc">
				<a href="${ctx}/main">主页</a>
				<span class="loc_mark">&frasl;</span>
				我的二维码
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<form id="addExpressForm" method="post" class="form-horizontal" style="margin-top:20px;">
				<input type="hidden" name="id" value="${expression.id}"/>
				<div class="control-group">
					<div class="content-primary" align="center">
						<img id="img" src="${ctx}/memberuser/showImg/${memberUser.barcode}" height="300px"></img>
				    </div>
				</div>	
				<div class="form-actions" style="text-align:center;padding:20px;">
					<input type="button" id="selFileBtn" data-theme="b" class="btn btn-primary"  onclick="go2('${ctx}/user/showBarCodeLogo');" value="自定义二维码LOGO"/>
				</div>
			</form>
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
		function go2(url)
		{
			 window.location.href = url;
		}
	</script>
</body>
</html>
