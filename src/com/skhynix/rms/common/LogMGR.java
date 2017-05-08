package com.skhynix.rms.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.jconfig.Configuration;
import org.jconfig.ConfigurationManager;

/**
 * 로그 메니저 클래스
 * 
 * 로그 디렉토리에 로그파일을 생성한다.
 * 로그는 하루 한개의 로그파일을 생성하여 출력한다.
 * 
 */
public class LogMGR {
	
	private static LogMGR instance;
	
	private static ConfigurationManager configurationManager;
	private static Configuration configuration;
	
	// 프로퍼티 로드여부 플래그 (미로드 : false, 로드 : true)
	private static boolean isLoad = false;
	// RTC 설치 디렉토리
	private static String homeDir;
	// 프로퍼티 파일 위치
	private static String propertiesPath;
	
	
	//로그 파일 출력을 위한 Writer
	private static PrintWriter out = null;
	//현재 출력되고 있는 로그파일명
	private static String currentLogFileName = null;
	//로그 디렉토리
	private String logDir;
	//로그레벨 : 0 = ERROR / 1 = ERROR, INFO / 2 = ERROR, INFO, DEBUG
	private int logLevel; 
	
	
	private LogMGR(){
		init();
	}
	
	public static LogMGR getInstance(){
		if(instance == null) instance = new LogMGR();
		return instance;
	}
	
	/**
	 * 초기화
	 */
	private void init(){
		configurationManager = ConfigurationManager.getInstance();
		
		//  시스템 프로퍼티를 가져옴
		Properties sysProps = System.getProperties();
		// 설치 디렉토리 정보
		homeDir = sysProps.getProperty("user.dir");
		// 프로퍼티 파일 경로
		propertiesPath = homeDir + "/config/" + Common.PROPERTIES_FILE_NAME;

		
		//로그 디렉토리
		logDir = homeDir + "/logs";
		//로그 레벨
		// log level : 0 = ERROR / 1 = ERROR, INFO / 2 = ERROR, INFO, DEBUG 
		logLevel = 2;
		
		//생성할 로그파일명
		String createLogFileName = getLogFileName();
		//로그 생성경로
		String logPath = logDir + "/" + createLogFileName;
		try {
			//로그 Writer가 이미 있는경우 close한다.
			if(out != null)	out.close();
			//로그 디렉토리 생성
			new File(logDir).mkdir();
			//로그 Writer 생성
			out = new PrintWriter(new OutputStreamWriter(new FileOutputStream(logPath, true), Common.LOG_FILE_ENCODING));
			//현재로그파일이름 클래스변수에  새로생성한 로그파일 이름 저장
			currentLogFileName = createLogFileName;
			//System.out.println("[INFO ] " + Common.PLUGIN_NAME + " LogFile init success (" + logPath + ")");
		} catch (Exception e) {
			System.out.println("[ERROR] " + Common.PLUGIN_NAME + " - LogMGR.java - init()");
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 로그 레벨 확인 (DEBUG)
	 * @return
	 */
	public boolean isDebug(){
		if(logLevel > 1) return true;
		else return false;
	}
	
	/**
	 * 로그 레벨 확인 (INFO)
	 * @return
	 */
	public boolean isInfo(){
		if(logLevel > 0) return true;
		else return false;
	}
	
	/**
	 * DEBUG log
	 * @param logStr 출력문자열
	 */
	public void debug(String logStr){
		printFileLog(logStr, 2, logLevel);
	}
	
	/**
	 * INFO log
	 * @param logStr 출력문자열
	 */
	public void info(String logStr){
		printFileLog(logStr, 1, logLevel);
	}
	
	/**
	 * ERROR log
	 * @param logStr 출력문자열
	 */
	public void error(String logStr){
		printFileLog(logStr, 0, logLevel);
	}
	
	/**
	 * ERROR log
	 * Exception의 printStackTrace를 문자열로 출력한다.
	 * @param e Exception
	 */
	public void error(Exception e){
		StringWriter error = new StringWriter();
		e.printStackTrace(new PrintWriter(error));
		error(error.toString());
		
		try { error.close();
		} catch (Exception e1) {
			System.out.println("[ERROR] " + Common.PLUGIN_NAME + " - LogMGR.java - error()");
			e.printStackTrace();
		}
	}
	
	/**
	 * 로그 레벨에 따라 로그메시지를 출력한다.
	 * @param logStr 로그 메시지
	 * @param logKind 로그 종류 (ERROR=0, INFO=1, DEBUG=2) 
	 * @param logLevel 로그 레벨 (0 = ERROR / 1 = ERROR, INFO / 2 = ERROR, INFO, DEBUG)
	 */
	private void printFileLog(String logStr, int logKind, int logLevel){
		switch(logLevel){
		case 0:
			if(logKind == 0) printFileLog(logStr, logKind);
			break;
		case 1:
			if(logKind == 0 || logKind == 1) printFileLog(logStr, logKind);
			break;
		default:
			printFileLog(logStr, logKind);
		}
	}
	
	/**
	 * 로그 메시지를 파일에 출력한다.
	 * 
	 * 로그파일은 하루에 하나씩 생성된다.(Daily Log)
	 * 로그를 생성하기 전에  출력하고 있는 로그파일명의 날짜와 현재날짜와 다르면 현재날짜로 새로운 로그파일을 생성한다.
	 * 
	 * @param logStr 로그메시지
	 * @param logKind 로그종류
	 */
	private void printFileLog(String logStr, int logKind){
		
		//로그파일명 체크 (Daily Log)
		if(getLogFileName().equals(currentLogFileName) == false){
			//System.out.println("[INFO ] " + Common.PLUGIN_NAME + " - LogMGR.java - printFileLog() : new logFile create. filename=" + getLogFileName());
			init();
		}
		//로그 메시지 생성
		String currentTime = resolveMillisecond(System.currentTimeMillis(), "yyyy-MM-dd HH:mm:ss");
		String kind = null;
		switch(logKind){
		case 0:
			kind = "ERROR";
			break;
		case 1:
			kind = "INFO ";
			break;
		case 2:
			kind = "DEBUG";
			break;
		default:
			kind = "";
		}
		
		out.print("[" + currentTime + " " + kind + "] " + logStr + "\r\n");
		out.flush();
	}
	
	/**
	 * 로그파일 이름을 리턴한다.
	 * 로그파일 이름은 클래스변수로 선언된 LOG_FILE_NAME 뒤에 _yyyyMMdd를 붙인 형태이다.
	 * @return 로그파일 이름
	 */
	private String getLogFileName(){
		return Common.LOG_FILE_NAME.replace("yyyyMMdd", resolveMillisecond(System.currentTimeMillis(), "yyyyMMdd"));
	}
	
	public static String resolveMillisecond(long millisecond, String dateFormatStr){
		SimpleDateFormat dateFormat = new SimpleDateFormat(dateFormatStr);
		return dateFormat.format(new Date(millisecond));
	}
}
