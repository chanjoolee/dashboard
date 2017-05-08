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
public class CodesonarMappingUpdateService {

	@Autowired
    private PmsDao pmsdao;
    
    @Autowired
    private CommonDao dashdao;
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void batchJob(Map<Object, Object> parameter) {
		List list = getList(parameter);
		update(list);		
	}
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private List<?> getList(Map<Object, Object> parameter) {
		List list = (List)pmsdao.selectList("batch.pjtname.select", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private void update(List<Map> list) {
		for(Map m :list){
			dashdao.update("batch.pjtname.update", m);
		}		
	}
	
	
	
}
