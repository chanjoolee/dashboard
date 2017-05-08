package dashboard.batch.service;

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

import sun.misc.BASE64Encoder;
import common.dao.CommonDao;
import common.dao.PmsDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class BatchFileFvtService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsDao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getFileUrlList(Map<Object, Object> parameter) throws Exception {
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
	public List<?> getFileUrlListTest(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dashbaord.batch.fvt.url", parameter);
		
		for(Object o : list){
			Map m = (Map)o;
			m.put("download",m.get("DOWNLOAD"));
		}
		
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<?> getConfluenceAttachMent(@SuppressWarnings("rawtypes") List list,JSONObject space) throws Exception {
		
		String strUser="conf.dashboard:conf.dashboard";
		BASE64Encoder base64Encoder = new BASE64Encoder();
		String base64User = base64Encoder.encode(strUser.getBytes());
		
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
		return list;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public JSONObject getConfluenceSpace(Map<Object, Object> parameter) throws Exception {
		
//		String strUser="chanjoo2.lee:chanjoo2.lee";
		String strUser="conf.dashboard:conf.dashboard";
		BASE64Encoder base64Encoder = new BASE64Encoder();
		String base64User = base64Encoder.encode(strUser.getBytes());
		
		String spaceKey =parameter.get("INTERFACE_ID").toString();
		String title = "FVT+(Dashboard)";
		String strUrl="http://confluence.skhynix.com/rest/api/content?spaceKey="+spaceKey+"&title="+title;
//		String strUrl="http://confluence.skhynix.com/rest/api/content?title="+title;
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
	public int save(List<Map<String,Object>> upload) throws Exception {
		int cnt = 0;
		for(int i=0;i<upload.size();i++){
			Map<String,Object> m = upload.get(i);
			String table = m.get("table").toString();
			
			if(table.equals("feature"))
				cnt += dao.update("dashbaord.batch.fvt.save.feature", m);
			if(table.equals("summary"))
				cnt += dao.update("dashbaord.batch.fvt.save.summay", m);
			if(table.equals("detail")){
				if(m.get("category") != null && !m.get("category").equals("")){
					cnt += dao.update("dashbaord.batch.fvt.save.detail", m);
				}
			}
			
				
		}
		return cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int deleteAll() {
		int cnt = 0;
		cnt = dao.update("dashbaord.batch.fvt.deleteall",null);
		return cnt;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked", "resource"})
	public void parseXlsx(Map<Object, Object> parameter) throws Exception {
		
//		JSONArray urlList = (JSONArray) JSONSerializer.toJSON( parameter.get("urlList") );
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
    		BASE64Encoder base64Encoder = new BASE64Encoder();
    		String base64User = base64Encoder.encode(strUser.getBytes());
            con.setRequestProperty("Authorization", "Basic "+base64User); 
		    con.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
            InputStream ins = con.getInputStream();
            
            XSSFWorkbook workbook=new XSSFWorkbook(ins);
            
            String batchId = parameter.get("batchId").toString();
            String project = url.get("interface_id").toString();
            String revision = "1";
            //***  feature ******//
            parseXlsxFeature(batchId,project,revision,upload, httpsURL, workbook);
            
            //***  fvtSummary ******//
            //parseXlsxFvtSummary(batchId,project,revision,upload, httpsURL, workbook);
            
            //***  parseXlsxFvtDetail ******//
            //parseXlsxFvtDetail(batchId,project,revision,upload, httpsURL, workbook);
		}
		
		save(upload);
	}
	

	@SuppressWarnings("serial")
	private void parseXlsxFeature(String batchId,String project,String revision,List<Map<String, Object>> upload,String httpsURL, XSSFWorkbook workbook) {
		int rowindex;
		int columnindex;
		//XSSFSheet shTable = workbook.getSheet("Statistic_Table");
		XSSFSheet shTable = workbook.getSheetAt(0);
		
		//index 별 정리
		Map<Object,Map<String,Object>> colDef = new HashMap<Object,Map<String,Object>>();
		int shRows = shTable.getPhysicalNumberOfRows();
		
		
		//컬럼정의		
		colDef.put(2,new HashMap<String, Object>(){{ put("col","phase");}});
		colDef.put(3,new HashMap<String, Object>(){{ put("col","degree");}}); //degree 차수
		colDef.put(4,new HashMap<String, Object>(){{ put("col","dt");}});//일자
		colDef.put(5,new HashMap<String, Object>(){{ put("col","fw_version");}});
		colDef.put(6,new HashMap<String, Object>(){{ put("col","pass");}});
		colDef.put(7,new HashMap<String, Object>(){{ put("col","fail");}});
		colDef.put(8,new HashMap<String, Object>(){{ put("col","no_test");}});
		colDef.put(9,new HashMap<String, Object>(){{ put("col","total");}});
		colDef.put(10,new HashMap<String, Object>(){{ put("col","progress");}}); // 진행율
		
		//make save data
		for(rowindex=6; rowindex<shRows;){
			XSSFRow row = shTable.getRow(rowindex);
			
			// break
			XSSFCell cellIndex1 = row.getCell(3);
			if(getCellValue(cellIndex1).equals("")){
				break;
			}			
			
			String phase = getPhase(shTable,rowindex,2);
			
			Map<String,Object> insert = new HashMap<String,Object>();
			insert.put("table","feature");
			insert.put("batchId",batchId);	
			insert.put("project",project);
			insert.put("revision",revision);
			insert.put("phase",phase);
			insert.put("download_url",httpsURL);
			for(columnindex=3;columnindex <= 10 ; columnindex++){
				XSSFCell cell = row.getCell(columnindex);
				
				Map<String,Object> col = colDef.get(columnindex);        
				insert.put(col.get("col").toString(),getCellValue(cell));
	    	}
			upload.add(insert);
			
			int totalIndex = parseXlsxFvtSummary(batchId,project,revision,upload, httpsURL, shTable,insert,rowindex);
			parseXlsxFvtDetail(batchId,project,revision,upload, httpsURL, shTable,insert,rowindex);
			
			rowindex = totalIndex +1;
			
		}
	}
	
	@SuppressWarnings("serial")	
	private int parseXlsxFvtSummary(String batchId,String project,String revision,List<Map<String, Object>> upload, String httpsURL, XSSFSheet shTable,Map<String,Object> feature, int featureindex) {
		int rowindex ;
		int columnindex;
		//XSSFSheet shTable = workbook.getSheet("Statistic_Table");
		
		//index 별 정리
		Map<Object,Map<String,Object>> colDef = new HashMap<Object,Map<String,Object>>();
		int shRows = shTable.getPhysicalNumberOfRows();
		
		
		//컬럼정의		
		colDef.put(12,new HashMap<String, Object>(){{ put("col","pass");}});
		colDef.put(13,new HashMap<String, Object>(){{ put("col","total");}});
		colDef.put(14,new HashMap<String, Object>(){{ put("col","progress");}});
		colDef.put(15,new HashMap<String, Object>(){{ put("col","total_progress");}});
		
		// total index
		int totalIndex = featureindex;
		for(rowindex = featureindex ; rowindex< shRows ; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			XSSFCell cell = row.getCell(11);
			if(getCellValue(cell).equalsIgnoreCase("total")){
				totalIndex = rowindex;
				break;
			}
		}
				
		//make save data
		XSSFRow row = shTable.getRow(totalIndex);
		
		Map<String,Object> insert = new HashMap<String,Object>();
		insert.put("table","summary");
		insert.put("batchId",feature.get("batchId"));	
		insert.put("project",feature.get("project"));
		insert.put("revision",feature.get("revision"));
		insert.put("phase",feature.get("phase"));
		insert.put("degree",feature.get("degree"));
		insert.put("fw_version",feature.get("fw_version"));
		insert.put("download_url",httpsURL);
		
		for(columnindex=12;columnindex <= 15 ; columnindex++){
			XSSFCell cell = row.getCell(columnindex);
			
			Map<String,Object> col = colDef.get(columnindex);        
			insert.put(col.get("col").toString(),getCellValue(cell));
    	}
		feature.put("total_progress",insert.get("total_progress"));
		upload.add(insert);		
			
		return totalIndex;
	}
	
	@SuppressWarnings("serial")	
	private int parseXlsxFvtDetail(String batchId,String project,String revision,List<Map<String, Object>> upload, String httpsURL, XSSFSheet shTable, Map<String,Object> feature, int featureindex) {
		int rowindex ;
		int columnindex;
		//XSSFSheet shTable = workbook.getSheet("Statistic_Table");
		
		//index 별 정리
		Map<Object,Map<String,Object>> colDef = new HashMap<Object,Map<String,Object>>();
		int shRows = shTable.getPhysicalNumberOfRows();
		
		
		//컬럼정의		
		colDef.put(11, new HashMap<String, Object>(){{ put("col","category");}});
		colDef.put(12, new HashMap<String, Object>(){{ put("col","pass");}});
		colDef.put(13, new HashMap<String, Object>(){{ put("col","total");}});
		colDef.put(14, new HashMap<String, Object>(){{ put("col","progress");}});
		colDef.put(15, new HashMap<String, Object>(){{ put("col","total_progress");}});
		
		// total index
		int totalIndex = featureindex;
		for(rowindex = featureindex ; rowindex< shRows ; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			XSSFCell cell = row.getCell(11);
			if(getCellValue(cell).equalsIgnoreCase("total")){
				totalIndex = rowindex;
				break;
			}
		}
		
		//make save data
		for(rowindex = featureindex ; rowindex< totalIndex ; rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			
			Map<String,Object> insert = new HashMap<String,Object>();
			insert.put("table","detail");
			insert.put("batchId",feature.get("batchId"));	
			insert.put("project",feature.get("project"));
			insert.put("revision",feature.get("revision"));
			insert.put("phase",feature.get("phase"));
			insert.put("degree",feature.get("degree"));
			insert.put("fw_version",feature.get("fw_version"));
			insert.put("download_url",httpsURL);
			
			for(columnindex=11; columnindex <= 15 ; columnindex++){
				XSSFCell cell = row.getCell(columnindex);
				
				Map<String,Object> col = colDef.get(columnindex);        
				insert.put(col.get("col").toString(),getCellValue(cell));
	    	}
			upload.add(insert);			
		}
		
		return totalIndex;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getFvtPassByDt(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dsahboard.batch.fvt.select.passByDt", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getFvtPhaseCount(Map<Object, Object> parameter) throws Exception {
		List list = (List)dao.selectList("dsahboard.batch.fvt.select.phaseCount", parameter);
		return list;
	}
	
	
	public String getPhase(XSSFSheet sheet,int rowindex, int colindex){
		String phase = "";
		XSSFRow row = sheet.getRow(rowindex);
		
		XSSFCell cellIndex = row.getCell(2);
		if(getCellValue(cellIndex).equals("")){
			phase = getPhase(sheet,rowindex-1,colindex);
		}else
			phase = getCellValue(cellIndex);
		return phase;
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
		return value;
	}
	
	
}
