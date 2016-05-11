<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
  	<link href="${ctx}/static/styles/loginstyle.css" type="text/css" rel="stylesheet" />
  	
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
  </head>

  <body>
 	<div class="frontHome page">
    <div class="wrap-header" style="padding-top:0px;">
        <div id="header">
            <div class="inner-header">
                <div class="logoNav clearfix">  
                    <a id="logo" href="#"><img src="${ctx}/static/images/logo.png" alt=""></a>
                </div>
            </div>
        </div>
    </div>
    <div class="wrap-container">
        <div id="home_container" class="clearfix" >

            <div id="home_main">
                <div class="inner-main">

                    <div class="login_box">
                        <h2>登录</h2>

                        <form id="id_form_login" action="${ctx}/login" method="post" autocomplete="off">
                            <input type='hidden' name='_spring_security_remember_me' value="true"/>
                            <input type='hidden' name='dqdp_csrf_token' value="${sessionScope.dqdp_csrf_token}"/>

                            <div id="idInputLine" class="loginFormIpt">
                                <b class="ico ico-uid"></b>
                                <input class="loginFormTdIpt" tabindex="1" title="请输入账号"
                                       placeholder="请输入账号" name="username" id="username" type="text"
                                       value=''>
                            </div>

                            <div id="pwdInputLine" class="loginFormIpt">
                                <b class="ico ico-pwd"></b>
                                <input class="loginFormTdIpt" tabindex="2" title="请输入密码" placeholder="请输入密码" name="password" id="password" type='password'>
                            </div>
                            
                            <div id="idInputLine" class="loginFormIpt loginFormVcode">
                                <b class="ico ico-vc"></b>
                                <input class="loginFormTdIpt" onkeyup="validateCode();" onblur="validateCode();" tabindex="3" title="请输入验证码"
                                       placeholder="请输入验证码" name="rndcode" id="rndcode" type="text"
                                       value='' maxlength="4">
                                <span class="inputTip" id="inputTipsSpan" style="display:none">
                                	<img id="inputTipsImgTrue"style="display:none" src="${ctx}/static/images/vc-correct.png">
                                	<img id="inputTipsImgFalse" style="display:none" display src="${ctx}/static/images/vc-error.png">
                                </span>
                                <span class="vc-img" onclick="changeImg()"><img id="imgObj" width="100" height="40" alt="验证码" src="${ctx}/rndcode/showRndCodeImg"></span>
                            </div>
                        </form>
                        <div class="loginFormBtn clearfix" style="width: 130px">
                            <button class="login_btn" type="submit" onclick="doLogin()"></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="wrap-footer">
        <div id="footer">
            <div class="inner-footer">
                <div class="foot">
                    <a href="http://www.pmec.com/" target="_blank">广东省贵金属交易中心 版权所有</a>
                </div>
            </div>
        </div>
    </div>
</div>
  </body>
</html>
<script type="text/javascript">
	$(document).ready(function() {
		init();	
	});
	function init()
	{
		<%
			String error = (String) request.getAttribute("msg");
			if (error != null) {
		%>
				alert('<%=error%>');
		<%
			}
		%>
	}
	function doLogin()
	{
		if($("#username").val()=="")
		{
			$("#username").focus();
			return;
		}
		if($("#password").val()=="")
		{
			$("#password").focus();
			return;
		}
		if($("#rndcode").val()=="")
		{
			$("#rndcode").focus();
			return;
		}
		$("#id_form_login").submit();
	}
	
	function changeImg() {
	    var imgSrc = $("#imgObj");
	    var src = imgSrc.attr("src");
	    imgSrc.attr("src", chgUrl(src));
	  }
	
	  //时间戳   
	  //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
	  function chgUrl(url) 
	  {
	    var timeNow = new Date().getTime();
  		url="${ctx }/rndcode/showRndCodeImg?time="+timeNow;
  	    return url;
	  }
	  
	  function validateCode()
	  {
		  if($("#rndcode").val() != "" && $("#rndcode").val().length == 4)
		  {
			  $.ajax({
			 		url:'${ctx}/rndcode/validateRndCode',
			 		type:'POST',
			 		data:{rndcode:$("#rndcode").val() },
			 		success:function (msg) {
			 			if(msg.code == 1)
			 			{
			 				 $("#inputTipsImgTrue").show(); 
			 				 $("#inputTipsImgFalse").hide(); 
			 				 $("#inputTipsSpan").show(); 
			 			}else if(msg.code == -1)
			 			{
			 				$("#inputTipsImgTrue").hide(); 
			 				$("#inputTipsImgFalse").show(); 
			 				$("#inputTipsSpan").show(); 
			 			}
			 		}
			 });
		  }else{
			  $("#inputTipsSpan").hide();  
		  }
	  }
</script>
