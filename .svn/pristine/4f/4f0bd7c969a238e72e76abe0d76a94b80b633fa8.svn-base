package dashboard.systemUsage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.PmsDao;

@Service
public class SystemUsageService {

    @Autowired
    //private CommonDao dao;
    private PmsDao pmsDao;
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectSystemUsageSummaryList(Map<Object, Object> parameter) {
    	
    	Map useMonthMap = (Map)pmsDao.selectOne("systemUsage.selectSystemUsageDefaultMonth", parameter);
    	parameter.put("fromUseMonth", useMonthMap.get("FROM_USE_MONTH"));
    	parameter.put("toUseMonth", useMonthMap.get("TO_USE_MONTH"));
    	
		return (List)pmsDao.selectList("systemUsage.selectSystemUsageSummaryList", parameter);
	}
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectSystemUsageList(Map<Object, Object> parameter) {
		return (List)pmsDao.selectList("systemUsage.selectSystemUsageList", parameter);
	}	
}
