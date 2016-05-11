package com.xxx.portal.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;

@Component
@Transactional
public class FreeMarkerUtils {
	
	public static String format(String str){
		str = str.replace("\r\n", "");
		str = str.replace("\n", "");
		str = str.replace("\n", "");
		str = str.replace("\t", " ");
		return str;
	}

	public static String inputStream2String(InputStream is) throws IOException{ 
        ByteArrayOutputStream baos = new ByteArrayOutputStream(); 
        int i=-1; 
        while((i=is.read())!=-1){ 
        	baos.write(i); 
        } 
        return baos.toString(); 
	}

	
	public static String genScript(String ruleType, String ruleNo, String rulePrority, String condictionContent, String subCondictionContent, String actionContent) throws Exception{
		if(StringUtils.isBlank(subCondictionContent)){
			if(actionContent.contains("$detail.")){
				subCondictionContent = " ";
			}
		}
		Map<String, String> data = new HashMap<String, String>();
		data.put("ruleNo", ruleNo);
		data.put("rulePrority", rulePrority);
		data.put("condictionContent", condictionContent);
		data.put("actionContent", actionContent);
		data.put("subCondictionContent", subCondictionContent);
		String templateFileName = "OrderAnalyzeRule.tpl";
		if("2".equalsIgnoreCase(ruleType)){
			templateFileName = "OrderScheduleRule.tpl";
		}
		InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream(templateFileName);
		String tpl = inputStream2String(is);
		return complie(tpl, data);
	}
	
	public static String complie(String tpl, Map<String, String> data) throws Exception{
		 Configuration cfg = new Configuration();  
		 StringTemplateLoader loader=new StringTemplateLoader();
		 loader.putTemplate("", tpl);
	        cfg.setTemplateLoader(loader);  
	        cfg.setLocale(Locale.CHINA);
	        cfg.setDefaultEncoding("UTF-8");  	  
	        Template template = cfg.getTemplate(""); 
	    	Writer out = new StringWriter(); 
	    	template.process(data, out);
			return out.toString();
	}
	
	public static void main(String[] args){
		try {
			String ruleNo = "PORTAL_NOWAREHOUSE";
			String rulePrority = "100";
			String condictionContent = "warehouse == \"\" and source == \"ERP_PX\"";
			String subCondictionContent = "sku=\"\"";
			String actionContent = "$header.setIsOccupy('1');\r\n$header.setIsRDC('1');\r\n$detail.setIsRDC('1');";
			System.out.println(format(genScript("2", ruleNo, rulePrority, condictionContent, subCondictionContent, actionContent)));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
