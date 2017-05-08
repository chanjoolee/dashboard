package com.skhynix.rms.rest.consumer;

import java.util.List;
import java.util.Map;

public class RMSDevProgressInfo {
	
	//전체 SW Requirement 아티팩스 개수(Implementation, TestCoverage 요건)
	private int totalRequirementCount;
	//전체 Implementation 상태의 아티팩트 개수(Implementation 요건)
	private int totalImplementedRequirementCount;
	//전체 Verified By 링크가 존재하는 아티팩트 개수(TestCoverage 요건) 
	private int totalExistsVerifiedByLinkRequirementCount;
	//전체 Test Item 아티팩트 개수(Verification 요건) 
	private int totalTestCaseCount;
	//전체 패스된 Test Item 아티팩트 개수(Verification 요건) 
	private int totalPassedTestCaseCount;
	//전체 Verified Requirement 아티팩트 개수(Verification 요건)
	private int totalVerifiedRequirementCount;
	//요구사항 아티팩트의 ID 및 'Verified By' 링크가 걸린 테스트아이템 ID 리스트를 담을 맵(요구사항ID, 테스트아이템ID,테스트아이템ID1,...)
	private Map<String, List> requirementIdAndVerifiedByLinkTestItemIdMap;
	//테스트아이템 아티팩트의 ID 및 'Verified' 속성값 정보를 담을 맵(테스트아이템ID, 'Y' OR 'N')
	private Map<String, String> testItemIdAndVerfiedValueMap;
	
	
	private static RMSDevProgressInfo instance;
	
	public RMSDevProgressInfo(){
		
	}
	
	public static RMSDevProgressInfo getInstance(){
		if(instance == null) instance = new RMSDevProgressInfo();
		return instance;
	}
	
	
	/**
	 *   Getter/Setter 
	 */
	public int getTotalRequirementCount() {
		return totalRequirementCount;
	}

	public void setTotalRequirementCount(int totalRequirementCount) {
		this.totalRequirementCount = totalRequirementCount;
	}

	public int getTotalImplementedRequirementCount() {
		return totalImplementedRequirementCount;
	}

	public void setTotalImplementedRequirementCount(int totalImplementedRequirementCount) {
		this.totalImplementedRequirementCount = totalImplementedRequirementCount;
	}

	public int getTotalExistsVerifiedByLinkRequirementCount() {
		return totalExistsVerifiedByLinkRequirementCount;
	}

	public void setTotalExistsVerifiedByLinkRequirementCount(int totalExistsVerifiedByLinkRequirementCount) {
		this.totalExistsVerifiedByLinkRequirementCount = totalExistsVerifiedByLinkRequirementCount;
	}

	public int getTotalTestCaseCount() {
		return totalTestCaseCount;
	}

	public void setTotalTestCaseCount(int totalTestCaseCount) {
		this.totalTestCaseCount = totalTestCaseCount;
	}

	public int getTotalPassedTestCaseCount() {
		return totalPassedTestCaseCount;
	}

	public void setTotalPassedTestCaseCount(int totalPassedTestCaseCount) {
		this.totalPassedTestCaseCount = totalPassedTestCaseCount;
	}
	
	public int getTotalVerifiedRequirementCount() {
		return totalVerifiedRequirementCount;
	}
	
	public void setTotalVerifiedRequirementCount(int totalVerifiedRequirementCount) {
		this.totalVerifiedRequirementCount = totalVerifiedRequirementCount;
	}


	public Map<String, List> getRequirementIdAndVerifiedByLinkTestItemIdMap() {
		return requirementIdAndVerifiedByLinkTestItemIdMap;
	}

	public void setRequirementIdAndVerifiedByLinkTestItemIdMap(Map<String, List> requirementIdAndVerifiedByLinkTestItemIdMap) {
		this.requirementIdAndVerifiedByLinkTestItemIdMap = requirementIdAndVerifiedByLinkTestItemIdMap;
	}

	public Map<String, String> getTestItemIdAndVerfiedValueMap() {
		return testItemIdAndVerfiedValueMap;
	}

	public void setTestItemIdAndVerfiedValueMap(Map<String, String> testItemIdAndVerfiedValueMap) {
		this.testItemIdAndVerfiedValueMap = testItemIdAndVerfiedValueMap;
	}
	
}
