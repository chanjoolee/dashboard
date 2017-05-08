package com.skhynix.rms.rest.consumer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.http.HttpResponse;
import org.apache.http.auth.InvalidCredentialsException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.skhynix.rms.common.Common;
import com.skhynix.rms.common.ConfigMGR;
import com.skhynix.rms.common.LogMGR;
import com.skhynix.rms.common.Utils;
import com.skhynix.rms.rest.utils.HttpUtils;

@Repository
@PropertySource("classpath:config.properties")
public class RMSDevProgress {
	static LogMGR logMGR = LogMGR.getInstance();
	
	
	
//	private static RMSDevProgress instance;
	
	@Autowired
    private RMSProject rmsProject;

	//All ProjectArea Map
	private HashMap<String, String> projectAreaInfoMap;
	
	//Server Info
	@Value("${rms.rmServer}")
	private String rmServer;
	
	@Value("${rms.jtsServer}")
	private String jtsServer;
	
	@Value("${rms.OAuthToken}")
	private String OAuthToken;
	
	//User Info
	@Value("${rms.user}")
	private String user;
	
	@Value("${rms.password}")
	private String password;
	
	//REST URI Info
	@Value("${rms.size}")
	private String size;
	
	@Value("${rms.pos}")
	private String pos;  // 0부터 시작
	
	//REST URI View Info
	
	@Value("${rms.rootService}")
	private String rootService;
	
	@Value("${rms.reqView}")
	private String reqView;
	
	@Value("${rms.testView}")
	private String testView;
	
	// HttpClient
	private DefaultHttpClient httpClient;
	private boolean isConnection = false;
	
	public RMSDevProgress(){
		initHttpClient();
	}
	
	
	
	
	/** 
	 * 전체 프로젝트의 Development Progress 카운트 조회
	 * 
	 * @return Map <프로젝트명, RMSDevProgressInfo>
	 * 	
	 * @throws ParserConfigurationException 
	 * @throws SAXException 
	 * @throws IOException 
	 * @throws XPathExpressionException 
	 * @throws InvalidCredentialsException 
	 * 
	 */ 
	public Map<String, RMSDevProgressInfo> getAllProjectInfoForDevProgress(){
		// 전체 프로젝트의 결과를 담을 맵
		
		Map<String, RMSDevProgressInfo> allRMSDevProgressInfo = new HashMap<String, RMSDevProgressInfo>();

//		if(projectAreaInfoMap == null ){
//			setRMSProjectMap();
//		}
		setRMSProjectMap();
		
		if(projectAreaInfoMap.size() > 0){
			Set key = projectAreaInfoMap.keySet();
			  
			for (Iterator iterator = key.iterator(); iterator.hasNext();) {
				// 프로젝트명
				String keyName = (String) iterator.next();
				// 프로젝트 ID
				String valueName = (String) projectAreaInfoMap.get(keyName);

				logMGR.debug("Project Name="+keyName+ ", Project ID " + valueName);
				
				// Requirement GET REST 호출
				RMSDevProgressInfo requirementInfo = getRequirementsInfo(httpClient, valueName);
				// TestItem GET REST 호출
				RMSDevProgressInfo testItemInfo = getTestItemInfo(httpClient, valueName);

				//합산 결과를 담을 RMSDevProgressInfo
				RMSDevProgressInfo rmsDevProgressInfo = new RMSDevProgressInfo();
				
				//Implementation, TestCoverage 요건 세팅
				rmsDevProgressInfo.setTotalRequirementCount(requirementInfo.getTotalRequirementCount()); // Req.Count
				rmsDevProgressInfo.setTotalImplementedRequirementCount(requirementInfo.getTotalImplementedRequirementCount());	//Implementation
				rmsDevProgressInfo.setTotalExistsVerifiedByLinkRequirementCount(requirementInfo.getTotalExistsVerifiedByLinkRequirementCount()); // TestCoverage
				rmsDevProgressInfo.setRequirementIdAndVerifiedByLinkTestItemIdMap(requirementInfo.getRequirementIdAndVerifiedByLinkTestItemIdMap());
				
				//Verification 요건 세팅
				rmsDevProgressInfo.setTotalTestCaseCount(testItemInfo.getTotalTestCaseCount()); //요건 변경으로 미사용
				rmsDevProgressInfo.setTotalPassedTestCaseCount(testItemInfo.getTotalPassedTestCaseCount());//요건 변경으로 미사용
				////Verification 요건 세팅을 위한 맵 설정
				rmsDevProgressInfo.setTestItemIdAndVerfiedValueMap(testItemInfo.getTestItemIdAndVerfiedValueMap());
				
				Map<String, List> requirementIdAndVerifiedByLinkTestItemIdMap = rmsDevProgressInfo.getRequirementIdAndVerifiedByLinkTestItemIdMap();
				Map<String, String> testItemIdAndVerfiedValueMap = rmsDevProgressInfo.getTestItemIdAndVerfiedValueMap();
				
				//// Verification 카운트
				int verificationCount = 0;
				
				
				if(requirementIdAndVerifiedByLinkTestItemIdMap != null && testItemIdAndVerfiedValueMap != null){
					Set key2 = requirementIdAndVerifiedByLinkTestItemIdMap.keySet();

					for (Iterator iterator2 = key2.iterator(); iterator2.hasNext();) {
						String requirementId = (String) iterator2.next();
						List testItemIdList = (List) requirementIdAndVerifiedByLinkTestItemIdMap.get(requirementId);
						
						boolean isVerified = false;
						
						for(int i=0 ; testItemIdList.size() > i ; i++){
							String testItemId = (String) testItemIdList.get(i);
							
							String verifiedAttributeValue = testItemIdAndVerfiedValueMap.get(testItemId);
							if(verifiedAttributeValue.equals("Y")){
								isVerified = true;
							}else{
								isVerified = false;
								break;
							}
						}
						
						if(isVerified){
							++verificationCount;
						}
					}
				}
				
				
				//Verification 요건 세팅
				rmsDevProgressInfo.setTotalVerifiedRequirementCount(verificationCount);


				logMGR.debug("["+ keyName + "] TotalRequirementCount=" + requirementInfo.getTotalRequirementCount() + ", TotalImplementedRequirementCount=" + requirementInfo.getTotalImplementedRequirementCount() +
						", TotalExistsVerifiedByLinkRequirementCount=" + requirementInfo.getTotalExistsVerifiedByLinkRequirementCount() + ", TotalVerficationCount=" + verificationCount +", TotalTestCaseCount=" + testItemInfo.getTotalTestCaseCount() +
						", TotalPassedTestCaseCount=" + testItemInfo.getTotalPassedTestCaseCount() + ",TotalVerifiedRequirementCount=" + verificationCount);
				
				// 프로젝트명, RMSDevProgressInfo 세팅
				allRMSDevProgressInfo.put(keyName, rmsDevProgressInfo);
			}
		}else{
			logMGR.error("[ERROR] RMS 시스템에서 프로젝트를 조회할 수 없습니다. !");
			throw new RuntimeException("[ERROR] RMS 시스템에서 프로젝트를 조회할 수 없습니다. !");
		}
		
		// Shutdown Http Connection
		//shutdownHttpConnection();
		
		return allRMSDevProgressInfo;
	}

	
	/** 
	 * Get - RequirementInfo
	 * 
	 * @return result
	 * @throws IOException 
	 * @throws InvalidCredentialsException 
	 * @throws ParserConfigurationException 
	 * @throws SAXException 
	 * @throws XPathExpressionException 
	 * 
	 */ 
	protected RMSDevProgressInfo getRequirementsInfo(DefaultHttpClient httpClient, String paId){
		logMGR.debug(">> getRequirementsInfo");
		
		boolean isNext = true;
		// 아티팩트 전체 갯수
		int atrifactTotalCount = 0 ;
		// 요구사항 아티팩트 전체 갯수
		int requirementCount = 0;
		// 구현 요건에 해당하는 아티팩트 전체 갯수
		int implementedRequirementCount = 0;
		// Verified By 링크 존재하는 아티팩트 전체 갯수
		int existsVerifiedByLinkRequirementCount = 0;
		// 요구사항 아티팩트의 ID 및 'Verified By' 링크가 걸린 테스트아이템 ID 리스트를 담을 맵(요구사항ID, 테스트아이템ID,테스트아이템ID1,...)
		Map<String, List> requirementIdAndVerifiedByLinkTestItemIdMap = new HashMap<String, List>();
		// xml 에서의 전체 갯수
		int totalCount = 0;
		// while 문 내에서의 index
		int loopindex = 0;
		// 정수형 size
		int iSize = Integer.parseInt(size);
		// 정수형 pos
		int iPos = Integer.parseInt(pos);

		// 상태 조건
		String statusCondition1 = "Implemented";
		String statusCondition2 = "Tested (Simulator)";
		String statusCondition3 = "Verified (PE)";
		
		// 리턴용 객체
		RMSDevProgressInfo rmsDevProgressInfo = new RMSDevProgressInfo();
		
		// 1000개 이상의 아아티팩트가 있는 경우 다시 request 한다.
		while (isNext) {
			++loopindex;
			// Request the All SW Requirements
			//// ex) https://rms.skhynix:9443/rm/publish/resources?viewName=All_Requirements_view&projectURI=_PmnK0J_REeWRnaHpueE2GQ&size=1000&pos=0
			String requestAllRequirementsDoc = rmServer + "/publish/resources?viewName=" + reqView + "&projectURI=" + paId + "&size=" + iSize + "&pos=" + iPos;		
			logMGR.info("- requestAllRequirementsDoc="+requestAllRequirementsDoc);
			
			// requestHttpClient 실행
			HttpResponse responseAllRequirements = requestHttpClient(httpClient, requestAllRequirementsDoc);
			
			if (responseAllRequirements.getStatusLine().getStatusCode() == 200) {
				logMGR.info("successful response! \n");

				//테스트 : XML 내용 출력
				//HttpEntity entity = responseAllRequirements.getEntity();
				//System.out.println(EntityUtils.toString(entity));				
				
				try {
					InputSource inputSource = new InputSource(responseAllRequirements.getEntity().getContent());
					Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inputSource);
					Element element = document.getDocumentElement();
					
					// 재수행 여부 체크
					isNext = element.hasAttribute("rel");
					
					logMGR.debug("loopindex="+loopindex +", isNext="+ isNext);
					
					// 재수행 필요시 pos 값 증가
					if(isNext) iPos = iPos + Integer.parseInt(size);
					
					// 표현식
					String  expression = "/*";
					
					XPath xpath = XPathFactory.newInstance().newXPath();
					NodeList  rootNode = (NodeList) xpath.compile(expression).evaluate(document, XPathConstants.NODESET);
					
					if(element.hasAttribute("rrm:totalCount")){
						// 전체 개수 집계
						totalCount = Integer.parseInt(rootNode.item(0).getAttributes().getNamedItem("rrm:totalCount").getTextContent());
						atrifactTotalCount = atrifactTotalCount + totalCount;
										
						// 자식 노드엣 값들을 가져와서 조건에 맞는 아티팩트의 수를 카운트 해야한다.
						NodeList artifacts = (NodeList) rootNode.item(0);

					    int length = artifacts.getLength();
					    
					    logMGR.debug(">> atrifactTotalCount="+atrifactTotalCount +", totalCount="+ totalCount + ", artifacts Length="+ length);
					    
					    
					    // ds:artifact 반복
						for (int i2 = 0; i2 < length; i2++) {
							String title = ""; 
							String id = "";
							String testItemID = "";

							boolean isExistsVerifiedByLink = false;
							boolean isImplementedStatus = false;
							boolean isRequirement = false;
							
							List<String> verifiedByLinkTestItemIdList = new ArrayList<String>();

							NodeList artifact = (NodeList) artifacts.item(i2);   //ds:artifact
							
							for (int j = 0; j < artifact.getLength(); j++) {
								//System.out.println("artifactName="+artifact.item(j).getNodeName());
								
								// 1. 제목
								if(artifact.item(j).getNodeName().equals("rrm:title")) {
									title = artifact.item(j).getTextContent();
								}
								// 2. ID
								if(artifact.item(j).getNodeName().equals("rrm:identifier")) {
									id = artifact.item(j).getTextContent();
								}
								
								// 3. Verified By 링크 조회
								if(artifact.item(j).getNodeName().equals("ds:traceability")) {
									NodeList links = (NodeList) artifact.item(j).getChildNodes();
									
									for (int k1=0; k1 < links.getLength(); k1++) {
										//System.out.println(">> \t\t NodeName =  " + links.item(k1).getNodeName());
										
										if (links.item(k1).getNodeName().equals("ds:links")) {
											//TestItem 링크 ID
											List<String> verifiedByLinkTestItemId = new ArrayList<String>(); 
											
											NodeList linkNodes = (NodeList) links.item(k1).getChildNodes();
											//System.out.println(">> \t\t\t NodeNmae()="+ linkNodes.item(k1).getNodeName());
											
											for (int l=0; l < linkNodes.getLength(); l++) {
												
												boolean isVerifiedByLink = false;
												boolean isTestItem = false;
												
												
												if (linkNodes.item(l).getNodeName().equals("ds:Link")) {
													NodeList linkInfoNodes = (NodeList) linkNodes.item(l).getChildNodes();
													
													//System.out.println(">> \t\t\t\t NodeNmae()="+ linkInfoNodes.item(l).getNodeName());
													
													for (int m=0; m < linkInfoNodes.getLength(); m++) {
														
														if (linkInfoNodes.item(m).getNodeName().equals("rrm:title")) {
															if(linkInfoNodes.item(m).getTextContent().equals("Verified By")){
																//System.out.println(">> \t\t\t\t\t link = " + linkInfoNodes.item(m).getTextContent());
																isVerifiedByLink = true;
															}
														}
														else if (linkInfoNodes.item(m).getNodeName().equals("rrm:identifier")) {
																testItemID = linkInfoNodes.item(m).getTextContent();
														}
														else if (linkInfoNodes.item(m).getNodeName().equals("ds:content")) {
															for (int n=0; n < linkInfoNodes.getLength(); n++) {
																NodeList linkContentNodes = (NodeList) linkInfoNodes.item(n).getChildNodes();
																
																for (int o=0; o < linkContentNodes.getLength(); o++) {
																	if (linkContentNodes.item(o).getNodeName().equals("ds:artifactFormat")) {
																		if(linkContentNodes.item(o).getTextContent().equals("Test Item")){
																			isTestItem = true;
																		}
																	}
																}
															}
														}
														
														// Verified By 및 TestItem 이면 리스트에 추가
														if(isVerifiedByLink && isTestItem && Utils.isNotNull(testItemID)){
															isExistsVerifiedByLink = true;
															verifiedByLinkTestItemId.add(testItemID);
														}
													}
												}
											} //ds:Link
											
											// 테스트아이템 ID를 맵에 추가
											if(verifiedByLinkTestItemId.size() > 0){
												//HashSet 에 담아 중복값 제거
												verifiedByLinkTestItemIdList = new ArrayList<String>(new HashSet<String>(verifiedByLinkTestItemId));
												//정렬
												Collections.sort(verifiedByLinkTestItemIdList);
												
												//요구사항 아티팩트의 ID 및 'Verified By' 링크가 걸린 테스트아이템 ID 리스트를 담을 맵에 추가
												requirementIdAndVerifiedByLinkTestItemIdMap.put(id, verifiedByLinkTestItemIdList);
											}
										} //ds:links
									}
								}
								
								NodeList cols =  (NodeList) artifact.item(j).getChildNodes();
								
								for (int k=0; k < cols.getLength(); k++) {
									
									// 4. Custom Attribute : Implement 요건
									if (cols.item(k).getNodeName().equals("rrm:attributes")) {
										NodeList attribute = (NodeList) cols.item(k).getChildNodes();
										
										for (int k1=0; k1 < attribute.getLength(); k1++) {
											if (attribute.item(k1).getNodeName().equals("attribute:objectType")) {

												NodeList customAttributeNodes = (NodeList) attribute.item(k1).getChildNodes();
												//System.out.println(">> \t\t\t caNodes.getLength()="+ customAttributeNodes.getLength());
												
												for (int l=0; l < customAttributeNodes.getLength(); l++) {
													if(customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:name").getNodeValue().equals("Content Type")){
														//System.out.println(">> \t\t\t literal = " + customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName"));
														//System.out.println(customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName").getTextContent());
														
														if(customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName").getTextContent().equals("Requirement")){
															isRequirement = true;
														}
													}
													else if(customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:name").getNodeValue().equals("Status")){
														//System.out.println(">> \t\t\t literal =  " + customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName"));
														
														// 상태 조건 체크
														if(customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName").getTextContent().equals(statusCondition1) ||
														   customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName").getTextContent().equals(statusCondition2) ||
														   customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName").getTextContent().equals(statusCondition3)){
															isImplementedStatus = true;
														}
													}
												}
											}
										}
									}
								}
							}
							logMGR.info("["+ loopindex +"]["+ i2 +"] " + title+"(" + id +") : isRequirement=" + isRequirement +",  isImplementedStatus="+ isImplementedStatus +", isExistsVerifiedByLink="+ isExistsVerifiedByLink +", verifiedByLinkTestItemIdList=" + verifiedByLinkTestItemIdList.toString());
							
							if(isRequirement){
								logMGR.debug("++requirementCount");
								
								// COUNT
								++requirementCount;
							}
							
							if(isRequirement && isImplementedStatus){
								logMGR.debug("++implementedRequirementCount");
								
								// COUNT
								++implementedRequirementCount;
							}
							
							if(isRequirement && isExistsVerifiedByLink){
								logMGR.debug("++existsVerifiedByLinkRequirementCount");
								
								// COUNT
								++existsVerifiedByLinkRequirementCount;
							}
						}
						
						logMGR.debug(">> \t  artifactCount="+ length);
						logMGR.debug(">> \t  TotalRequirementCount="+ requirementCount);
						logMGR.debug(">> \t  TotalImplementedRequirementCount="+ implementedRequirementCount);
						logMGR.debug(">> \t  TotalExistsVerifiedByLinkRequirementCount="+ existsVerifiedByLinkRequirementCount);
					// TotalCount 값이 없고 Requst가 처음인 경우 모든 값 0 으로 초기화
					}else if(loopindex == 1){
						rmsDevProgressInfo.setTotalRequirementCount(0);
						rmsDevProgressInfo.setTotalImplementedRequirementCount(0);
						rmsDevProgressInfo.setTotalExistsVerifiedByLinkRequirementCount(0);
						
						return rmsDevProgressInfo;
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} catch (SAXException e) {
					e.printStackTrace();
				} catch (ParserConfigurationException e) {
					e.printStackTrace();
				} catch (XPathExpressionException e) {
					e.printStackTrace();
				}
			} else {
				System.out.println("Request failed! \n");
			}
		} // End of while	
		
		logMGR.info("#########################################################");
		logMGR.info("###  requirementCount="+requirementCount);
		logMGR.info("###### - implementedRequirementCount="+implementedRequirementCount);
		logMGR.info("###### - existsVerifiedByLinkRequirementCount="+existsVerifiedByLinkRequirementCount);
		logMGR.info("#########################################################");
		
		rmsDevProgressInfo.setTotalRequirementCount(requirementCount);
		rmsDevProgressInfo.setTotalImplementedRequirementCount(implementedRequirementCount);
		rmsDevProgressInfo.setTotalExistsVerifiedByLinkRequirementCount(existsVerifiedByLinkRequirementCount);
		rmsDevProgressInfo.setRequirementIdAndVerifiedByLinkTestItemIdMap(requirementIdAndVerifiedByLinkTestItemIdMap);
		
		return rmsDevProgressInfo;
	}
	
	
	/** 
	 * Get - TestItemInfo
	 * 
	 * @return result
	 * @throws IllegalStateException 
	 * @throws IOException 
	 * @throws InvalidCredentialsException 
	 * @throws ParserConfigurationException 
	 * @throws SAXException 
	 * @throws XPathExpressionException 
	 * 
	 */ 
	protected RMSDevProgressInfo getTestItemInfo(DefaultHttpClient httpClient, String paId){
		logMGR.debug(">> getTestItemInfo");
		
		if(isConnection == false) initHttpClient();
		
		boolean isNext = true;
		// 전체 Test Item 아티팩트 개수(Verification 요건)
		int atrifactTotalCount = 0 ;
		// 전체 패스된 Test Item 아티팩트 개수(Verification 요건) 
		int passedTestCaseCount = 0;
		//테스트아이템 아티팩트의 ID 및 'Verified' 속성값 정보를 담을 맵(테스트아이템ID, 'Y' OR 'N')
		Map<String, String> testItemIdAndVerfiedValueMap = new HashMap<String, String>();
		// xml 에서의 전체 갯수
		int totalCount = 0;
		// while 문 내에서의 index
		int loopindex = 0;
		// 정수형 size
		int iSize = Integer.parseInt(size);
		// 정수형 pos
		int iPos = Integer.parseInt(pos);

		//리턴용 객체
		RMSDevProgressInfo rmsDevProgressInfo = new RMSDevProgressInfo();
		
		// 1000개 이상의 아아티팩트가 있는 경우 다시 request 한다.
		while (isNext) {
			++loopindex;
			
			// Request the All Test Items
			//// ex) https://rms.skhynix:9443/rm/publish/resources?viewName=All_TestItems_view&projectURI=_PmnK0J_REeWRnaHpueE2GQ&size=1000&pos=0
			String requestAllTestItemsDoc = rmServer + "/publish/resources?viewName=" + testView + "&projectURI=" + paId + "&size=" + iSize + "&pos=" + iPos;		
			logMGR.info("- requestAllTestItemsDoc="+requestAllTestItemsDoc);
			
			// requestHttpClient 실행
			HttpResponse responseAllTestItems = requestHttpClient(httpClient, requestAllTestItemsDoc);
			
			if (responseAllTestItems.getStatusLine().getStatusCode() == 200) {
				logMGR.info("successful response! \n");
				
				try{
					InputSource inputSource = new InputSource(responseAllTestItems.getEntity().getContent());
					Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inputSource);
					
					// 재수행 여부 체크
					Element element = document.getDocumentElement();
					isNext = element.hasAttribute("rel");
					
					logMGR.debug("loopindex="+loopindex +", isNext="+ isNext);
					
					// 재수행 필요시 pos 값 증가
					if(isNext) iPos = iPos + Integer.parseInt(size);
					
					// 표현식
					String  expression = "/*";
					
					XPath xpath = XPathFactory.newInstance().newXPath();
					NodeList  rootNode = (NodeList) xpath.compile(expression).evaluate(document, XPathConstants.NODESET);
					
					
					if(element.hasAttribute("rrm:totalCount")){
						// 전체 개수 집계
						totalCount = Integer.parseInt(rootNode.item(0).getAttributes().getNamedItem("rrm:totalCount").getTextContent());
						atrifactTotalCount = atrifactTotalCount + totalCount;
										
						// 자식 노드엣 값들을 가져와서 조건에 맞는 아티팩트의 수를 카운트 해야한다.
						NodeList artifacts = (NodeList) rootNode.item(0);

					    int length = artifacts.getLength();
					    
					    logMGR.debug(">> atrifactTotalCount="+atrifactTotalCount +", totalCount="+ totalCount + ", artifacts Length="+ length);
					    
					    
					    // ds:artifact 반복
						for (int i2 = 0; i2 < length; i2++) {
							String title = ""; 
							String id = "";

							boolean isVerified = false;
							
							NodeList artifact = (NodeList) artifacts.item(i2);   //ds:artifact
							
							for (int j = 0; j < artifact.getLength(); j++) {
								//System.out.println("artifactName="+artifact.item(j).getNodeName());
								
								// 1. 제목
								if(artifact.item(j).getNodeName().equals("rrm:title")) {
									title = artifact.item(j).getTextContent();
								}
								// 2. ID
								if(artifact.item(j).getNodeName().equals("rrm:identifier")) {
									id = artifact.item(j).getTextContent();
								}
								
								
								NodeList cols =  (NodeList) artifact.item(j).getChildNodes();
								
								for (int k=0; k < cols.getLength(); k++) {
									// 3. Custom Attribute : Verification 요건
									if (cols.item(k).getNodeName().equals("rrm:attributes")) {
										NodeList attribute = (NodeList) cols.item(k).getChildNodes();
										
										for (int k1=0; k1 < attribute.getLength(); k1++) {
											if (attribute.item(k1).getNodeName().equals("attribute:objectType")) {
												
												NodeList customAttributeNodes = (NodeList) attribute.item(k1).getChildNodes();
												//System.out.println(">> \t\t\t caNodes.getLength()="+ customAttributeNodes.getLength());
												
												for (int l=0; l < customAttributeNodes.getLength(); l++) {
													if(customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:name").getNodeValue().equals("Verified")){
														//System.out.println(">> \t\t\t literal = " + customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName"));
														//System.out.println(customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName").getTextContent());
														
														//테스트아이템 verfied 속성값 정보를 맵에 추가
														testItemIdAndVerfiedValueMap.put(id, customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName").getTextContent());
														
														if(customAttributeNodes.item(l).getAttributes().getNamedItem("attribute:literalName").getTextContent().equals("Y")){
															isVerified = true;
														}
													}
												}
											}
										}
									}
								}
							}
							logMGR.info("["+ loopindex +"]["+ i2 +"] " + title+"(" + id +") : isVerified=" + isVerified);
							
							if(isVerified){
								logMGR.debug("++passedTestCaseCount");
								
								// COUNT
								++passedTestCaseCount;
							}
						}
						
						
						logMGR.debug(">> \t  artifactCount="+ length);
						logMGR.debug(">> \t  totalPassedTCCount="+ passedTestCaseCount);
					// Requst가 처음인 경우 모든 값 0 으로 초기화
					}else if(loopindex == 1){
						rmsDevProgressInfo.setTotalTestCaseCount(atrifactTotalCount);
						rmsDevProgressInfo.setTotalPassedTestCaseCount(passedTestCaseCount);
						
						return rmsDevProgressInfo;
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} catch (SAXException e) {
					e.printStackTrace();
				} catch (ParserConfigurationException e) {
					e.printStackTrace();
				} catch (XPathExpressionException e) {
					e.printStackTrace();
				}
			} else {
				System.out.println("Request failed! \n");
			}
		} // End of while	
		
		logMGR.info("#########################################################");
		logMGR.info("###  TestItemCount="+ atrifactTotalCount);
		logMGR.info("###### - passedTCCount="+ passedTestCaseCount);
		logMGR.info("#########################################################");
		
		rmsDevProgressInfo.setTotalTestCaseCount(atrifactTotalCount);
		rmsDevProgressInfo.setTotalPassedTestCaseCount(passedTestCaseCount);
		rmsDevProgressInfo.setTestItemIdAndVerfiedValueMap(testItemIdAndVerfiedValueMap);

if(testItemIdAndVerfiedValueMap.size() > 0){
	Set key = testItemIdAndVerfiedValueMap.keySet();
	  
	for (Iterator iterator = key.iterator(); iterator.hasNext();) {
		// 프로젝트명
	String keyName = (String) iterator.next();
	// 프로젝트 ID
	String valueName = (String) projectAreaInfoMap.get(keyName);

	logMGR.debug("TEST="+keyName+ ", V " + valueName);
	}
}
		return rmsDevProgressInfo;
	}
	
	
	
	/** 
	 *	requestHttpClient
	 * 
	 * @throws IOException 
	 * @throws InvalidCredentialsException 
	 * 
	*/ 
	protected HttpResponse requestHttpClient(DefaultHttpClient httpClient, String requestDoc){
		logMGR.debug(">> requestHttpClient");
		
		// Setup the HttClient
		HttpUtils.setupLazySSLSupport(httpClient);
		// Setup the request
		HttpGet httpGetRequest = new HttpGet(requestDoc);
		
		// initialize HttpResponse
		HttpResponse httpResponse = null;
		
		logMGR.info("-> Request\n");

		try{
			// Request
			httpResponse = HttpUtils.sendGetForSecureDocument(
					rmServer, httpGetRequest, user, password, httpClient, jtsServer, OAuthToken);
			
			logMGR.info("<- Response : ");
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InvalidCredentialsException e) {
			e.printStackTrace();
		} finally {
			// Shutdown the HTTP connection
			//httpClient.getConnectionManager().shutdown();
			//isConnection = false;
		}
		
		return httpResponse;
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

	
	/** 
	 * Shutdown HttpClient Connection
	 * 
	 */ 
	private void shutdownHttpConnection() {
		// Shutdown the HTTP connection
		if(isConnection) httpClient.getConnectionManager().shutdown();
	}
	
	
	/** 
	 * setRMSProjectMap
	 * 
	 */ 
	private void setRMSProjectMap() {
//		projectAreaInfoMap = RMSProject.getInstance().getRMSProjectMap();
		projectAreaInfoMap = rmsProject.getRMSProjectMap();
		
		logMGR.debug("Project Count="+projectAreaInfoMap.size());
	}
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertyConfigInDev() {
		return new PropertySourcesPlaceholderConfigurer();
	}
}
