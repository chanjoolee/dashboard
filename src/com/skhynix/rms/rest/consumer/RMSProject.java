package com.skhynix.rms.rest.consumer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.http.HttpResponse;
import org.apache.http.auth.InvalidCredentialsException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.skhynix.rms.common.Common;
import com.skhynix.rms.common.ConfigMGR;
import com.skhynix.rms.rest.utils.HttpUtils;
import com.skhynix.rms.rest.utils.NamespaceContextMap;

@Repository
@PropertySource("classpath:config.properties")
public class RMSProject {
//	private static RMSProject instance;

	//Server Info
	@Value("${rms.rmServer}")
	private String rmServer;
	
	//@Value("${rms.rmServer}")
	//private static String staticRmServer;
	
	@Value("${rms.jtsServer}")
	private String jtsServer;
	
	@Value("${rms.OAuthToken}")
	private String OAuthToken;
	
	//User Info
	@Value("${rms.user}")
	private String user;
	
	@Value("${rms.password}")
	private String password;
	
	//REST URI View Info
	@Value("${rms.rootService}")
	private String rootService;
	
	// HttpClient
	private DefaultHttpClient httpClient;
	private boolean isConnection = false;
	
	public RMSProject(){
		//initProperties();
		initHttpClient();
	}
	
//	public RMSProject getInstance(){
////		if(instance == null) instance = new RMSProject();
////		if(isConnection == false) initHttpClient();
//		instance = new RMSProject();
//		initHttpClient();
//		return instance;
//	}
	
	
	
	public HashMap<String, String> getRMSProjectMap(){
		// 전체 프로젝트 정보 리스트 맵 
		HashMap<String, String> projectAreaInfoMap = getProjectAreaInfo(httpClient);
		
		return projectAreaInfoMap;
	}
	
	public String getAllProjectName(){
		HashMap<String, String> projectAreaInfoMap = getRMSProjectMap();
		
		StringBuffer sb = new StringBuffer();
		
		Set key = projectAreaInfoMap.keySet();
		  
		for (Iterator iterator = key.iterator(); iterator.hasNext();) {
			String keyName = (String) iterator.next();
			String valueName = (String) projectAreaInfoMap.get(keyName);

			sb.append(keyName+"\n");
		}

		//마지막 개행문자 제거
		String result  = sb.toString().substring(0, sb.toString().length()-1);
		
		return result;
	}
	
	
	public String getAllProjectId(){
		HashMap<String, String> projectAreaInfoMap = getRMSProjectMap();
		
		StringBuffer sb = new StringBuffer();
		
		Set key = projectAreaInfoMap.keySet();
		  
		for (Iterator iterator = key.iterator(); iterator.hasNext();) {
			String keyName = (String) iterator.next();
			String valueName = (String) projectAreaInfoMap.get(keyName);

			sb.append(valueName+"\n");
		}
		
		return sb.toString();
	}
	
	
	/** 
	 * DNG Project Areas Info 조회
	 * 
	 * @param httpClient
	 * @return  projectAreaInfoMap	접근 가능한 모든 프로젝트 정보가 담긴 맵
	 * 
	 */ 
	private HashMap<String,String> getProjectAreaInfo(DefaultHttpClient httpClient) {
		List<String> projectNmArr = new ArrayList<String>();
		List<String> projectAreaIdArr = new ArrayList<String>();
		
		HashMap<String,String> projectAreaInfoMap = new HashMap<String,String>();
		
		String rootServices = rmServer + rootService;
		String catalogXPath = "/rdf:Description/oslc_rm:rmServiceProviders/@rdf:resource";
		String serviceProviderTitleXPath = "//oslc:ServiceProvider/dcterms:title";
		String serviceProviderDetails = "//oslc:ServiceProvider/oslc:details/@rdf:resource";
		

		// Setup the HttClient
		HttpUtils.setupLazySSLSupport(httpClient);
		
		// Setup the rootServices request
		HttpGet rootServiceDoc = new HttpGet(rootServices);
		rootServiceDoc.addHeader("Accept", "application/rdf+xml");
		rootServiceDoc.addHeader("OSLC-Core-Version", "2.0");

		try {
			// Request the Root Services document
			HttpResponse rootServicesResponse = HttpUtils.sendGetForSecureDocument(
					rmServer, rootServiceDoc, user, password, httpClient, jtsServer, OAuthToken);
			
			if (rootServicesResponse.getStatusLine().getStatusCode() == 200) {
				
	    		// Define the XPath evaluation environment
				XPathFactory factory = XPathFactory.newInstance();
				XPath xpath = factory.newXPath();
				xpath.setNamespaceContext(
						new NamespaceContextMap(new String[]
								{	"rdf", "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
									"oslc_rm","http://open-services.net/xmlns/rm/1.0/"}));

				// Parse the response body to retrieve the catalog URI
				InputSource source = new InputSource(rootServicesResponse.getEntity().getContent());
				

				Node attribute = (Node) (xpath.evaluate(catalogXPath, source, XPathConstants.NODE));
				String serviceProvidersCatalog = attribute.getTextContent();
				rootServicesResponse.getEntity().consumeContent();
				
				// Setup the catalog request
				HttpGet catalogDoc = new HttpGet(serviceProvidersCatalog);
				catalogDoc.addHeader("Accept", "application/xml");
				catalogDoc.addHeader("OSLC-Core-Version", "2.0");
				
				// Access to the Service Providers catalog
				HttpResponse catalogResponse = HttpUtils.sendGetForSecureDocument(
						rmServer, catalogDoc, user, password, httpClient, jtsServer, OAuthToken);
				if (catalogResponse.getStatusLine().getStatusCode() == 200) {
		    		// Define the XPath evaluation environment
					XPath xpath2 = factory.newXPath();
					xpath2.setNamespaceContext(
							new NamespaceContextMap(new String[]
									{	"oslc", "http://open-services.net/ns/core#",
										"rdf", "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
										"dcterms","http://purl.org/dc/terms/"}));
					
					// Parse the response body to retrieve the Service Provider
					source = new InputSource(catalogResponse.getEntity().getContent());

					NodeList titleNodes = (NodeList) (xpath2.evaluate(serviceProviderTitleXPath, source, XPathConstants.NODESET));
					
					// Print out the title of each Service Provider
					int length = titleNodes.getLength();
					for (int i = 0; i < length; i++) {
						projectNmArr.add(titleNodes.item(i).getTextContent());
						
					}
					
					
					XPath xpath3 = factory.newXPath();
					xpath3.setNamespaceContext(
							new NamespaceContextMap(new String[]
									{	"oslc", "http://open-services.net/ns/core#",
										"rdf", "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
										"dcterms","http://purl.org/dc/terms/"}));
					
					HttpResponse catalogResponse3 = HttpUtils.sendGetForSecureDocument(
							rmServer, catalogDoc, user, password, httpClient, jtsServer, OAuthToken);
					source = new InputSource(catalogResponse3.getEntity().getContent());
					
					NodeList titleNodes3 = (NodeList) (xpath2.evaluate(serviceProviderDetails, source, XPathConstants.NODESET));
					
					// Print out the title of each Service Provider
					int length3 = titleNodes3.getLength();
					for (int i = 0; i < length3; i++) {
						String content = titleNodes3.item(i).getTextContent();
						String paId = content.substring(content.lastIndexOf("/") +1, content.length());
						projectAreaIdArr.add(paId);
					}
				}
				
				if(projectNmArr.size() > 0 && projectAreaIdArr.size() > 0){
					if(projectNmArr.size() == projectAreaIdArr.size()){
						
						for(int i = 0 ; i < projectNmArr.size() ; i++){
							projectAreaInfoMap.put(projectNmArr.get(i), projectAreaIdArr.get(i));
							
						}
					}
				}
			}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XPathExpressionException e) {
			e.printStackTrace();
		} catch (InvalidCredentialsException e) {
			e.printStackTrace();
		} finally {
			// Shutdown the HTTP connection
			//httpClient.getConnectionManager().shutdown();
			//isConnection = false;
		}
		return projectAreaInfoMap;
	}
	
	
	
	
	
	/** 
	 * Init HttpClient
	 * 
	 */ 
	private void initHttpClient() {
		// Setup the HttpClient
		httpClient = new DefaultHttpClient();
		
		isConnection = true;
	}
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
		return new PropertySourcesPlaceholderConfigurer();
	}
}
