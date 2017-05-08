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
import common.dao.PmsDao;
import common.dao.RnddasDao;
import common.service.CommonService;

@Service
public class SSDCusService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsDao;
    
    @Autowired
    private CommonService commonService;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> mainList(Map<Object, Object> parameter) {
		List models = commonService.pmsModelListByPjtId(parameter);
		parameter.put("models", models);
		List list = (List)dao.selectList("dashboard.ssd.custom.mainlist", parameter);
		for(int i=0;i<list.size();i++){
			Map m = (Map)list.get(i);
			m.put("TESTER_NAME_KO",m.get("TESTER_NAME"));
			if(m.get("TESTER_NAME") != null){
				m.put("empId", m.get("TESTER_NAME"));
				Map user = (Map)pmsDao.selectOne("common.username.byEmpId", m);
				if(user != null && user.get("USER_NAME") != null){
					m.put("TESTER_NAME_KO",  user.get("USER_NAME"));
				}
			}
			
		}
		return list;
	}	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String,Object> mainListPage(Map<Object, Object> parameter) {
		List models = commonService.pmsModelListByPjtId(parameter);
		parameter.put("models", models);
		Map map = (Map)dao.selectOne("dashboard.ssd.custom.mainlist.page", parameter);
		return map;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> mainListAll(Map<Object, Object> parameter) {
		// paging이 아닌 all data
		List list = (List)dao.selectList("dashboard.ssd.custom.mainlist.all", parameter);
		
		return list;
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String,Object> testInformation(Map<Object, Object> parameter) {
		Map map = (Map)dao.selectOne("dashboard.ssd.custom.testInformation", parameter);
		map.put("TESTER_NAME_KO",map.get("TESTER_NAME"));
		if(map.get("TESTER_NAME") != null){
			map.put("empId", map.get("TESTER_NAME"));
			Map user = (Map)pmsDao.selectOne("common.username.byEmpId", map);
			if(user != null && user.get("USER_NAME") != null){
				map.put("TESTER_NAME_KO",  user.get("USER_NAME"));
			}
		}
		return map;
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> testDisk(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.custom.testDisk", parameter);
		return list;
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> testResult(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.custom.testResult", parameter);
		return list;
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> testFiles(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.custom.attachments", parameter);
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
		cnt = dao.update("dashboard.ssd.insert.testid",parameter);
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int ssdTestInformationCancel(Map<Object, Object> parameter) {
		int cnt = 0;
		cnt = dao.update("dashboard.ssd.delete.testid",parameter);
		return cnt;
	}
	
	public int ssdTestInformationInsert(JSONObject jsonObj){
		int cnt = 0;
		cnt = dao.update("dashboard.ssd.update.testinformation",jsonObj);
		return cnt;
	}
	
	public int ssdTestDiskInfoInsert(JSONObject jsonObj){
		int cnt = 0;
		cnt = dao.update("dashboard.ssd.insert.diskinformation",jsonObj);
		return cnt;
	}
	
	public int  ssdTestResultInsert(JSONObject jsonObj){
		
		int cnt = 0;
		cnt = dao.update("dashboard.ssd.insert.testresult",jsonObj);
		return cnt;
		
//		//JSONObject jsonObj = JSONObject.fromObject(contents);
//		for (Object key : jsonObj.keySet()) {
//	        //based on you key types
//	        String keyStr = (String)key;
//	        Object keyvalue = jsonObj.get(keyStr);	        
//	    }
	}
	
	public int ssdTestFileInfoDelete(JSONObject jsonObj){
		int cnt = 0;
		cnt = dao.update("dashboard.ssd.custom.file.delete",jsonObj);
		return cnt;
	}
	
	
	//testLog를 제외한 파일정보 update
	public int ssdTestFileInfoUdate(JSONObject jsonObj){
		int cnt = 0;
		cnt = dao.update("dashboard.ssd.update.fileInfos",jsonObj);
		return cnt;
	}
	
	public int ssdTestFileLogInfoUdate(JSONObject jsonObj){
		int cnt = 0;
		cnt = dao.update("dashboard.ssd.update.testlog.fileInfos",jsonObj);
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void updateResultData(Map<Object, Object> parameter) {
		dao.update("dashboard.ssd.custom.update.testresult", parameter);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void insertResultData(Map<Object, Object> parameter) {
		dao.update("dashboard.ssd.custom.insert.testresult", parameter);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void deleteResultData(Map<Object, Object> parameter) {
		dao.update("dashboard.ssd.custom.delete.testresult", parameter);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void savedummy(Map<Object, Object> parameter) {
		dao.update("dashboard.ssd.update.dummy", parameter);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> ssdCusDistinctField(Map<Object, Object> parameter) {
		// paging이 아닌 all data
		List list = (List)dao.selectList("dashboard.ssd.custom.field.distinct", parameter);
		
		return list;
	}	
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> testComment(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.ssd.custom.testComment", parameter);
		
		//사용자 명 검색
		for(int i=0;i<list.size();i++){
			Map m = (Map)list.get(i);
			
			if(m.get("USER_ID") != null){
				m.put("userId",m.get("USER_ID"));
				Map user = (Map)pmsDao.selectOne("common.username.byUserId", m);
				if(user != null && user.get("USER_NAME") != null){
					m.put("USER_NAME",  user.get("USER_NAME"));
				}
			}
			
		}
		return list;
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void updateCommentData(Map<Object, Object> parameter) {
		dao.update("dashboard.ssd.custom.update.testcomment", parameter);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void insertCommentData(Map<Object, Object> parameter) {
		dao.update("dashboard.ssd.custom.insert.testcomment", parameter);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void deleteCommentData(Map<Object, Object> parameter) {
		dao.update("dashboard.ssd.custom.delete.testcomment", parameter);
	}
	
	
}
