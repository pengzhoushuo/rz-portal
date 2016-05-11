package com.xxx.portal.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class ResponseUtils {

	public static void outResponse(HttpServletResponse response, Object o){
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		PrintWriter out = null;
		try{
			out = response.getWriter();
			out.print(o.toString());
		}catch(Exception e){
			
		}finally{
			if(out != null){
				out.flush();
				out.close();
			}
		}
	}
}
