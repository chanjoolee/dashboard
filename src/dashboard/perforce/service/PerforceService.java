package dashboard.perforce.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import common.dao.PmsDao;

@Service
public class PerforceService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsdao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }  
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> perforceHmsListForGraphUser(Map<Object, Object> parameter) {
		List list = (List)pmsdao.selectList("perforce.hms.list.for.graph.user", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> perforceHmsListForGraphBlock(Map<Object, Object> parameter) {
		List list = (List)pmsdao.selectList("perforce.hms.list.for.graph.block", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> perforceHmsListForGraphActivity(Map<Object, Object> parameter) {
		List list = (List)pmsdao.selectList("perforce.hms.list.for.graph.activity", parameter);
		return list;
	}
	
}
