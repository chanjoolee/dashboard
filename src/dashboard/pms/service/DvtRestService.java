package dashboard.pms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.PmsDao;

@Service
public class DvtRestService {
	
	@Autowired
    private PmsDao pmsDao;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectFwVersionList(Map<Object, Object> parameter) {
		return (List)pmsDao.selectList("pmsDvtRest.selectFwVersionList", parameter);
	}	
}