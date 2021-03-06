package dashboard.fwq.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;

@Service
public class FwqService {

    @Autowired
    private CommonDao dao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> fwqPoint(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("fwq.allproject.curpoint.list", parameter);
		for(int i=0;i<list.size();i++){
			Map m = (Map)list.get(i);
			Map last = dao.selectOne("fwq.allproject.prepoint.data", m);
			m.put("preData",last);
		}
		
		return list;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<?,?> fwqPointLast(Map<Object, Object> parameter) {
		Map m = (Map)dao.selectOne("fwq.allproject.prepoint.data", parameter);
		return m;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> projectPointHistory(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("fwq.project.point.history", parameter);
		return list;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> detailHistory(Map<Object, Object> parameter) {
		List list = null;
		String category = parameter.get("category").toString();
		switch(category){
			case "COMPLEXITY": 
				list = (List)dao.selectList("fwq.project.point.history.complexity", parameter);
				break;
			case "STATIC_ANALYSIS": 
				list = (List)dao.selectList("fwq.project.point.history.static", parameter);
				break;
			case "FUNCTION_SIZE": 
				list = (List)dao.selectList("fwq.project.point.history.funcSize", parameter);
				break;
			case "DUPLICATE": 
				list = (List)dao.selectList("fwq.project.point.history.duplicate", parameter);
				break;
			case "FUNC_PARAMETER": 
				list = (List)dao.selectList("fwq.project.point.history.funcParam", parameter);
				break;
			case "CODING_RULE": 
				list = (List)dao.selectList("fwq.project.point.history.codingRule", parameter);
				break;
			case "CODE_COVERAGE": 
				list = (List)dao.selectList("fwq.project.point.history.codeCoverage", parameter);
				break;
			case "ARCHITECTURE": 
				list = (List)dao.selectList("fwq.project.point.history.architecture", parameter);
				break;
			default:
				list = (List)dao.selectList("fwq.project.point.history", parameter);
				break;
		}
		
		return list;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> fwqSubProjectList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("fwq.subProject.list", parameter);
		return list;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> subProjectData(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("fwq.pjtcode.project.curpoint.list", parameter);
		return list;
	}
	
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void pjtAccessInsertLog(Map<Object, Object> parameter) throws Exception {
		int cnt = dao.update("fw.quality.pjtAccessInsertLog", parameter);
		
		if(cnt != 1) {
			throw new Exception();
		}
	}
}
