package dashboard.performance.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import common.service.CommonService;

@Service
public class PerformanceService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private CommonService commonService;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> dataList(Map<Object, Object> parameter) {
		List list;
		if(parameter.get("sqlid") != null){
			list = (List)dao.selectList(parameter.get("sqlid").toString(), parameter);
		}else{
			list = (List)dao.selectList("dashboard.preformance.datalist", parameter);
		}
		return list;
	}	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> tabList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.preformance.tablist", parameter);
		return list;
	}	
	
	/*
	 * @SuppressWarnings({ "rawtypes", "unchecked" }) public List<?>
	 * folderList(Map<Object, Object> parameter) {
	 * 
	 * List models = commonService.pmsModelListByPjtId(parameter);
	 * parameter.put("models", models); List list =
	 * (List)dao.selectList("dashboard.preformance.folderlist", parameter); return
	 * list; }
	 */
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void saveGoodData(Map<Object, Object> parameter) {
		dao.update("dashboard.preformance.save.isGoddData", parameter);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> ssdDistinctField(Map<Object, Object> parameter) {
		// paging이 아닌 all data
		List list = (List)dao.selectList("dashboard.preformance.field.distinct", parameter);
		
		return list;
	}	
	
	
}
