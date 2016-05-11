package com.xxx.portal.web.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import com.xxx.portal.domain.LoginUser;
import com.xxx.portal.util.ContrallerPathUtils;

public class LoginCheckFilter extends HttpServlet implements Filter{

	private static final long serialVersionUID = -8238645979164695532L;

	private static Map<String, String> freeResources = new HashMap<String, String>();
	
	static{
		freeResources.put("static", "");
		freeResources.put("login", "");
		freeResources.put("adminlogin", "");
		freeResources.put("health_check", "");
		freeResources.put("rndcode", "");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) throws IOException, ServletException {
	     HttpServletRequest httpRequest = (HttpServletRequest) request;
         String ctx = httpRequest.getContextPath();
         String url = httpRequest.getRequestURI();
         String ctxPath = "";
         boolean needCheck = true;
         if(url != null){
        	 ctxPath = ContrallerPathUtils.getContrallerPath(url, ctx);
        	 if(freeResources.containsKey(ctxPath)){
        		 needCheck = false; 
        	 }
         }
         LoginUser loginUser = (LoginUser)httpRequest.getSession().getAttribute("loginUser");
         if(loginUser==null && needCheck==true){
			String errorStr = "<script>top.location.href='" + ctx + "/login" + "';</script>";
			PrintWriter pw = response.getWriter();
			pw.write(errorStr);
			return;
         }
         filterChain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}
}
