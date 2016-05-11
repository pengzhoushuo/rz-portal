package com.xxx.portal.util;

public class ContrallerPathUtils {

	public static String getContrallerPath(String url, String context){
		int index = url.indexOf(context);
		int fromIndex = index + context.length();
		String subString = url.substring(fromIndex);
		if(subString.startsWith("/")){
			subString = subString.replaceFirst("/", "");
		}
		int toIndex = subString.indexOf("/");
		if(toIndex == -1){
			return subString;
		}else{
			return subString.substring(0, toIndex);
		}
	}
	
	public static void main(String[] args){
		String url = "/quickstart/rule";
		String context = "/quickstart";
		System.out.println(getContrallerPath(url, context));
	}
}
