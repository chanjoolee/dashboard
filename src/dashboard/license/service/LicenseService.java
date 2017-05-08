package dashboard.license.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;

@Service
public class LicenseService {

    @Autowired
    private CommonDao dao;
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectIarLicenseUseList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("license.selectIarLicenseUseList", parameter);
		return list;
	}	
}
