package dashboard.ssd.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import common.dao.RnddasDao;
import common.service.CommonService;

@Service
public class SSDService {

    @Autowired
    private CommonDao comdao;
    
    @Autowired
    private RnddasDao dao;
    
    @Autowired
    private CommonService commonService;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> testModelList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.reliablility.search.model", parameter);
		return list;
	}	
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> testTypeList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.reliablility.search.testtype", parameter);
		return list;
	}	
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> fwversionList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.reliablility.search.fwversion", parameter);
		return list;
	}	
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> capacityList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.reliablility.search.capacity", parameter);
		return list;
	}	
   
    
	/*
	 * @SuppressWarnings({ "rawtypes", "unchecked" }) public List<?>
	 * mainList(Map<Object, Object> parameter) { List models =
	 * commonService.pmsModelListByPjtId(parameter); parameter.put("models",
	 * models); List list = (List)dao.selectList("dashboard.ssd.mainlist",
	 * parameter); return list; }
	 */
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> chartList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.chartlist", parameter);
		return list;
	}	
	
	
	@SuppressWarnings({ "rawtypes", "unchecked", "resource"})
	public String getNewTestId() throws Exception {
		Map m = commonService.selectOne("dashboard.ssd.testinformation.id", null);
		return m.get("NEW_TEST_ID").toString();
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int ssdTestInformationNewIDInsert(Map<Object, Object> parameter) {
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.insert.testid",parameter);
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int ssdTestInformationCancel(Map<Object, Object> parameter) {
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.delete.testid",parameter);
		return cnt;
	}
	
	public int ssdTestInformationInsert(JSONObject jsonObj){
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.update.testinformation",jsonObj);
		return cnt;
	}
	
	public int ssdTestDiskInfoInsert(JSONObject jsonObj){
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.insert.diskinformation",jsonObj);
		return cnt;
	}
	
	public int  ssdTestResultInsert(JSONObject jsonObj){
		
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.insert.testresult",jsonObj);
		return cnt;
		
//		//JSONObject jsonObj = JSONObject.fromObject(contents);
//		for (Object key : jsonObj.keySet()) {
//	        //based on you key types
//	        String keyStr = (String)key;
//	        Object keyvalue = jsonObj.get(keyStr);	        
//	    }
	}
	
	
	//testLog를 제외한 파일정보 update
	public int ssdTestFileInfoUdate(JSONObject jsonObj){
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.update.fileInfos",jsonObj);
		return cnt;
	}
	
	public int ssdTestFileInfoInsert(JSONObject jsonObj){
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.insert.fileInfos",jsonObj);
		return cnt;
	}
	
	public int ssdTestFileLogInfoUdate(JSONObject jsonObj){
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.update.testlog.fileInfos",jsonObj);
		return cnt;
	}
	
	public int ssdTestFileInfoUdateScreen(JSONObject jsonObj){
		int cnt = 0;
		cnt = comdao.update("dashboard.ssd.update.fileInfos.screen",jsonObj);
		return cnt;
	}
	
	
	
}
