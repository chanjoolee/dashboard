package dashboard.fwq.service;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import common.dao.CommonDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class FwqFunctionParameterService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
	DataSourceTransactionManager transactionManager;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void insertRawData(Map<String, Object> parameter) {
		dao.update("fwq.functionParameter.insert", parameter);
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void insertlist(List<Map<String, Object>> parameter,JSONObject result ) {
    	DefaultTransactionDefinition def = null ;
		TransactionStatus status = null ;
		try{
			def = new DefaultTransactionDefinition();
			def.setName("updateFunctionParameterRaw");
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
			status = transactionManager.getTransaction(def);
			if(parameter.size()> 0)
				dao.update("fwq.functionParameter.delete.project.measureDt", parameter.get(0));
			for(Map<String,Object> m : parameter){
	    		dao.update("fwq.functionParameter.insert", m);
	    	}
			transactionManager.commit(status);
			result.put("result", "success");
		}catch (Exception ex){
			transactionManager.rollback(status);
			result.put("result", "fail: " + ex.getMessage());
		}
    	
		
	}
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("fwq.functionParameter.selectList", parameter);
		return list;
	}
    
    
	
}
