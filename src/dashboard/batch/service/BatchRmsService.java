package dashboard.batch.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skhynix.rms.rest.consumer.RMSDevProgress;
import com.skhynix.rms.rest.consumer.RMSDevProgressInfo;

import common.dao.CommonDao;

@Service
public class BatchRmsService {
    
    @Autowired
    private CommonDao dashdao;
    
    @Autowired
    private RMSDevProgress rmsProgress;

    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void insertRms(HttpServletRequest request) throws Exception {
		
    	//1. RMS Summary Insert
    	//Map<String, RMSDevProgressInfo> allProjectInfoMap = RMSDevProgress.getInstance().getAllProjectInfoForDevProgress();
    	Map<String, RMSDevProgressInfo> allProjectInfoMap = rmsProgress.getAllProjectInfoForDevProgress();
    	Set key = allProjectInfoMap.keySet();
    	
    	List rmsList = new ArrayList();
    	HashMap<Object,Object> pjtMap = null;
    	
		for(Iterator iterator = key.iterator(); iterator.hasNext();) {
			
			String pjtName = (String)iterator.next();
			String pjtCode = pjtName.replace("#", "").replace(" ", "");//PJT_CODE -> 임시.... 추후 mapping 필요...

			RMSDevProgressInfo progressInfo = allProjectInfoMap.get(pjtName);
			
			pjtMap = new HashMap<Object, Object>();
			pjtMap.put("pjtCode", pjtCode);
			pjtMap.put("pjtName", pjtName);
			pjtMap.put("category", "Req. Count");
			pjtMap.put("count", progressInfo.getTotalRequirementCount());
			rmsList.add(pjtMap);
			
			pjtMap = new HashMap<Object, Object>();
			pjtMap.put("pjtCode", pjtCode);
			pjtMap.put("pjtName", pjtName);
			pjtMap.put("category", "Implemented");
			pjtMap.put("count", progressInfo.getTotalImplementedRequirementCount());
			rmsList.add(pjtMap);
			
			pjtMap = new HashMap<Object, Object>();
			pjtMap.put("pjtCode", pjtCode);
			pjtMap.put("pjtName", pjtName);
			pjtMap.put("category", "Test Coverage");
			pjtMap.put("count", progressInfo.getTotalTestCaseCount());
			rmsList.add(pjtMap);
			
			pjtMap = new HashMap<Object, Object>();
			pjtMap.put("pjtCode", pjtCode);
			pjtMap.put("pjtName", pjtName);
			pjtMap.put("category", "Verified");
			pjtMap.put("count", progressInfo.getTotalVerifiedRequirementCount());
			rmsList.add(pjtMap);
		}

		dashdao.update("batch.rms.rmsChart.delete.today", pjtMap);
		int cnt = 0;
		for(int i=0; i<rmsList.size(); i++) {
			
			pjtMap = (HashMap)rmsList.get(i);
			
			cnt = dashdao.update("batch.rms.rmsChart.insert", pjtMap);
			
			if(cnt != 1) {
				throw new Exception();
			}
		}
		
		//2. RMS Detail Insert... 추후 Row Data 필요시....
	}	
}