package com.skhynix.rms.common;

import java.io.File;
import java.util.Properties;

import org.jconfig.Configuration;
import org.jconfig.ConfigurationManager;
import org.jconfig.handler.XMLFileHandler;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;



/**
 * 설정정보를 관리하는  클래스
 * 
 */
public class ConfigMGR {
	
	private static final String DEFAULT_CATEGORY = "general";	
	private static final String CONFIG_NM = "xmlConfig";
	private static ConfigurationManager configurationManager;
	private static Configuration configuration;
	
	// 프로퍼티 로드여부 플래그 (미로드 : false, 로드 : true)
	private static boolean isLoad = false;
	// RTC 설치 디렉토리
	private static String homeDir;
	// 프로퍼티 파일 위치
	private static String propertiesPath;
	
	private ConfigMGR(){
		
	}

	/**
	 * 프로퍼티 정보를 초기화하는 오퍼레이션
	 * 
	 */
	private static void init(){
		
		//System.out.println("[INFO ] - " + Common.PLUGIN_NAME + " : ConfigMGR init() !!!");
		
		configurationManager = ConfigurationManager.getInstance();
		
		//  시스템 프로퍼티를 가져옴
		Properties sysProps = System.getProperties();
		// 설치 디렉토리 정보
		homeDir = sysProps.getProperty("user.dir");
		// 프로퍼티 파일 경로
		propertiesPath = homeDir + "/config/" + Common.PROPERTIES_FILE_NAME;
		
		//HttpServletRequest request = new javax.servlet.http.HttpServletRequestWrapper(null);
		try{
			File configXmlFile = new File(propertiesPath);
			XMLFileHandler xmlFileHandler = new XMLFileHandler();
			xmlFileHandler.setFile(configXmlFile);
			xmlFileHandler.setEncoding(Common.PROPERTIES_ENCODING);
		
			configurationManager.load(xmlFileHandler, CONFIG_NM);
			configuration = ConfigurationManager.getConfiguration(CONFIG_NM);
			
			//System.out.println("[INFO ] - " + Common.PROPERTIES_FILE_NAME + " read success ! (" + propertiesPath + ")");
		}catch(Exception e){
			//System.out.println("[ERROR] - " + Common.PROPERTIES_FILE_NAME + " read failure ! (" + propertiesPath + ")");
			//e.printStackTrace();
		}
		
		//프로퍼티 로드 여부 설정
		isLoad = true;
		
	}
	
	/**
	 * 기본 카테고리에서 키에 해당하는 값을 리턴(String)
	 * @param key
	 * @return
	 */
	public static String getStringProperty(String key){
		return getStringProperty(key, DEFAULT_CATEGORY);
	}
	
	/**
	 * 기본 카테고리에서 키에 해당하는 값을 리턴(Integer)
	 * @param key
	 * @return
	 */
	public static int getIntProperty(String key){
		return getIntProperty(key, DEFAULT_CATEGORY);
	}
	
	/**
	 * 해당 카테고리에서 키에 해당하는 값을 리턴(String)
	 * @param key
	 * @param category
	 * @return
	 */
	public static String getStringProperty(String key, String category){
		
		if(isLoad == false) init();
		
		String value = configuration.getProperty(key, null, category);
		if(value != null){
			return value;
		}else{
			throw new IllegalArgumentException("카테고리(" + category + "), 프로퍼티 키("+ key +")에 해당하는 값이 없습니다.");
		}
	}
	
	/**
	 * 해당 카테고리에서 키에 해당하는 값을 리턴(Integer)
	 * @param key
	 * @param category
	 * @return
	 */
	public static int getIntProperty(String key, String category){
		if(isLoad == false) init();
		
		int value = configuration.getIntProperty(key, -1, category);
		if(value != -1){
			return value;
		}else{
			throw new IllegalArgumentException("카테고리(" + category + "), 프로퍼티 키("+ key +")에 해당하는 값이 없습니다.");
		}
	}
	
	/**
	 * 	
	 * @return
	 */
	public static String getHomeDir() {
		if(isLoad == false) init();
		
		return homeDir;
	}

	/**
	 * 프로퍼티 재로드를 위해 값을 설정하는 오퍼레이션 
	 */
	public static void reLoadProperties(){
		// 미로드 초기화
		isLoad = false;
	}
}
