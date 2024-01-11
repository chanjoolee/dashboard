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

//import org.apache.commons.validator.UrlValidator;
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

//import sun.misc.BASE64Encoder;
import java.util.Base64;
import common.dao.CommonDao;
import common.dao.DevDao;
import common.dao.OperDao;
import common.dao.PmsDao;
import common.service.CommonService;
import dashboard.controller.ProjectListByJsonController;

@Service
public class BatchFwqService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsDao;
    
    @Autowired
    private CommonService commonService;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getFileUrlList(Map<Object, Object> parameter) throws Exception {
		List attach = new ArrayList();
		
		parameter.put("spaceKey","FSSW");
		parameter.put("title","FW Quality Metrics");
		JSONObject space = getConfluenceSpace(parameter);
		if((int)space.get("size") > 0){
			// 02. attachfile list			
			getConfluenceAttachMent(attach,space);
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
			
			// getJSONArray("results") 날자별 sorting 필요.
			for(Object attach :attachObject.getJSONArray("results")){
				JSONObject att = (JSONObject)attach;
				JSONObject _links = att.getJSONObject("_links");//.getJSONObject("download");
				if(_links != null && !((String)_links.get("webui")).contains("Quality-Metric-Template")){
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
		// BASE64Encoder base64Encoder = new BASE64Encoder();
		// String base64User = base64Encoder.encode(strUser.getBytes());
		String base64User = Base64.getEncoder().encodeToString(strUser.getBytes());
		
		String spaceKey =parameter.get("spaceKey").toString();
		String title = parameter.get("title").toString().replace(" ", "+");
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
		
		//dao.update("dashbaord.batch.fwq.deleteAll",null);
		dao.update("dashbaord.batch.fwq.delete",upload.get(0)); // param: first data
		
		int cnt = 0;
		for(int i=0;i<upload.size();i++){
			Map<String,Object> m = upload.get(i);
			
			cnt += dao.update("dashbaord.batch.fwq.save", m);
				
		}
		dao.update("dashbaord.batch.fwq.history",null);
		dao.update("dashbaord.batch.fwq.isLast",null);
		
		return cnt;
		
	}
	
	/**
	 * 엑셀에 업로드 하는 것이 중단되었기 때문에 
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void updateHistory() throws Exception {
		
		dao.update("dashboard.batch.fwq.functionParameter",null);
		dao.update("dashbaord.batch.fwq.point",null);
		dao.update("dashbaord.batch.fwq.history",null);
		dao.update("dashbaord.batch.fwq.isLast",null);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int deleteAll() {
		int cnt = 0;
		cnt = dao.update("dashbaord.batch.fwq.deleteAll",null);
		return cnt;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked", "resource"})
	public void parseXlsx(Map<Object, Object> parameter) throws Exception {
		
//		JSONArray urlList = (JSONArray) JSONSerializer.toJSON( parameter.get("urlList") );
		List urlList = (List)parameter.get("urlList");
		List<Map<String,Object>> upload = new ArrayList<Map<String,Object>>();
		
		//deleteAll();
		
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
            parseXlsxDetail(batchId,upload, httpsURL, workbook);
            
		}
		
		save(upload);
	}
	

	@SuppressWarnings("serial")
	private void parseXlsxDetail(String batchId,List<Map<String, Object>> upload,String httpsURL, XSSFWorkbook workbook) throws Exception {
		int rowindex;
		int columnindex;
		//XSSFSheet shTable = workbook.getSheet("Statistic_Table");
		XSSFSheet shTable = workbook.getSheetAt(0);
		
		//index 별 정리
		Map<Object,Map<String,Object>> colDef = new HashMap<Object,Map<String,Object>>();
		int shRows = shTable.getPhysicalNumberOfRows();
		
		int locCol = 2;
		int maxColIndex = 22;
		XSSFRow mesureDtRow = shTable.getRow(1);
		XSSFCell mesureDtCell = mesureDtRow.getCell(22);
		if(mesureDtCell == null){
			mesureDtCell = mesureDtRow.getCell(23);
			locCol = 3; //revision 제외함
			maxColIndex = 23;
			if(mesureDtCell == null){
				throw new Exception("엑셀파일형식이 잘못되었습니다. "+ httpsURL);
			}
		}
		String measureDt = getCellValue(mesureDtCell);
		
		//컬럼정의		
		colDef.put(1,new HashMap<String, Object>(){{ put("col","project");}});
		colDef.put(locCol,new HashMap<String, Object>(){{ put("col","loc");}}); 
		colDef.put(locCol + 1,new HashMap<String, Object>(){{ put("col","static_analysis_measure");}});
		colDef.put(locCol + 2,new HashMap<String, Object>(){{ put("col","static_analysis_point");}});
		colDef.put(locCol + 3,new HashMap<String, Object>(){{ put("col","complexity_measure");}});
		colDef.put(locCol + 4,new HashMap<String, Object>(){{ put("col","complexity_point");}});
		colDef.put(locCol + 5,new HashMap<String, Object>(){{ put("col","func_size_measure");}});
		colDef.put(locCol + 6,new HashMap<String, Object>(){{ put("col","func_size_point");}});
		colDef.put(locCol + 7,new HashMap<String, Object>(){{ put("col","duplicate_measure");}});
		colDef.put(locCol + 8,new HashMap<String, Object>(){{ put("col","duplicate_point");}});
		colDef.put(locCol + 9,new HashMap<String, Object>(){{ put("col","coding_convention_measure");}});
		colDef.put(locCol + 10,new HashMap<String, Object>(){{ put("col","coding_convention_point");}});
		colDef.put(locCol + 11,new HashMap<String, Object>(){{ put("col","architecture_measure");}});
		colDef.put(locCol + 12,new HashMap<String, Object>(){{ put("col","architecture_point");}});
		colDef.put(locCol + 13,new HashMap<String, Object>(){{ put("col","unit_test_measure");}});
		colDef.put(locCol + 14,new HashMap<String, Object>(){{ put("col","unit_test_point");}});
		colDef.put(locCol + 15,new HashMap<String, Object>(){{ put("col","simulator_test_measure");}});
		colDef.put(locCol + 16,new HashMap<String, Object>(){{ put("col","simulator_test_point");}});
		colDef.put(locCol + 17,new HashMap<String, Object>(){{ put("col","target_test_measure");}});
		colDef.put(locCol + 18,new HashMap<String, Object>(){{ put("col","target_test_point");}});
		colDef.put(locCol + 19,new HashMap<String, Object>(){{ put("col","total_measure");}});
		colDef.put(locCol + 20,new HashMap<String, Object>(){{ put("col","point");}});
	
		//make save data
		for(rowindex=7; rowindex<shRows;rowindex++){
			XSSFRow row = shTable.getRow(rowindex);
			
			// break
			XSSFCell cellIndex1 = row.getCell(3);
			if(getCellValue(cellIndex1).equals("")){
				break;
			}			
			
			
			Map<String,Object> insert = new HashMap<String,Object>();
			//insert.put("table","feature");
			insert.put("batchId",batchId);	
			insert.put("download_url",httpsURL);
			insert.put("measure_dt", measureDt);
			for (Map.Entry<Object,Map<String,Object>> entry : colDef.entrySet()) {
				columnindex =  (Integer)entry.getKey();
				XSSFCell cell = row.getCell(columnindex);
				
				Map<String,Object> col = colDef.get(columnindex);        
				insert.put(col.get("col").toString(),getCellValue(cell));
			}
			
			/*for(columnindex=1;columnindex <= maxColIndex ; columnindex++){
				XSSFCell cell = row.getCell(columnindex);
				
				Map<String,Object> col = colDef.get(columnindex);        
				insert.put(col.get("col").toString(),getCellValue(cell));
	    	}*/
			upload.add(insert);
			
		}
	}
	
	
	
	@SuppressWarnings("rawtypes")
    public List getLinkUrlList(Map<Object, Object> parameter) {
		
        return (List)dao.selectList("dashboard.batch.fwq.linkcheck.list", parameter);
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void checkUrl(List<Map<String,Object>> list ,Map<Object,Object> searchVO ) throws Exception {
		//UrlValidator  urlValidator = new UrlValidator();
		int cnt = 0;
		for(int i=0;i<list.size();i++){
			Map<String,Object> m = list.get(i);
			
			//String[] columns = {"LINK_STATIC","LINK_FUNCTION_PARAMETER","LINK_FUNCTION_LOC","LINK_DUPLICATE","LINK_CODING_RULE","LINK_ARCHITECTURE_COMPLEXITY","LINK_COVERAGE"};
			//String[] columns = {"LINK_STATIC","LINK_FUNCTION_PARAMETER","LINK_FUNCTION_LOC","LINK_DUPLICATE","LINK_CODING_RULE","LINK_ARCHITECTURE_COMPLEXITY"};
			ArrayList<String> columns = new ArrayList<String>();
			columns.add("LINK_STATIC");
			columns.add("LINK_FUNCTION_PARAMETER");
			columns.add("LINK_FUNCTION_LOC");
			columns.add("LINK_DUPLICATE");
			columns.add("LINK_CODING_RULE");
			columns.add("LINK_ARCHITECTURE_COMPLEXITY");
			
			if(searchVO.get("includeAll") != null && searchVO.get("includeAll").toString().equals("Y") ){
				columns.add("LINK_COVERAGE");
			}
			for(int j=0; j < columns.size() ; j++){
				String col = columns.get(j);
				Object url = m.get(col);
				String result = "N";				
				try {
					
					// note : you may also need
					// HttpURLConnection.setInstanceFollowRedirects(false)
					if(url != null){
						HttpURLConnection.setFollowRedirects(false);
						HttpURLConnection con = (HttpURLConnection) new URL(url.toString().replace(" ","%20")).openConnection();
						con.setRequestMethod("HEAD");
						if (con.getResponseCode() == HttpURLConnection.HTTP_OK)
							result = "Y";
						//con.setRequestProperty("Connection", "close");
						con.disconnect();
						/*if (urlValidator.isValid(url.toString().replace(" ","%20")))
							result = "Y";*/
						
					}else
						result = "N";
					
				} catch (Exception e) {
					//e.printStackTrace();
					result = "N";
				} finally{
					if(url != null && url.toString().equals("http://codesonar1.skhynix.com:7340/analysis/2708")){
						@SuppressWarnings("unused")
						String debug = "aaa";
					}
					m.put("CATEGORY", col);
					m.put("LINK", url != null ? url.toString() : "undefined");
					m.put("RESULT", result);
					dao.update("dashboard.batch.fwq.linkcheck.update", m);
				}
				
			}
			
				
		}
		
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
	
	
	
	
}
