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
import common.dao.DevDao;
import common.dao.OperDao;
import common.dao.PmsDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class MigrationService {

	@Autowired
    private DevDao	devDao;
    
    @Autowired
    private OperDao operDao;
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void ssdCustomMigration(Map<Object, Object> parameter) {
		List<Map> list = (List)devDao.selectList("batch.migration.CustomTest.transfer.dev.information", parameter);
		for(Map basic : list){
			//01. update basic information
			operDao.update("batch.migration.CustomTest.transfer.oper.information", basic);
			//02. disk list
			List<Map> disks =  (List)devDao.selectList("batch.migration.CustomTest.transfer.dev.disk", basic);
			//02.1 disk migratikon
			for(Map disk : disks){
				operDao.update("batch.migration.CustomTest.transfer.oper.disk", disk);
			}			
			//03. files list
			List<Map> files =  (List)devDao.selectList("batch.migration.CustomTest.transfer.dev.files", basic);
			//03. files migration
			for(Map file : files){
				operDao.update("batch.migration.CustomTest.transfer.oper.files", file);
			}			
			//04. result list
			List<Map> results =  (List)devDao.selectList("batch.migration.CustomTest.transfer.dev.result", basic);
			//04.01 result migration
			for(Map result : results){
				operDao.update("batch.migration.CustomTest.transfer.oper.result", result);
			}	
			
			devDao.update("batch.migration.CustomTest.transfer.dev.complete", basic);
		}
	}
   
	
	
	
}
