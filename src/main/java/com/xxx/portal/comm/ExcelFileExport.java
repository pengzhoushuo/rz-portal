package com.xxx.portal.comm;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;

public class ExcelFileExport<T> {

	public static class ExportField{
		//如userName
		private String fieldName;
		//如：姓名
		private String chFieldName;
		//如: DATE
		private String type;
		//格式
		private String format;
		//格式器
		private Object formatter;
		
		public String getFieldName() {
			return fieldName;
		}
		public void setFieldName(String fieldName) {
			this.fieldName = fieldName;
		}
		public String getChFieldName() {
			return chFieldName;
		}
		public void setChFieldName(String chFieldName) {
			this.chFieldName = chFieldName;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getFormat() {
			return format;
		}
		public void setFormat(String format) {
			this.format = format;
		}
		public Object getFormatter() {
			return formatter;
		}
		public void setFormatter(Object formatter) {
			this.formatter = formatter;
		}
	}
	
	private static final String EXCEL_HEAD = "<head>\r\n"
		+ "   <meta http-equiv=Content-Type content=\"text/html; charset=GBK\">\r\n"
		+ "   <meta name=ProgId content=Excel.Sheet>\r\n"
		+ "   <meta name=Generator content=\"Microsoft Excel 11\">\r\n"
		+ "</head>\r\n" + "<style>\r\n" + "td {\r\n"
		+ "   border:#a8a8a8 soild 1px;\r\n" + "   color:#000;\r\n"
		+ "   font-size:12px;\r\n" + "   text-align:center;\r\n"
		+ "   background:#FFFFFF;\r\n"
		+ "   mso-number-format:\"\\@\";\r\n" + "}\r\n" + "</style>\r\n";
	
	//表头，每个占一单无格
	private List<String> headList = new ArrayList<String>();
	
	private String exportFieldStr;
	
	public static final String swapLine = "\r\n";
	
	private List<ExportField> fieldList = new ArrayList<ExportField>();
	
	public ExcelFileExport(String exportFiledStr){
		this.exportFieldStr = exportFiledStr;
		if(StringUtils.isNotBlank(exportFieldStr)){
			String[] everyExportField = exportFieldStr.split("\\|");
			for(String str : everyExportField){//statusdate;状态修改时间;DATE;yyyy-MM-dd
				String[] estr = str.split(";");
					if(estr!=null && estr.length >0){
					ExportField exportField = new ExportField();
					if(estr.length >= 2){
						exportField.setFieldName(estr[0]);
						exportField.setChFieldName(estr[1]);
					}
					if(estr.length == 4){
						exportField.setType(estr[2]);
						exportField.setFormat(estr[3]);
						if("DATE".equalsIgnoreCase(exportField.getType())){
							exportField.setFormatter(new SimpleDateFormat(exportField.getFormat()));
						}
					}
					fieldList.add(exportField);
				}
			}
		}
	}
	
	public ExcelFileExport(){
	}
	
	public void addHead(String str){
		headList.add(str);
	}
	
	public List<String> getHeadList() {
		return headList;
	}

	public void setHeadList(List<String> headList) {
		this.headList = headList;
	}
	
	public void writeHead(OutputStream os, StringBuilder headSb) throws Exception{
		os.write(cvtToGBK(EXCEL_HEAD));
		os.write(cvtToGBK(getHead()));
		os.write(cvtToGBK("<table border=1 bordercolor=#A8A8A8>"));
		os.write(cvtToGBK("<tr>"));
		os.write(cvtToGBK(headSb.toString()));
		os.write(cvtToGBK("</tr>"));
	}
	
	public void writeBody(OutputStream os, StringBuilder bodySb) throws Exception{
		os.write(cvtToGBK("<tr>"));
		os.write(cvtToGBK(bodySb.toString()));
		os.write(cvtToGBK("</tr>"));
	}
	
	public void writeEnd(OutputStream os) throws Exception{
		os.write(cvtToGBK("</table>"));
	}
	
	public void export(OutputStream os, List<T> contentList) throws Exception{
		try{
			os.write(cvtToGBK(EXCEL_HEAD));
			os.write(cvtToGBK(getHead()));
			os.write(cvtToGBK("<table border=1 bordercolor=#A8A8A8>"));
			//表头
			StringBuilder headLineSb = new StringBuilder();
			headLineSb.append("<tr>");
			for(ExportField exportField : fieldList){
				headLineSb.append("<td>");
				headLineSb.append(exportField.getChFieldName());
				headLineSb.append("</td>");
			}
			headLineSb.append("</tr>");
			headLineSb.append(swapLine);
			os.write(cvtToGBK(headLineSb.toString()));
			
			for(T t : contentList){
				StringBuilder lineSb = new StringBuilder();
				lineSb.append("<tr>");
				for(ExportField exportField : fieldList){
					lineSb.append("<td>");
					Object obj = BeanUtils.getProperty(t, exportField.getFieldName());
					if("DATA".equalsIgnoreCase(exportField.getType())){
						DateFormat df = (DateFormat)exportField.getFormatter();
						lineSb.append(df.format(obj));
					}else{
						lineSb.append(obj);
					}
					lineSb.append("</td>");
				}
				lineSb.append("</tr>");
				lineSb.append(swapLine);
				os.write(cvtToGBK(lineSb.toString()));
			}
			os.write(cvtToGBK("</table>"));
		}catch(Exception e){
			throw e;
		}finally{
			os.flush();
			//os.close();
		}
	}
	
	private String getHead() throws Exception{
		StringBuilder sb = new StringBuilder();
		sb.append("<tr>");
		for(String head : headList){
			sb.append("<td>");
			sb.append(head);
			sb.append("</td>");
		}
		sb.append("</tr>");
		sb.append(swapLine);
		return sb.toString();
	}

	public byte[] cvtToGBK(String str) {
	    if(str==null){
	        return "".getBytes();
	    }else{
	        try {
	            return str.getBytes("GBK");
	        } catch (UnsupportedEncodingException e) {
	            return str.getBytes();
	        }
	    }
	}
	
	public static void main(String[] args){
		//String str = "schoolNumber;学号|studentName;姓名|score;成绩|classIndex;班级排名";
		//str.split("|");
	}
}
