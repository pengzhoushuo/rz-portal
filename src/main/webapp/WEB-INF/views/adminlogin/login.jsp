<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>粤贵易管理平台</title>

     <!-- Bootstrap core CSS -->
    <link href="${ctx}/static/bootstrap/3.3.2/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
  	<link href="${ctx}/static/jquery-validation/1.11.1/validate.css" type="text/css" rel="stylesheet" />
  	
    <!-- Custom styles for this template -->
    <link href="${ctx}/static/styles/default.css" rel="stylesheet"/>
  	<script src="${ctx}/static/jquery/jquery-1.11.2.min.js"></script> 
  	<script src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js"></script>
  	<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js"></script>
    <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- plugin -->
     <!-- grid -->
    <link href="${ctx}/static/plugin/bootgrid/jquery.bootgrid.min.css" type="text/css" rel="stylesheet" />
    <script src="${ctx}/static/plugin/bootgrid/jquery.bootgrid.js"></script>
    <!-- ajax form -->
    <script src="${ctx}/static/plugin/ajaxform/jquery.form.min.js"></script>
        <!-- serializeJSON -->
    <script src="${ctx}/static/plugin/serializeJSON/jquery.serializejson.min.js"></script>
     <script src="${ctx}/static/bootstrap/3.3.2/js/bootstrap.min.js" type="text/javascript"></script>
  </head>

  <body>

    <div class="container starter-template">
    
	<div class="modal fade" id="myLogin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class='form-signin-heading'>用户登录
						<span class="modal-title" id="myModalLabel" style="float:right;font-style:italic; color:#999999; font-weight:normal;">粤贵易管理平台</span>	
					</h4>					
				</div>
				<div class="modal-body" id="fromDiv" style="padding-top:20px;">
					<form id="loginForm" action="${ctx}/adminlogin" method="post" 
						class='form-horizontal form-signin' role='form'>
						<div id="errormsg" style="color:#FF0000;font-size: 16px; font-weight:normal;text-align: center;padding-bottom:16px;"></div>						
						<div class="form-group">
							<label for="username" class="col-sm-4 control-label" style="padding-right:0;">用户名：</label>
							<div class="col-sm-6" style="padding-left:0;">
								<input type="text" id="username" name="username"
							value="${username}" class="form-control" placeholder="请输入用户名" required autofocus>
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-4 control-label" style="padding-right:0;">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
							<div class="col-sm-6" style="padding-left:0;">
								<input type="password" id="password" name="password"
									class="form-control"
									placeholder="请输入密码" required>
							</div>
						</div>
						
						<div class="form-group">							
							<label for="password" class="col-sm-4 control-label" style="padding-right:0;">验证码：</label>
							<div class="col-sm-3" style="padding-left:0;">
								<input type='text' id="rndcode" name="rndcode"
								class='form-control'
								style="width: 100%; margin-left: auto; margin-right: auto;display:inline"
								placeholder='请输入验证码' maxLength="4" required>
							</div>
							<div class="col-sm-4" onclick="changeImg()" style="padding-left:0;"><img id="imgObj" src="${ctx}/rndcode/showRndCodeImg"/></div>							
						</div>
						
						<div class="form-group">
						    <div class=" col-sm-12" style="text-align: center;padding:15px 0;">
						      <button class='btn btn-lg btnDangerBackground btn-block'
							style='width: 40%; margin:0 auto;background-color: #F87B00' type='submit'><span style="color: #FFFFFF">登&nbsp;&nbsp;&nbsp;&nbsp;录</span></button>
						    </div>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$('#myLogin').modal({backdrop: 'static', keyboard: false});
			$("#myLogin").modal('show'); 
			$("#loginForm").validate();
		});
		
		function changeImg() {
		    var imgSrc = $("#imgObj");
		    var src = imgSrc.attr("src");
		    imgSrc.attr("src", chgUrl(src));
		  }
		
		  //时间戳   
		  //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
		  function chgUrl(url) {
		    var timeNow = new Date().getTime();
	  		url="${ctx }/rndcode/showRndCodeImg?time="+timeNow;
	  	    return url;
		  }
	</script>

	<%
		String error = (String) request.getAttribute("msg");
		if (error != null) {
	%>
	<script>
		   $("#errormsg").html("<%=error%>");
	</script>

	<%
		}
	%>

    </div><!-- /.container -->
	<%@ include file="/WEB-INF/layouts/footer.jsp"%>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  
 	
  </body>
</html>