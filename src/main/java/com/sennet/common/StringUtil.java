package com.sennet.common;


import java.text.SimpleDateFormat;
import java.util.Calendar;

import lombok.extern.slf4j.Slf4j;
public class StringUtil {


	public static String currentDateString() {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar calendar = Calendar.getInstance(java.util.Locale.KOREA);
		return format.format(calendar.getTime());
	}
	
	public static String currentDateString(String dateFormat) {
		SimpleDateFormat format = new SimpleDateFormat(dateFormat);
		Calendar calendar = Calendar.getInstance(java.util.Locale.KOREA);
		return format.format(calendar.getTime());
	}
	public static String getPlainMenu(String requestUrl,String menuUrl) {
		String requestUrl1 = requestUrl.substring(requestUrl.lastIndexOf("/"),requestUrl.lastIndexOf("."));
		String menuUrl1 = menuUrl.substring(menuUrl.lastIndexOf("/"));
		if(requestUrl==null || menuUrl==null || requestUrl.length() < 1 || menuUrl.length() < 1){
			return "true";
		}
		requestUrl1 = requestUrl.substring(requestUrl.lastIndexOf("/"),requestUrl.lastIndexOf("."));
		menuUrl1 = menuUrl.substring(menuUrl.lastIndexOf("/"));
		if(requestUrl1==null || requestUrl1.equals("")||requestUrl1==null || requestUrl1.equals("")){
			return "true";
		}
		if(requestUrl1.equals(menuUrl1)){
			return "false";
		}
		else{
			return "true";
		}
	}
	
	public static String getPastMonthDateString(String dateFormat,int interval) {
		SimpleDateFormat format = new SimpleDateFormat(dateFormat);
		Calendar calendar = Calendar.getInstance(java.util.Locale.KOREA);
		calendar.add(Calendar.MONTH, interval);
		return format.format(calendar.getTime());
	}	
	
	public static String replace(String s, String s1, String s2) {
    	if (s == null) return null;
    	if ("".equals(s1)) return s;
    	
    	int leng = s1.length();
    	int pos_s = 0;
    	int pos_e = 0;
    	StringBuffer buffer = new StringBuffer();
    	while ((pos_e=s.indexOf(s1, pos_s)) != -1) {
    		buffer.append(s.substring(pos_s, pos_e));
    		buffer.append(s2);
    		pos_s = pos_e + leng;
    	}
    	if (pos_s != s.length()) {
    		buffer.append(s.substring(pos_s));
    	}
    	return buffer.toString();
    }
}
