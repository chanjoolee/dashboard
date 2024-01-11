package dashboard.socdesign.service;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//import sun.misc.BASE64Encoder;
import java.util.Base64;
import common.dao.CommonDao;
import common.dao.PmsDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class SocDesignService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsDao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getCsvUrlList(Map<Object, Object> parameter) throws Exception {
		List spacelist = (List)pmsDao.selectList("dashboard.socdesign.confluence.spaceKey", parameter);
		List attach = new ArrayList();
		
		for(int i=0;i<spacelist.size();i++){
			Map m = (Map)spacelist.get(i);
			// 01. space key
			JSONObject space = getConfluenceSpace(m);
			if((int)space.get("size") > 0){
				space.put("pjt_id",m.get("PJT_ID"));
				space.put("pjt_name",m.get("PJT_NAME"));
				space.put("interface_id",m.get("INTERFACE_ID"));
				// 02. attachfile list			
				getConfluenceAttachMent(attach,space);
			}
		}
		
		return attach;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getCsvUrlListTest(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dashboard.socdesign.csvurl", parameter);
		
		for(Object o : list){
			Map m = (Map)o;
			m.put("download",m.get("CSV_URL"));
		}
		
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public void getConfluenceAttachMent(@SuppressWarnings("rawtypes") List list,JSONObject space) throws Exception {
		
		String strUser="conf.dashboard:conf.dashboard";
		//BASE64Encoder base64Encoder = new BASE64Encoder();
		//String base64User = base64Encoder.encode(strUser.getBytes());
		String base64User = Base64.getEncoder().encodeToString(strUser.getBytes());
		
		JSONArray pageResults = space.getJSONArray("results");
		for(Object page :pageResults){
			JSONObject p = (JSONObject)page;
			
			String pageId = p.getString("id");
			String strUrl="http://confluence.skhynix.com/rest/api/content/"+pageId+"/child/attachment";
			URL url = new URL(strUrl);
			java.net.HttpURLConnection con = (HttpURLConnection) url.openConnection();
			
			con.setRequestProperty("Authorization", "Basic "+base64User); 
		    con.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
			
	        InputStream ins = con.getInputStream();
	        InputStreamReader isr = new InputStreamReader(ins, "EUC-KR");
	    	
		    BufferedReader br = new BufferedReader(isr); 
		    String line = null;
		    StringBuilder sb = new StringBuilder(1024); 
		
		    while ((line=br.readLine()) != null){ 
		    	sb.append(line); 
		    }
			br.close();
			
			JSONObject attachObject = (JSONObject)JSONSerializer.toJSON(sb.toString());
			
			for(Object attach :attachObject.getJSONArray("results")){
				JSONObject att = (JSONObject)attach;
				JSONObject _links = att.getJSONObject("_links");//.getJSONObject("download");
				if(_links != null){	
					_links.put("pjt_id", space.get("pjt_id"));
					_links.put("pjt_name", space.get("pjt_name"));
					_links.put("interface_id", space.get("interface_id"));
					list.add(_links);
					//한개만 적용한다.
					break;
				}
				
			}
		}
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public JSONObject getConfluenceSpace(Map<Object, Object> parameter) throws Exception {
		
//		String strUser="chanjoo2.lee:chanjoo2.lee";
		String strUser="conf.dashboard:conf.dashboard";
		//BASE64Encoder base64Encoder = new BASE64Encoder();
		//String base64User = base64Encoder.encode(strUser.getBytes());
		String base64User = Base64.getEncoder().encodeToString(strUser.getBytes());
		
		String spaceKey = parameter.get("INTERFACE_ID").toString();
		String title = "DV+(Dashboard)";
		String strUrl="http://confluence.skhynix.com/rest/api/content?spaceKey="+spaceKey+"&title="+title;
//		String strUrl="http://confluence.skhynix.com/rest/api/content?title="+title;
//		String strUrl="http://confluence.skhynix.com/rest/api/content?spaceKey="+spaceKey ;
		URL url = new URL(strUrl);
		java.net.HttpURLConnection con = (HttpURLConnection) url.openConnection();
		
		con.setRequestProperty("Authorization", "Basic "+base64User); 
	    con.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
		
        InputStream ins = con.getInputStream();
        InputStreamReader isr = new InputStreamReader(ins, "EUC-KR");
    	
	    BufferedReader br = new BufferedReader(isr); 
	    String line = null;
	    StringBuilder sb = new StringBuilder(1024); 
	
	    while ((line=br.readLine()) != null){ 
	    	sb.append(line); 
	    }
		br.close();
		
		JSONObject resultObj = (JSONObject)JSONSerializer.toJSON(sb.toString());
		
		return resultObj;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int saveCsv(List<Map<String,Object>> upload) {
		int cnt = 0;
		
		for(int i=0;i<upload.size();i++){
			Map<String,Object> m = upload.get(i);
			String table = m.get("table").toString();
			if(table.equals("SOC_DESIGN_CHECKLIST"))
				cnt += dao.update("dashboard.socdesign.csvsave.checklist", m);
			if(table.equals("SOC_DESIGN_SUMMARY"))
				cnt += dao.update("dashboard.socdesign.csvsave.summary", m);
		}
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int saveNew(List<Map<String,Object>> upload) {
		int cnt = 0;
		dao.update("dashboard.socdesign.deleteall.new.history",null);
		for(int i=0;i<upload.size();i++){
			Map<String,Object> m = upload.get(i);
			String table = m.get("table").toString();
			if(table.equals("SOC_DESIGN_NEW_HISTORY"))
				cnt += dao.update("dashboard.socdesign.save.new.history", m);
		}
		
		//detail delete
		List maxStartDts = (List)dao.selectList("dashboard.socdesign.new.maxStartDt", new HashMap());
		for(int i=0;i<maxStartDts.size();i++){
			Map m = (Map)maxStartDts.get(i);
			cnt += dao.update("dashboard.socdesign.delete.new.history.detail", m);
		}
		
		//detail insert
		dao.update("dashboard.socdesign.new.detail.islast.n",null);
		for(int i=0;i<upload.size();i++){
			Map<String,Object> m = upload.get(i);
			String table = m.get("table").toString();
			if(table.equals("SOC_DESIGN_NEW_HISTORY_DETAIL"))
				cnt += dao.update("dashboard.socdesign.save.new.history.detail", m);
		}
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int deleteAll() {
		int cnt = 0;
		cnt = dao.update("dashboard.socdesign.deleteall",null);
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int insertNewBatchId(Map<Object, Object> parameter) {
		int cnt = 0;
		cnt = dao.update("dashboard.socdesign.insert.newbatchid",parameter);
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int updateBatchResult(Map<Object, Object> parameter) {
		int cnt = 0;
		cnt = dao.update("dashboard.socdesign.update.batch.result",parameter);
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked", "resource"})
	public void parseXlsx(Map<Object, Object> parameter) throws Exception {
		
		//JSONArray urlList = (JSONArray) JSONSerializer.toJSON( parameter.get("urlList") );
		List urlList = (List)parameter.get("urlList");
		List<Map<String,Object>> upload = new ArrayList<Map<String,Object>>();
		
		deleteAll();
		
		for(int i=0;i<urlList.size();i++){
			Map url = (Map)urlList.get(i);
        	String httpsURL = "http://confluence.skhynix.com" +  url.get("download").toString() ;
//        	String httpsURL = url.get("download").toString() ;
            URL myurl = new URL(httpsURL);
            
            java.net.HttpURLConnection con = (HttpURLConnection) myurl.openConnection();
            String strUser="conf.dashboard:conf.dashboard";
    		//BASE64Encoder base64Encoder = new BASE64Encoder();
    		//String base64User = base64Encoder.encode(strUser.getBytes());
            String base64User = Base64.getEncoder().encodeToString(strUser.getBytes());
            con.setRequestProperty("Authorization", "Basic "+base64User); 
		    con.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            InputStream ins = con.getInputStream();
            
            XSSFWorkbook workbook=new XSSFWorkbook(ins);
            
            String batchId = parameter.get("batchId").toString();
            String project = url.get("interface_id").toString();
            String revision = "1";
//            try{
	            //***  Start  Statistic_Table ******//
	            parseXlsxStaticTable(batchId,project,revision,upload, httpsURL, workbook);
	            
	            //***  End Statistic_Table ******//
	            parseXlsxSummary(batchId,project,revision,upload, httpsURL, workbook);
//            }catch(Exception ex){
//            	parameter.put("batchResult","FAIL");
//            	parameter.put("message",ex.getMessage());
//        		updateBatchResult(parameter);
//            }
		}
		
		saveCsv(upload);
	}
	
	/**
	 * 새로운 스펙적용.
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", "resource"})
	public void parseXlsxNew(Map<Object, Object> parameter) throws Exception {
		
		//JSONArray urlList = (JSONArray) JSONSerializer.toJSON( parameter.get("urlList") );
		List urlList = (List)parameter.get("urlList");
		List<Map<String,Object>> upload = new ArrayList<Map<String,Object>>();
		
		
//		임시로 주석처리		
//		for(int i=0;i<urlList.size();i++){
//			Map url = (Map)urlList.get(i);
//        	String httpsURL = "http://confluence.skhynix.com" +  url.get("download").toString() ;
////        	String httpsURL = url.get("download").toString() ;
//            URL myurl = new URL(httpsURL);
//            
//            java.net.HttpURLConnection con = (HttpURLConnection) myurl.openConnection();
//            String strUser="conf.dashboard:conf.dashboard";
//    		BASE64Encoder base64Encoder = new BASE64Encoder();
//    		String base64User = base64Encoder.encode(strUser.getBytes());
//            con.setRequestProperty("Authorization", "Basic "+base64User); 
//		    con.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
//            InputStream ins = con.getInputStream();
//            
//            XSSFWorkbook workbook=new XSSFWorkbook(ins);
//            
//            String batchId = parameter.get("batchId").toString();
//            String project = url.get("interface_id").toString();
//            String revision = "1";
////            try{
//	            //***  Start  Statistic_Table ******//
//	            parseXlsxStaticTable(batchId,project,revision,upload, httpsURL, workbook);
//	            
//	            //***  End Statistic_Table ******//
//	            parseXlsxSummary(batchId,project,revision,upload, httpsURL, workbook);
////            }catch(Exception ex){
////            	parameter.put("batchResult","FAIL");
////            	parameter.put("message",ex.getMessage());
////        		updateBatchResult(parameter);
////            }
//		}
		
		//임시로 처리함.
		//String httpsURL = "http://confluence.skhynix.com/download/attachments/106676377/00_Columbus_Validation_Check_List_Summary_v1.xlsx?version=53&modificationDate=1460006389000&api=v2" ;
		String httpsURL = "http://confluence.skhynix.com/download/attachments/106676377/00_Columbus_Validation_Check_List_Summary_v1.xlsx" ;
		URL myurl = new URL(httpsURL);
		java.net.HttpURLConnection con = (HttpURLConnection) myurl.openConnection();
        String strUser="conf.dashboard:conf.dashboard";
		//BASE64Encoder base64Encoder = new BASE64Encoder();
		//String base64User = base64Encoder.encode(strUser.getBytes());
        String base64User = Base64.getEncoder().encodeToString(strUser.getBytes());
        con.setRequestProperty("Authorization", "Basic "+base64User); 
	    con.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
        InputStream ins = con.getInputStream();
        
        XSSFWorkbook workbook=new XSSFWorkbook(ins);
        
        String batchId = parameter.get("batchId").toString();
        String project = "COL";
        String revision = "1";
        parseXlsxNewSchedule(batchId,project,revision,upload, httpsURL, workbook);
        parseXlsxNewSummary(batchId,project,revision,upload, httpsURL, workbook);
		//임시로 처리 끝
		saveNew(upload);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked", "resource"})
	public String getNewBatchId() throws Exception {
		Map m = dao.selectOne("dashboard.socdesign.new.batchid", null);
		return m.get("NEW_BATCH_ID").toString();
	}


	private void parseXlsxStaticTable(String batchId,String project,String revision,List<Map<String, Object>> upload,String httpsURL, XSSFWorkbook workbook) throws Exception{
		int rowindex;
		int columnindex;
//		XSSFSheet shTable = workbook.getSheet("Statistic_Table");
		XSSFSheet shTable = workbook.getSheet("Table");
		if(shTable == null){
			throw new Exception("Sheet 명은 \"Table\" 이어야 합니다. "+ project);
		}
		//index 별 정리
		Map<Object,Map<String,Object>> colDef = new HashMap<Object,Map<String,Object>>();
		int shRows = shTable.getPhysicalNumberOfRows();
		XSSFRow rowCategory = shTable.getRow(2);
		for(rowindex=3; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			int cells = row.getPhysicalNumberOfCells();
			
			//컬럼정의
			if(rowindex == 3 ){
				//첫번째컬럼.
				Map<String,Object> m1 = new HashMap<String, Object>();
				m1.put("col","code");
				m1.put("category","");        			
				colDef.put(2,m1);
				
				for(columnindex=3;columnindex <= cells ; columnindex++){
					Map<String,Object> m = new HashMap<String, Object>();
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					int cellCategoryIndex = ((columnindex-3) % 5) == 0 ?columnindex:(columnindex - (columnindex-3)%5);
					XSSFCell cellCategory = rowCategory.getCell(cellCategoryIndex);
					m.put("col",cell.getStringCellValue());
					m.put("category",getCellValue(cellCategory));
					colDef.put(columnindex,m);
		    	}
				
			}else if(rowindex > 3){
				// total이면 break
				XSSFCell cellIndex1 = row.getCell(2);
				if(getCellValue(cellIndex1).equals(""))
					break;
				
				for(columnindex=3;columnindex <= cells ; columnindex++){
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					Map<String,Object> insert = new HashMap<String,Object>();
					
					Map<String,Object> col = colDef.get(columnindex);        
					String category = col.get("category").toString();
					
					insert.put("table","SOC_DESIGN_CHECKLIST");
					insert.put("batchId",batchId);
					insert.put("category1",category);
					insert.put("category2",getCellValue(row.getCell(2)));
					insert.put("code",col.get("col").toString()); 
					insert.put("result",getCellValue(cell));
					insert.put("csv_url",httpsURL);
					insert.put("project",project);
					insert.put("revision",revision);
					if(!category.equals(""))
						upload.add(insert);
		    	}
				
			}
			
			
		}
	}
	
	/**
	 * 새로운 스펙을 위한 파싱
	 * @param batchId
	 * @param project
	 * @param revision
	 * @param upload
	 * @param httpsURL
	 * @param workbook
	 * @throws Exception
	 */
	private void parseXlsxNewSchedule(String batchId,String project,String revision,List<Map<String, Object>> upload,String httpsURL, XSSFWorkbook workbook) throws Exception{
		int rowindex;
		int columnindex;
		org.apache.poi.hssf.util.CellReference cellReference;
		org.apache.poi.hssf.util.AreaReference cellReferences;
		org.apache.poi.hssf.util.CellReference startDtCellReference = new org.apache.poi.hssf.util.CellReference("B10");
		 
		
//		XSSFSheet shTable = workbook.getSheet("Statistic_Table");
		XSSFSheet shTable = workbook.getSheet("30.Schedule&StatusHistory");
		if(shTable == null){
			throw new Exception("Sheet 명은 \"30.Schedule&StatusHistory\" 이어야 합니다. "+ project);
		}
		int shRows = shTable.getPhysicalNumberOfRows();
		
		// Total
		cellReference = new org.apache.poi.hssf.util.CellReference("F7"); 
		for(rowindex=cellReference.getRow() + 3 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cell = row.getCell(cellReference.getCol());
			if(getCellValue(cell).equals(""))
				break;
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("start_dt",getDtValue(startDtCell));
			insert.put("actual_target","actual");
			insert.put("category","Total");
			insert.put("parent_category","-");
			insert.put("field","progress");
			insert.put("measure",getCellValue(cell));
			
			upload.add(insert);
		}
		
		// Discrete Pkg
		cellReference = new org.apache.poi.hssf.util.CellReference("S8"); 
		for(rowindex=cellReference.getRow() + 2 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cell = row.getCell(cellReference.getCol());
			if(getCellValue(cell).equals(""))
				break;
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("start_dt",getDtValue(startDtCell));
			insert.put("actual_target","actual");
			insert.put("category","Discrete");
			insert.put("parent_category","-");
			insert.put("field","progress");
			insert.put("measure",getCellValue(cell));
			upload.add(insert);
		}
		
		// Discrete Pkg  sub data
		cellReferences = new org.apache.poi.hssf.util.AreaReference("I9:L9");
		for(rowindex=cellReferences.getFirstCell().getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			XSSFCell firstCell = row.getCell(cellReferences.getFirstCell().getCol());
			
			if(getCellValue(firstCell).equals(""))
				break;
			
			for(columnindex=cellReferences.getFirstCell().getCol();columnindex <= cellReferences.getLastCell().getCol() ; columnindex++){
				Map<String,Object> insert = new HashMap<String,Object>();
				XSSFCell cell = row.getCell(columnindex);
				insert.put("table","SOC_DESIGN_NEW_HISTORY");
				insert.put("batchId",batchId);
				insert.put("project",project);
				insert.put("start_dt",getDtValue(startDtCell));
				insert.put("actual_target","actual");
				insert.put("category","Blind");
				insert.put("parent_category","Discrete");
				org.apache.poi.ss.util.CellReference cellref = cellReferences.getAllReferencedCells()[columnindex - cellReferences.getFirstCell().getCol()];
				String field = getCellValue(shTable.getRow(cellref.getRow()).getCell(cellref.getCol()));
				if(field.equals("Prog."))
					field = "progress";
				insert.put("field",field);
				insert.put("measure",getCellValue(cell));
				upload.add(insert);
			}
			
			
		}
		cellReferences = new org.apache.poi.hssf.util.AreaReference("N9:Q9");
		for(rowindex=cellReferences.getFirstCell().getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			XSSFCell firstCell = row.getCell(cellReferences.getFirstCell().getCol());
			
			if(getCellValue(firstCell).equals(""))
				break;
			
			for(columnindex=cellReferences.getFirstCell().getCol();columnindex <= cellReferences.getLastCell().getCol() ; columnindex++){
				Map<String,Object> insert = new HashMap<String,Object>();
				XSSFCell cell = row.getCell(columnindex);
				insert.put("table","SOC_DESIGN_NEW_HISTORY");
				insert.put("batchId",batchId);
				insert.put("project",project);
				insert.put("start_dt",getDtValue(startDtCell));
				insert.put("actual_target","actual");
				insert.put("category","Trimmed/Tested");
				insert.put("parent_category","Discrete");
				org.apache.poi.ss.util.CellReference cellref = cellReferences.getAllReferencedCells()[columnindex - cellReferences.getFirstCell().getCol()];
				String field = getCellValue(shTable.getRow(cellref.getRow()).getCell(cellref.getCol()));
				if(field.equals("Prog."))
					field = "progress";
				insert.put("field",field);
				insert.put("measure",getCellValue(cell));
				upload.add(insert);
			}
			
		}
		// MCP total
		cellReference = new org.apache.poi.hssf.util.CellReference("AD8"); 
		for(rowindex=cellReference.getRow() + 2 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cell = row.getCell(cellReference.getCol());
			if(getCellValue(cell).equals("") || getCellValue(cell).equals("0"))
				break;
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("start_dt",getDtValue(startDtCell));
			insert.put("actual_target","actual");
			insert.put("category","MCP");
			insert.put("parent_category","-");
			insert.put("field","progress");
			insert.put("measure",getCellValue(cell));
			upload.add(insert);
		}
		// MCP S36
		cellReferences = new org.apache.poi.hssf.util.AreaReference("T9:W9");
		for(rowindex=cellReferences.getFirstCell().getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			XSSFCell firstCell = row.getCell(cellReferences.getFirstCell().getCol());
			
			if(getCellValue(firstCell).equals(""))
				break;
			
			for(columnindex=cellReferences.getFirstCell().getCol();columnindex <= cellReferences.getLastCell().getCol() ; columnindex++){
				Map<String,Object> insert = new HashMap<String,Object>();
				XSSFCell cell = row.getCell(columnindex);
				insert.put("table","SOC_DESIGN_NEW_HISTORY");
				insert.put("batchId",batchId);
				insert.put("project",project);
				insert.put("start_dt",getDtValue(startDtCell));
				insert.put("actual_target","actual");
				insert.put("category","MCP S36");
				insert.put("parent_category","MCP");
				org.apache.poi.ss.util.CellReference cellref = cellReferences.getAllReferencedCells()[columnindex - cellReferences.getFirstCell().getCol()];
				String field = getCellValue(shTable.getRow(cellref.getRow()).getCell(cellref.getCol()));
				if(field.equals("Prog."))
					field = "progress";
				insert.put("field",field);
				insert.put("measure",getCellValue(cell));
				upload.add(insert);
			}
		}
		// MCP S48
		cellReferences = new org.apache.poi.hssf.util.AreaReference("Y9:AB9");
		for(rowindex=cellReferences.getFirstCell().getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			XSSFCell firstCell = row.getCell(cellReferences.getFirstCell().getCol());
			
			if(getCellValue(firstCell).equals(""))
				break;
			
			for(columnindex=cellReferences.getFirstCell().getCol();columnindex <= cellReferences.getLastCell().getCol() ; columnindex++){
				Map<String,Object> insert = new HashMap<String,Object>();
				XSSFCell cell = row.getCell(columnindex);
				insert.put("table","SOC_DESIGN_NEW_HISTORY");
				insert.put("batchId",batchId);
				insert.put("project",project);
				insert.put("start_dt",getDtValue(startDtCell));
				insert.put("actual_target","actual");
				insert.put("category","MCP S48");
				insert.put("parent_category","MCP");
				org.apache.poi.ss.util.CellReference cellref = cellReferences.getAllReferencedCells()[columnindex - cellReferences.getFirstCell().getCol()];
				String field = getCellValue(shTable.getRow(cellref.getRow()).getCell(cellref.getCol()));
				if(field.equals("Prog."))
					field = "progress";
				insert.put("field",field);
				insert.put("measure",getCellValue(cell));
				upload.add(insert);
			}
		}
		// Wafer Test. Total
		cellReference = new org.apache.poi.hssf.util.CellReference("AQ8"); 
		for(rowindex=cellReference.getRow() + 2 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cell = row.getCell(cellReference.getCol());
			if(getCellValue(cell).equals("") || getCellValue(cell).equals("0"))
				break;
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("start_dt",getDtValue(startDtCell));
			insert.put("actual_target","actual");
			insert.put("category","Wafer Test");
			insert.put("parent_category","-");
			insert.put("field","progress");
			insert.put("measure",getCellValue(cell));
			upload.add(insert);
		}
		// Wafer Test. Trimmed discrete
		cellReferences = new org.apache.poi.hssf.util.AreaReference("AF9:AJ9");
		for(rowindex=cellReferences.getFirstCell().getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			XSSFCell firstCell = row.getCell(cellReferences.getFirstCell().getCol());
			
			if(getCellValue(firstCell).equals(""))
				break;
			
			for(columnindex=cellReferences.getFirstCell().getCol();columnindex <= cellReferences.getLastCell().getCol() ; columnindex++){
				Map<String,Object> insert = new HashMap<String,Object>();
				XSSFCell cell = row.getCell(columnindex);
				insert.put("table","SOC_DESIGN_NEW_HISTORY");
				insert.put("batchId",batchId);
				insert.put("project",project);
				insert.put("start_dt",getDtValue(startDtCell));
				insert.put("actual_target","actual");
				insert.put("category","Trimed Discrete");
				insert.put("parent_category","Wafer Test");
				org.apache.poi.ss.util.CellReference cellref = cellReferences.getAllReferencedCells()[columnindex - cellReferences.getFirstCell().getCol()];
				String field = getCellValue(shTable.getRow(cellref.getRow()).getCell(cellref.getCol()));
				if(field.equals("Prog."))
					field = "progress";
				insert.put("field",field);
				insert.put("measure",getCellValue(cell));
				upload.add(insert);
			}
		}
		
		// Wafer Test. Tested MCP
		cellReferences = new org.apache.poi.hssf.util.AreaReference("AL9:AP9");
		for(rowindex=cellReferences.getFirstCell().getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			XSSFCell firstCell = row.getCell(cellReferences.getFirstCell().getCol());
			
			if(getCellValue(firstCell).equals(""))
				break;
			
			for(columnindex=cellReferences.getFirstCell().getCol();columnindex <= cellReferences.getLastCell().getCol() ; columnindex++){
				Map<String,Object> insert = new HashMap<String,Object>();
				XSSFCell cell = row.getCell(columnindex);
				insert.put("table","SOC_DESIGN_NEW_HISTORY");
				insert.put("batchId",batchId);
				insert.put("project",project);
				insert.put("start_dt",getDtValue(startDtCell));
				insert.put("actual_target","actual");
				insert.put("category","Tested MCP");
				insert.put("parent_category","Wafer Test");
				org.apache.poi.ss.util.CellReference cellref = cellReferences.getAllReferencedCells()[columnindex - cellReferences.getFirstCell().getCol()];
				String field = getCellValue(shTable.getRow(cellref.getRow()).getCell(cellref.getCol()));
				if(field.equals("Prog."))
					field = "progress";
				insert.put("field",field);
				insert.put("measure",getCellValue(cell));
				upload.add(insert);
			}
		}
		// Target. Package. Discrete
		cellReference = new org.apache.poi.hssf.util.CellReference("AS9"); 
		for(rowindex=cellReference.getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cell = row.getCell(cellReference.getCol());
			if(getCellValue(cell).equals("") || getCellValue(cell).equals("0"))
				break;
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("start_dt",getDtValue(startDtCell));
			insert.put("actual_target","target");
			insert.put("category","Discrete");
			insert.put("parent_category","Package");
			insert.put("field","progress");
			insert.put("measure",getCellValue(cell));
			upload.add(insert);
		}
		// Target. Package. MCP
		cellReference = new org.apache.poi.hssf.util.CellReference("AT9"); 
		for(rowindex=cellReference.getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cell = row.getCell(cellReference.getCol());
			if(getCellValue(cell).equals("") || getCellValue(cell).equals("#DIV/0!"))
				break;
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("start_dt",getDtValue(startDtCell));
			insert.put("actual_target","target");
			insert.put("category","MCP");
			insert.put("parent_category","Package");
			insert.put("field","progress");
			insert.put("measure",getCellValue(cell));
			upload.add(insert);
		}
		// Target. Wafer. Trimmed
		cellReference = new org.apache.poi.hssf.util.CellReference("AU9"); 
		for(rowindex=cellReference.getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cell = row.getCell(cellReference.getCol());
			if(getCellValue(cell).equals("") || getCellValue(cell).equals("0"))
				break;
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("start_dt",getDtValue(startDtCell));
			insert.put("actual_target","target");
			insert.put("category","Trimmed");
			insert.put("parent_category","Wafer");
			insert.put("field","progress");
			insert.put("measure",getCellValue(cell));
			upload.add(insert);
		}
		
		// Target. Wafer. Tested
		cellReference = new org.apache.poi.hssf.util.CellReference("AV9"); 
		for(rowindex=cellReference.getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cell = row.getCell(cellReference.getCol());
			if(getCellValue(cell).equals("") || getCellValue(cell).equals("0"))
				break;
			XSSFCell startDtCell = row.getCell(startDtCellReference.getCol());
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("start_dt",getDtValue(startDtCell));
			insert.put("actual_target","target");
			insert.put("category","Tested");
			insert.put("parent_category","Wafer");
			insert.put("field","progress");
			insert.put("measure",getCellValue(cell));
			upload.add(insert);
		}		
	}
	
	private void parseXlsxNewSummary(String batchId,String project,String revision,List<Map<String, Object>> upload,String httpsURL, XSSFWorkbook workbook) throws Exception{
		int rowindex;
		int columnindex;
		org.apache.poi.hssf.util.CellReference cellReference;
		org.apache.poi.hssf.util.AreaReference cellReferences;
		org.apache.poi.hssf.util.CellReference categoryCellReference = new org.apache.poi.hssf.util.CellReference("C3");
		 
		
//		XSSFSheet shTable = workbook.getSheet("Statistic_Table");
		XSSFSheet shTable = workbook.getSheet("0.ValidationStatusSummary");
		if(shTable == null){
			throw new Exception("Sheet 명은 \"0.ValidationStatusSummary\" 이어야 합니다. "+ project);
		}
		int shRows = shTable.getPhysicalNumberOfRows();
		
		// Discrete Pkg. Blind
		cellReference = new org.apache.poi.hssf.util.CellReference("H5"); 
		for(rowindex=cellReference.getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cellCase = row.getCell(cellReference.getCol());
			XSSFCell cellPass = row.getCell(cellReference.getCol()+1);
			XSSFCell cellProgress = row.getCell(cellReference.getCol()+3);
			XSSFCell categoryCellCell = row.getCell(categoryCellReference.getCol());
			if(getCellValue(categoryCellCell).equals(""))
				break;
			
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY_DETAIL");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("category","Blind");
			insert.put("parent_category","Discrete");
			insert.put("detail_category",getCellValue(categoryCellCell));
			
			String cases = getCellValue(cellCase); String pass=getCellValue(cellPass); String progress = getCellValue(cellProgress);
			if(cases.equals("-")) cases = "0";
			if(pass.equals("-")) pass = "0";
			if(progress.equals("-")) progress = "0";
			insert.put("cases",cases);
			insert.put("pass",pass);
			insert.put("progress",progress);
			
			upload.add(insert);
		}
		
		// Discrete Pkg. Trimmed
		cellReference = new org.apache.poi.hssf.util.CellReference("M5"); 
		for(rowindex=cellReference.getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cellCase = row.getCell(cellReference.getCol());
			XSSFCell cellPass = row.getCell(cellReference.getCol()+1);
			XSSFCell cellProgress = row.getCell(cellReference.getCol()+3);
			XSSFCell categoryCellCell = row.getCell(categoryCellReference.getCol());
			if(getCellValue(categoryCellCell).equals(""))
				break;
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY_DETAIL");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("category","Trimmed");
			insert.put("parent_category","Discrete");
			insert.put("detail_category",getCellValue(categoryCellCell));
			
			String cases = getCellValue(cellCase); String pass=getCellValue(cellPass); String progress = getCellValue(cellProgress);
			if(cases.equals("-")) cases = "0";
			if(pass.equals("-")) pass = "0";
			if(progress.equals("-")) progress = "0";
			insert.put("cases",cases);
			insert.put("pass",pass);
			insert.put("progress",progress);
			
			upload.add(insert);
		}
		
		// MCP. MCP S36
		cellReference = new org.apache.poi.hssf.util.CellReference("S5"); 
		for(rowindex=cellReference.getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cellCase = row.getCell(cellReference.getCol());
			XSSFCell cellPass = row.getCell(cellReference.getCol()+1);
			XSSFCell cellProgress = row.getCell(cellReference.getCol()+3);
			XSSFCell categoryCellCell = row.getCell(categoryCellReference.getCol());
			if(getCellValue(categoryCellCell).equals(""))
				break;
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY_DETAIL");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("category","MCP S36");
			insert.put("parent_category","MCP");
			insert.put("detail_category",getCellValue(categoryCellCell));
			
			String cases = getCellValue(cellCase); String pass=getCellValue(cellPass); String progress = getCellValue(cellProgress);
			if(cases.equals("-")) cases = "0";
			if(pass.equals("-")) pass = "0";
			if(progress.equals("-")) progress = "0";
			insert.put("cases",cases);
			insert.put("pass",pass);
			insert.put("progress",progress);
			
			upload.add(insert);
		}
		
		// MCP. MCP S48
		cellReference = new org.apache.poi.hssf.util.CellReference("X5"); 
		for(rowindex=cellReference.getRow() + 1 ; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			Map<String,Object> insert = new HashMap<String,Object>();
			XSSFCell cellCase = row.getCell(cellReference.getCol());
			XSSFCell cellPass = row.getCell(cellReference.getCol()+1);
			XSSFCell cellProgress = row.getCell(cellReference.getCol()+3);
			XSSFCell categoryCellCell = row.getCell(categoryCellReference.getCol());
			if(getCellValue(categoryCellCell).equals(""))
				break;
			
			insert.put("table","SOC_DESIGN_NEW_HISTORY_DETAIL");
			insert.put("batchId",batchId);
			insert.put("project",project);
			insert.put("category","MCP S48");
			insert.put("parent_category","MCP");
			insert.put("detail_category",getCellValue(categoryCellCell));

			String cases = getCellValue(cellCase); String pass=getCellValue(cellPass); String progress = getCellValue(cellProgress);
			if(cases.equals("-")) cases = "0";
			if(pass.equals("-")) pass = "0";
			if(progress.equals("-")) progress = "0";
			insert.put("cases",cases);
			insert.put("pass",pass);
			insert.put("progress",progress);
			
			upload.add(insert);
		}
	}
	
	
	private void parseXlsxSummary(String batchId,String project,String revision,List<Map<String, Object>> upload, String httpsURL, XSSFWorkbook workbook) throws Exception {
		int rowindex;
		int columnindex;
//		XSSFSheet shTable = workbook.getSheet("Summary");
		XSSFSheet shTable = workbook.getSheet("VerificationStatusSummary");
		if(shTable == null){
			throw new Exception("Sheet 명은 \"VerificationStatusSummary\" 이어야 합니다." + project);
		}
		//index 별 정리
		Map<Object,Map<String,Object>> colDef = new HashMap<Object,Map<String,Object>>();
		int shRows = shTable.getPhysicalNumberOfRows();
		
		
		//**** start RTL ****//
		XSSFRow rowCategoryRtl = shTable.getRow(3);
		for(rowindex=3; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			int cells = 11;
			
			//컬럼정의 RTL
			if(rowindex == 4 ){
								
				for(columnindex=6;columnindex <= cells ; columnindex++){
					Map<String,Object> m = new HashMap<String, Object>();
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					int cellCategoryIndex = ((columnindex-6) % 2) == 0 ?columnindex:(columnindex - (columnindex-6)%2);
					XSSFCell cellCategory = rowCategoryRtl.getCell(cellCategoryIndex);
					m.put("col",cell.getStringCellValue());
					m.put("category","RTL " + getCellValue(cellCategory));
					colDef.put(columnindex,m);
		    	}
				
			}else if(rowindex > 4){
				// total이면 break
				XSSFCell cellIndex1 = row.getCell(6);
				if(getCellValue(cellIndex1).equals("")){
					break;
				}
				
				for(columnindex=6;columnindex <= cells ; columnindex++){
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					Map<String,Object> insert = new HashMap<String,Object>();
					
					Map<String,Object> col = colDef.get(columnindex);        
					String category = col.get("category").toString();
					
					
					insert.put("table","SOC_DESIGN_SUMMARY");
					insert.put("batchId",batchId);
					insert.put("category1",category);
					insert.put("category2",getCellValue(row.getCell(2)));
					insert.put("col",col.get("col").toString()); 
					insert.put("result",getCellValue(cell)); 
					insert.put("csv_url",httpsURL);
					insert.put("project",project);
					insert.put("revision",revision);
					upload.add(insert);
		    	}
				
			}
			
		}
		//**** end RTL ****//
		
		//**** start FPGA ****//
		for(rowindex=3; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			int cells = 18;
			
			//컬럼정의 RTL
			if(rowindex == 3 ){
								
				for(columnindex=cells-1;columnindex <= cells ; columnindex++){
					Map<String,Object> m = new HashMap<String, Object>();
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					m.put("col",getCellValue(cell));
					m.put("category","FPGA");
					colDef.put(columnindex,m);
		    	}
				
			}else if(rowindex == 4){
				continue;
			}else if(rowindex > 4){
				// total이면 break
				XSSFCell cellIndex1 = row.getCell(cells-1);
				if(getCellValue(cellIndex1).equals("")){
					break;
				}
				
				for(columnindex=cells-1;columnindex <= cells ; columnindex++){
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					Map<String,Object> insert = new HashMap<String,Object>();
					
					Map<String,Object> col = colDef.get(columnindex);        
					String category = col.get("category").toString();
					
					insert.put("table","SOC_DESIGN_SUMMARY");
					insert.put("batchId",batchId);
					insert.put("category1",category);
					insert.put("category2",getCellValue(row.getCell(2)));
					insert.put("col",col.get("col").toString()); 
					insert.put("result",getCellValue(cell)); 
					insert.put("csv_url",httpsURL);
					insert.put("project",project);
					insert.put("revision",revision);
					upload.add(insert);
		    	}
				
			}
			
		}
		//**** end FPGA ****//
		
		//**** start POST ****//
		for(rowindex=3; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			int cells = 23;
			
			//컬럼정의 RTL
			if(rowindex == 3 ){
								
				for(columnindex=cells-1;columnindex <= cells ; columnindex++){
					Map<String,Object> m = new HashMap<String, Object>();
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					m.put("col",getCellValue(cell));
					m.put("category","POST");
					colDef.put(columnindex,m);
		    	}
				
			}else if(rowindex == 4){
				continue;
			}else if(rowindex > 4){
				// total이면 break
				XSSFCell cellIndex1 = row.getCell(cells-1);
				if(getCellValue(cellIndex1).equals("")){
					break;
				}
				
				for(columnindex=cells-1;columnindex <= cells ; columnindex++){
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					Map<String,Object> insert = new HashMap<String,Object>();
					
					Map<String,Object> col = colDef.get(columnindex);        
					String category = col.get("category").toString();
					
					insert.put("table","SOC_DESIGN_SUMMARY");
					insert.put("batchId",batchId);
					insert.put("category1",category);
					insert.put("category2",getCellValue(row.getCell(2)) );
					insert.put("col",col.get("col").toString()); 
					insert.put("result",getCellValue(cell) ); 
					insert.put("csv_url",httpsURL);
					insert.put("project",project);
					insert.put("revision",revision);
					upload.add(insert);
		    	}
				
			}
			
		}
		//**** end POST ****//
		
		//**** start ASIC ****//
		for(rowindex=3; rowindex<shRows; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			int cells = 28;
			
			//컬럼정의 RTL
			if(rowindex == 3 ){
								
				for(columnindex=cells-1;columnindex <= cells ; columnindex++){
					Map<String,Object> m = new HashMap<String, Object>();
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					m.put("col",getCellValue(cell) );
					m.put("category","ASIC");
					colDef.put(columnindex,m);
		    	}
				
			}else if(rowindex == 4){
				continue;
			}else if(rowindex > 4){
				// total이면 break
				XSSFCell cellIndex1 = row.getCell(cells-1);
				if(getCellValue(cellIndex1).equals("")){
					break;
				}
				
				for(columnindex=cells-1;columnindex <= cells ; columnindex++){
					Map<String,Object> m = new HashMap<String, Object>();
					XSSFCell cell = row.getCell(columnindex);
					
					if(cell == null){
						continue;
					}
					
					Map<String,Object> insert = new HashMap<String,Object>();
					
					Map<String,Object> col = colDef.get(columnindex);        
					String category = col.get("category").toString();
					
					insert.put("table","SOC_DESIGN_SUMMARY");
					insert.put("batchId",batchId);
					insert.put("category1",category);
					insert.put("category2",getCellValue(row.getCell(2)) );
					insert.put("col",col.get("col").toString()); 
					insert.put("result",getCellValue(cell) ); 
					insert.put("csv_url",httpsURL);
					insert.put("project",project);
					insert.put("revision",revision);
					upload.add(insert);
		    	}
				
			}
			
		}
		//**** end ASIC ****//
	}
	
	
	
	
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void parseCsv(Map<Object, Object> parameter) throws Exception {
		JSONArray urlList = (JSONArray) JSONSerializer.toJSON( parameter.get("urlList") );
		List<Map<String,Object>> upload = new ArrayList<Map<String,Object>>();
		for(int i=0;i<urlList.size();i++){
			Map url = (Map)urlList.get(i);
        	String httpsURL = url.get("CSV_URL").toString() ;
            URL myurl = new URL(httpsURL);
            
            java.net.HttpURLConnection con = (HttpURLConnection) myurl.openConnection();
            InputStream ins = con.getInputStream();
            
            InputStreamReader isr = new InputStreamReader(ins);
            BufferedReader in = new BufferedReader(isr);
            
            //index 별 정리
            Map<Object,Map<String,Object>> colDef = new HashMap<Object,Map<String,Object>>();
         
            int j = 0;
            String inputLine;
            while ((inputLine = in.readLine()) != null)
            {
            	String[] inputs = inputLine.split(",");
            	if(j < 2){
            		j++;
            		continue;
            	}
            	
            	//컬럼정의
            	if(j==2){
            		
            		//첫번째컬럼.
            		Map<String,Object> m1 = new HashMap<String, Object>();
        			m1.put("col","code");
        			m1.put("category","");
        			colDef.put(1,m1);
        			
            		for(int k=2;k <= 6;k++){
            			Map<String,Object> m = new HashMap<String, Object>();
            			m.put("col",inputs[k]);
            			m.put("category","RTL");
            			colDef.put(k,m);
            		}
            		
            		for(int k=7;k <= 11;k++){
            			Map<String,Object> m = new HashMap<String, Object>();
            			m.put("col",inputs[k]);
            			m.put("category","FPGA");
            			colDef.put(k,m);
            		}
            		
            		for(int k=12;k <= 16;k++){
            			Map<String,Object> m = new HashMap<String, Object>();
            			m.put("col",inputs[k]);
            			m.put("category","POST");
            			colDef.put(k,m);
            		}
            		
            		for(int k=17;k <= 21;k++){
            			Map<String,Object> m = new HashMap<String, Object>();
            			m.put("col",inputs[k]);
            			m.put("category","ASIC");
            			colDef.put(k,m);
            		}
            		
            		for(int k=22;k <= 30;k++){
            			Map<String,Object> m = new HashMap<String, Object>();
            			m.put("col",inputs[k]);
            			m.put("category","TEST_LEVEL");
            			colDef.put(k,m);
            		}
            		
            		j++;
            		continue;
            		
            	}
            	
            	//row 데이타만들기
            	if(j > 2){
            		if(inputs[0].equalsIgnoreCase("Total")){
            			j++;
            			continue;
            		}
            		
            		
            		
            		for(int k=2;k < inputs.length; k++){
            			Map<String,Object> insert = new HashMap<String,Object>();
            			
            			Map<String,Object> col = colDef.get(k);        
            			String category = col.get("category").toString();
            			
            			insert.put("category1",category);
        				insert.put("category2",inputs[1]);
        				insert.put("code",col.get("col").toString()); 
        				insert.put("result",inputs[k]);
        				insert.put("csv_url",httpsURL);
        				upload.add(insert);
            			
            		}
                	
            	}
            	
            	j++;
            }
         
            in.close();
		}
		
		saveCsv(upload);		
		
	}	
	
	
	public String getCellValue(XSSFCell cell){
		String value = "";
		if(cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC){
			value = cell.getNumericCellValue() + "";
			if (HSSFDateUtil.isCellDateFormatted(cell)) {
				java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMdd");
				value = df.format(cell.getDateCellValue());
			}
			   
		}
		else if(cell.getCellType() == XSSFCell.CELL_TYPE_STRING)
			value = cell.getStringCellValue();
		else if(cell.getCellType() == XSSFCell.CELL_TYPE_BLANK)
			value = "";
		else
			value = cell.getRawValue();
		
		if(value.equals("#DIV/0!")){
			value = "0";
		}
		if(value.equals("#VALUE!")){
			value = "0";
		}
		if(value.equals("N/A")){
			value = "0";
		}
		if(value.equals("#N/A")){
			value = "0";
		}
		if(value.equals("NA")){
			value = "0";
		}
		
		return value;
	}
	
	public String getDtValue(XSSFCell cell){
		String value = "";
		if(cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC){
			value = cell.getNumericCellValue() + "";
			java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMdd");
			value = df.format(cell.getDateCellValue());
			   
		}
		
		return value;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getSummaryForChart(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dashboard.socdesign.list.for.chart", parameter);
						
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> socDesignChartPopJson(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dashboard.socdesign.select.by.ip", parameter);
						
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> testCaseByProject(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dashboard.socdesign.list.for.chart.testcase", parameter);
						
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> socDesignGeneralList(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dashboard.socdesign.new.general.list", parameter);
						
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> socDesignProjectlHistory(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dashboard.socdesign.new.project.list.history", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> socDesignProjectlDetail(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dashboard.socdesign.new.project.list.detail", parameter);
		return list;
	}
	
}
