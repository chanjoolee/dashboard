package com.skhynix.rms.common;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * 유틸리티 클래스
 * 
 * - 기본 유틸리티 기능을 제공하는 클래스
 * 
 */
public class Utils {	
	/**
	 * 밀리세컨드를 전달받은 날짜포멧으로 바꿔준다. 
	 * @param millisecond 
	 * @param dateFormat (ex : yyyy-MM-dd HH:mm:ss, yyyyMMdd)
	 * @return
	 */
	public static String resolveMillisecond(long millisecond, String dateFormatStr){
		
		SimpleDateFormat dateFormat = new SimpleDateFormat(dateFormatStr);
		return dateFormat.format(new Date(millisecond));
		
	}
	
	/**
	 * 문자열이 null 또는 빈문자열인지 체크한다.
	 * @param str 대상문자열
	 * @return 문자열이 null 또는 빈문자열이면 true, 아니면 false
	 */
	public static boolean isNull(String str){
		if(str == null){
			return true;
		}else if(str.trim().length() == 0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 문자열이 null 또는 빈문자열이 아닌지 체크한다.
	 * @param str 대상문자열
	 * @return 문자열이 null 또는 빈문자열이 아니면 true, 문자열이 null 또는 빈문자열이면 false
	 */
	public static boolean isNotNull(String str){
		if(str == null){
			return false;
		}else if(str.trim().length() == 0){
			return false;
		}else{
			return true;
		}
	}
	
	
	/**
	 * 타임스태프가 null 이 아닌지 체크한다.
	 * @param ts 대상타임스탬프
	 * @return 타임스탬프가 null 이 아니면 true,  null 이면 false
	 */
	public static boolean isNotNull(Timestamp ts){
		if (ts == null){
	    	return false;
		}else{
			return true;
		}
	}
	
	
	/**
	 * 파일명의 확장자를 리턴한다.
	 * @param fileName
	 * @return
	 */
	public static String getFileExtension(String fileName){
		
		String allowPattern = "\\.([^\\.]*)$";
		
		Pattern p = Pattern.compile(allowPattern);
		Matcher m = p.matcher(fileName.toLowerCase());
		
		if(m.find()){
			return m.group().substring(1).toLowerCase(); //'.'제거, 소문자변환
		}else{
			return null;
		}
	}
	
	
	/**
	 * 객체가 null 인지 체크
	 * @param object
	 * @return
	 */
	 public static boolean isEmpty(Object object) {
         if (object == null) {
             return true;
         }else{
        	 return false;
         }
	 }
	 
	 
	/**
	 * null 문자열을 제거한다.
	 * @param text
	 * @return
	 */
	 public static String textWithoutNullString(String text){
		String pattern0 = "null";
		String textWithoutNull = text.replaceAll(pattern0, "");
	
		if (isNotNull(textWithoutNull)) {
			return textWithoutNull;
		}
		return "";
	}

	 
	/**
	 * 문자열을 원하는 사이즈(바이트)로 자른다.
	 * @param str
	 * @param endIndex
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String cutFirstStrlnByte(String str, int byteSize) throws UnsupportedEncodingException{
		if(str != null){
			StringBuffer sbStr = new StringBuffer();
			int total = 0;
			for(char c : str.toCharArray()){
				total += String.valueOf(c).getBytes("UTF-8").length;
				if(total > byteSize){
					break;
				}
				sbStr.append(c);
			}
			return sbStr.toString();
		}
		return null;
	}
}