package dashboard.bamboo.service;

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
public class BambooTestService {

    @Autowired
    private CommonDao dao;
    
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> bambooTestProject(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.bamboo.status.all", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> bambooTestClassName(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.bamboo.status.all.classname", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> bambooTestClassNameTime(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.bamboo.status.all.classname.timeline", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> bambooTestClassNameTimeList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.bamboo.status.all.classname.timeline.list", parameter);
		return list;
	}
	
}
