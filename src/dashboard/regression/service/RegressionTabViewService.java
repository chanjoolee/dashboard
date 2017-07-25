package dashboard.regression.service;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class RegressionTabViewService {

    @Autowired
    private CommonDao dao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> folderList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.folderlist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> folderMeta(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.foldermeta", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> smartList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.smartlist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> hostList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.hostlist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pecountList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.pecountlist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> errorlogList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.errologlist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> mainList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.mainlist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> commonList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList(parameter.get("sqlid").toString(), parameter);
		return list;
	}
	
	
}
