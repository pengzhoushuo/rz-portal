<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.pmec.ygy.portal.model.login.LoginUser" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="currentUrl" value="<%=request.getRequestURI() %>"/>
<script>
	var currentUrl="${currentUrl}";
</script>
