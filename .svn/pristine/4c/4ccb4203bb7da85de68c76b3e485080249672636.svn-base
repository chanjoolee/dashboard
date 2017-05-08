package dashboard.rms.service;

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
public class RmsService {

    @Autowired
    private CommonDao dao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> rms(Map<Object, Object> parameter) {
    	List list = (List)dao.selectList("dashboard.rms.datalist", parameter);
		return list;
	}
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> rmsVirtual(Map<Object, Object> parameter) {
    	List list = (List)dao.selectList("dashboard.rms.datalist.virtual", parameter);
		return list;
	}
    
   
	
}
