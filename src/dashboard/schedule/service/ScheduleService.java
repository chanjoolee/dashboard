package dashboard.schedule.service;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import common.dao.PmsDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class ScheduleService {

    @Autowired
    private PmsDao dao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getDataPhase(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.schedule.dataphase", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getDataPhaseCount(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.schedule.dataphase.count", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getDataPhaseRevisionCount(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.schedule.dataphase.revision.count", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getDataList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.schedule.datalist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getRevisions(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.schedule.revisions", parameter);
		return list;
	}
	
}
