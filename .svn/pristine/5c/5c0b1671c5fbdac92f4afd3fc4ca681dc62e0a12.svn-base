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
public class FwqCodingRuleService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
	DataSourceTransactionManager transactionManager;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("fwq.codingRule.raw", parameter);
		return list;
	}
    
    
	
}
