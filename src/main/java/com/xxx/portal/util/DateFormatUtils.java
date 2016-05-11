package com.xxx.portal.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * <p>DateFormat operation</p>
 * @author Lucky
 *
 */
public class DateFormatUtils {

	/**default DateTime format**/
	public static final String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	/**default Date format**/
	public static final String DATE_FORMAT = "yyyy-MM-dd";
	
	private static ThreadLocal<SimpleDateFormat> dateTimeThreadLocal = new ThreadLocal<SimpleDateFormat>(){
		  protected synchronized SimpleDateFormat initialValue() {  
	            return new SimpleDateFormat(DATE_TIME_FORMAT);  
	        }   
	}; 
	
	private static ThreadLocal<SimpleDateFormat> dateThreadLocal = new ThreadLocal<SimpleDateFormat>(){
		  protected synchronized SimpleDateFormat initialValue() {  
	            return new SimpleDateFormat(DATE_FORMAT);  
	        }   
	}; 
	
	public static DateFormat getDefaultTimeFormat(){
		return dateTimeThreadLocal.get();
	}
	
	public static DateFormat getDefaultDateFormat(){
		return dateThreadLocal.get();
	}
	
	/**
	 * <p>Use appointing formatter to format input date, if date is null return string defaultNullValue</p>
	 * @param formatter the specify formatter 
	 * @param date the Date to format
	 * @param defaultNullValue 
	 * @return
	 */
	public static String format(DateFormat formatter, Date date, String defaultNullValue){
		if(date == null){
			return defaultNullValue;
		}else{
			return formatter.format(date);
		}
	}
	
	/**
	 * <p>Use appointing formatter to format input date, if date is null return string "null"</p>
	 * @param formatter
	 * @param date
	 * @return
	 */
	public static String format(DateFormat formatter, Date date){
		return format(formatter, date, "null");
	}
	
	/**
	 * <p>Use default formatter to format input date</p>
	 * @param date
	 * @return
	 */
	public static String defaultFormat(Date date){
		return getDefaultTimeFormat().format(date);
	}
	
	/**
	 * <p>Parser string to Date, use appointed formatter</p>
	 * @param formatter
	 * @param str
	 * @return
	 * @throws ParseException
	 */
	public static Date parse(DateFormat formatter, String str) throws ParseException{
		return formatter.parse(str);
	}
	

	/**
	 * <p>Parser string to Date, use appointed formatter, if conversation fails, return defaultDate</p>
	 * @param formatter
	 * @param str
	 * @param defaultDate
	 * @return
	 */
	public static Date parse(DateFormat formatter, String str, Date defaultDate){
		try{
			return parse(formatter, str);
		}catch(ParseException e){
			return defaultDate;
		}
	}
}
