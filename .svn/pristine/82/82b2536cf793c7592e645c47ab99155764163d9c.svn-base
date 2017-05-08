package dashboard.batch.service;

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
public class ScheduleUpdateService {

    @Autowired
    private PmsDao pmsdao;
    
    @Autowired
    private CommonDao dashdao;
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void batchMappingSchedulePmsWithDashboard(Map<Object, Object> parameter) {
		List list = getPmsSchedule(parameter);
		updateDashboardSchedule(list);		
	}
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private List<?> getPmsSchedule(Map<Object, Object> parameter) {
		List list = (List)pmsdao.selectList("batch.pmsSchedule.select", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private void updateDashboardSchedule(List<Map> list) {
		for(Map m :list){
			if(m.get("PLAN_START_DT") == null) 
				m.put("PLAN_START_DT","");
			if(m.get("PLAN_END_DT") == null) 
				m.put("PLAN_END_DT","");
			if(m.get("ACTUAL_START_DT") == null) 
				m.put("ACTUAL_START_DT","");
			if(m.get("ACTUAL_END_DT") == null) 
				m.put("ACTUAL_END_DT","");
			dashdao.update("batch.dashbaordSchedule.update", m);
		}		
	}
	
	
	
}
