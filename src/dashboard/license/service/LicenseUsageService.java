package dashboard.license.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.PmsDao;

@Service
public class LicenseUsageService {

    @Autowired
    private PmsDao dao;
    
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> licenseUsage(Map<Object, Object> parameter) {
		
		
		List list = (List)dao.selectList("license.selectLicenseUsageList.smonth.all", parameter);
		return list;
	}
	
	public List<?> licenseUseMonthTable(Map<Object, Object> parameter) {
		
		
		List list = (List)dao.selectList("license.selectLicenseUsageList.smonth.table", parameter);
		return list;
	}
	
	public List<?> licenseUsagePop(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("license.selectLicenseUsageList.sdate.all", parameter);
		return list;
	}
	
	public List<?> licenseUseDateList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("license.selectLicenseUsageList.sdate.list", parameter);
		return list;
	}
	
	public List<?> licenseUseDateTable(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("license.selectLicenseUsageList.sdate.table", parameter);
		return list;
	}
	
}
