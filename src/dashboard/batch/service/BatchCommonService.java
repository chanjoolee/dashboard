package dashboard.batch.service;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import common.dao.PmsDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class BatchCommonService {

    @Autowired
    private PmsDao pmsdao;
    
    @Autowired
    private CommonDao dashdao;
    
    @SuppressWarnings({ "rawtypes", "unchecked", "resource"})
	public String getNewBatchId() throws Exception {
		Map m = dashdao.selectOne("batch.common.new.batchid", null);
		return m.get("NEW_BATCH_ID").toString();
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public int insertNewBatchId(Map<Object, Object> parameter) {
		int cnt = 0;
		cnt = dashdao.update("batch.common.insert.newbatchid",parameter);
		return cnt;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public int updateBatchResult(Map<Object, Object> parameter) {
		int cnt = 0;
		cnt = dashdao.update("batch.common.update.batch.result",parameter);
		return cnt;
	}
	
	
	
}
