package common.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.jersey.core.header.ContentDisposition;
import com.sun.jersey.multipart.FormDataBodyPart;

import common.dao.CommonDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class CommonService {
	private static final Logger logger = LoggerFactory.getLogger(CommonService.class);

    @Autowired
    private CommonDao dao;
    
    @Autowired
	DataSourceTransactionManager transactionManager;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
	@SuppressWarnings("rawtypes")
    public List selectList(String statement,Object parameter) {
        return (List)dao.selectList(statement, parameter);
    }
	
	@SuppressWarnings("rawtypes")
    public void update(String statement,Object parameter) {
		Map<Object,Object> param = (Map<Object,Object>)parameter;	 
		String loop_id = "";
		net.sf.json.JSONObject searchJson = (net.sf.json.JSONObject)param.get("searchJson");
		if(searchJson != null){
			loop_id =  (String)searchJson.get("loop_id");
			if(loop_id != null){
				net.sf.json.JSONArray update_list = (net.sf.json.JSONArray)searchJson.get(loop_id);
				for( int i = 0; i < update_list.size(); i++){
					net.sf.json.JSONObject update = (net.sf.json.JSONObject)update_list.get(i);
					param.put("detail",update);
					dao.update(statement, param);
				}
				
			}else{
				dao.update(statement, parameter);
			}
		}
		else{
			dao.update(statement, parameter);
		}
        
    }
	
	@SuppressWarnings("rawtypes")
    public void updateAutoSave(String statement,Object parameter) {
		Map<Object,Object> param = (Map<Object,Object>)parameter;	 
		net.sf.json.JSONArray autoJson = (net.sf.json.JSONArray)param.get("autoJson");
		if(autoJson != null){
				
				for( int i = 0; i < autoJson.size(); i++){
					net.sf.json.JSONObject update = (net.sf.json.JSONObject)autoJson.get(i);
					param.put("detail",update);
					System.out.println("update 11111111 : " + update.toString());
					dao.update(statement, param);
				}
		}
    }
	
	@SuppressWarnings("rawtypes")
    public int updateAllSave(String statement,Object parameter) {
		int result = 0;
		Map<Object,Object> param = (Map<Object,Object>)parameter;
		net.sf.json.JSONArray autoJson = (net.sf.json.JSONArray)param.get("autoJson");
		if(autoJson != null){
				for( int i = 0; i < autoJson.size(); i++){
					net.sf.json.JSONObject update = (net.sf.json.JSONObject)autoJson.get(i);
					param.put("detail",update);
					
					if( "U".equals( update.get("status") ) ) {
						result += dao.insert(statement, param);
					}else {
						result += dao.insert(statement, param);
					}
					
				}
		}
		return Math.abs(result);
    }
	
	@SuppressWarnings("rawtypes")
    public void loopUpdate(String statement,Object parameter) {		
        dao.update(statement, parameter);
    }
	
	
	/**
	 * pms의 pjtcode로 jira등의 regacy project code 를 가져온다.
	 * @param parameter
	 * @return
	 */
	@SuppressWarnings("rawtypes")
    public List regacynamesByPjtcode(Map<Object, Object> parameter) {
        return (List)dao.selectList("common.regacynames.bypjtcode", parameter);
    }
	
	public static String getCookie(HttpServletRequest request , String cookieName){
        Cookie[] cookie = request.getCookies();
        
        System.out.println(">>>>>>>>cookie.length:" + ( (cookie != null)? ""+(cookie.length) : "cookie is NULL") );
        
        for (int i=0; cookie!=null&&i<cookie.length; i++) {
       	
            System.out.println( cookie[i].getName() + " = " + cookie[i].getValue() );
            
            if( cookieName.equals(cookie[i].getName()) ){
                return cookie[i].getValue(); 
            }
        }
        
        return "";
    }
	
	@SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
    public void multipartProcess(Map resultDs, HttpServletRequest req)   throws Exception {
    	
    	
    	String upload = "upload";
    	String uploadBoard = "dashboard";
      
    	/*
    	 * validate 
	   		request type
    	 */
    	Assert.state(req instanceof MultipartHttpServletRequest,    "request !instanceof MultipartHttpServletRequest");
    	final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) req;
 
    	logger.debug(multiRequest.getParameter("datafile"));

    	/*
	     * extract files
	     */
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();
    	
    	Assert.notNull(files, "files is null");
    	Assert.state(files.size() > 0, "0 files exist");
    	
    	logger.debug("files==>"+files);
    	logger.debug("files.size()==>"+files.size());

    	logger.debug("multiRequest.getSession().getServletContext().getRealPath()==>["+multiRequest.getSession().getServletContext().getRealPath("/")+"]");
    	
		SimpleDateFormat dateFile = new SimpleDateFormat("yyyyMMdd");
		Date nowFile = new Date();
		String curDateFile = dateFile.format(nowFile);    	
    	
    	/*
    	 * process files
    	 */
    	//String uploadPath = fileUploadProperties.getProperty("file.upload.path")+"\\"+request.getParameter("grpName");
    	String uploadPath = multiRequest.getSession().getServletContext().getRealPath("/") + "/" + upload + "/" + uploadBoard + "/" +  curDateFile;
 
    	File saveFolder = new File(uploadPath);
    	// 디렉토리 생성 (보안 취약점 개선) 2009.04.02
    	boolean isDir = false;
    	if (!saveFolder.exists() || saveFolder.isFile()) {
    		saveFolder.mkdirs();
    	}
    	if (!isDir) {
    		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
    		MultipartFile file;
    		List<Map<String, Object>> fileInfoList = new ArrayList<Map<String, Object>>();
    		String filePath;
    		while (itr.hasNext()) {
    			Entry<String, MultipartFile> entry = itr.next();
    			logger.debug("[" + entry.getKey() + "]");
    			file = entry.getValue();
    			if (!"".equals(file.getOriginalFilename())) {
    				SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmssSSS");
    				Date now = new Date();
    				String curDate = date.format(now);

    				int i = -1;
    				i = file.getOriginalFilename().lastIndexOf(".");
    				String realFileName = curDate+file.getOriginalFilename().substring(i,file.getOriginalFilename().length());

    				//filePath = uploadPath + "\\" + realFileName;
    				filePath = uploadPath + "/" + realFileName;
    				logger.debug("filePath==>"+filePath);
    				//String path = "/upload/"+req.getParameter("grpName")+"/"+realFileName;
    				String path = "/" + upload + "/" + uploadBoard + "/" + curDateFile + "/" + realFileName;
    				logger.debug("path==>"+path);
    				file.transferTo(new File(filePath));
    				
    				Map<String, Object> fileInfo = new HashMap<String, Object>();
    				fileInfo.put("fieldName", file.getName());
    				fileInfo.put("orgFileName", file.getOriginalFilename());
    				fileInfo.put("fileSize", file.getSize());
    				fileInfo.put("fileName", realFileName);
    				fileInfo.put("filePath", path);
    				fileInfo.put("isFile", true);
    				fileInfoList.add(fileInfo);
    			}
    		}
    		
    		resultDs.put("fileInfoList", fileInfoList);
    	}
    	//return resultDs;
    } 
	
	@SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
    public void multipartProcess1(Map resultDs, HttpServletRequest req)   throws Exception {
    	
    	
    	String upload = "upload";
    	String uploadBoard = "dashboard";
      
    	/*
    	 * validate 
	   		request type
    	 */
    	Assert.state(req instanceof MultipartHttpServletRequest,    "request !instanceof MultipartHttpServletRequest");
    	final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) req;
 
    	logger.debug(multiRequest.getParameter("datafile"));

    	/*
	     * extract files
	     */
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();
    	
    	Assert.notNull(files, "files is null");
    	Assert.state(files.size() > 0, "0 files exist");
    	
    	logger.debug("files==>"+files);
    	logger.debug("files.size()==>"+files.size());

    	logger.debug("multiRequest.getSession().getServletContext().getRealPath()==>["+multiRequest.getSession().getServletContext().getRealPath("/")+"]");
    	
		SimpleDateFormat dateFile = new SimpleDateFormat("yyyyMMdd");
		Date nowFile = new Date();
		String curDateFile = dateFile.format(nowFile);    	
    	
    	/*
    	 * process files
    	 */
    	//String uploadPath = fileUploadProperties.getProperty("file.upload.path")+"\\"+request.getParameter("grpName");
    	String uploadPath = multiRequest.getSession().getServletContext().getRealPath("/") + "/" + upload + "/" + uploadBoard + "/" +  curDateFile;
 
    	File saveFolder = new File(uploadPath);
    	// 디렉토리 생성 (보안 취약점 개선) 2009.04.02
    	boolean isDir = false;
    	if (!saveFolder.exists() || saveFolder.isFile()) {
    		saveFolder.mkdirs();
    	}
    	if (!isDir) {
    		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
    		MultipartFile file;
    		List<Map<String, Object>> fileInfoList = new ArrayList<Map<String, Object>>();
    		String filePath;
    		while (itr.hasNext()) {
    			Entry<String, MultipartFile> entry = itr.next();
    			logger.debug("[" + entry.getKey() + "]");
    			file = entry.getValue();
    			if (!"".equals(file.getOriginalFilename())) {
    				SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmssSSS");
    				Date now = new Date();
    				String curDate = date.format(now);

    				int i = -1;
    				i = file.getOriginalFilename().lastIndexOf(".");
    				String realFileName = curDate+file.getOriginalFilename().substring(i,file.getOriginalFilename().length());

    				//filePath = uploadPath + "\\" + realFileName;
    				filePath = uploadPath + "/" + realFileName;
    				logger.debug("filePath==>"+filePath);
    				//String path = "/upload/"+req.getParameter("grpName")+"/"+realFileName;
    				String path = "/" + upload + "/" + uploadBoard + "/" + curDateFile + "/" + realFileName;
    				logger.debug("path==>"+path);
    				file.transferTo(new File(filePath));
    				
    				Map<String, Object> fileInfo = new HashMap<String, Object>();
    				fileInfo.put("fieldName", file.getName());
    				fileInfo.put("orgFileName", file.getOriginalFilename());
    				fileInfo.put("fileSize", file.getSize());
    				fileInfo.put("fileName", realFileName);
    				fileInfo.put("filePath", path);
    				fileInfo.put("isFile", true);
    				fileInfoList.add(fileInfo);
    			}
    		}
    		
    		resultDs.put("fileInfoList", fileInfoList);
    	}
    	//return resultDs;
    } 
	
	// save uploaded file to new location
	public  Map<String,Object> writeToFile(
			ServletContext scontext, 
			FormDataBodyPart part){
		
		String upload = "upload";
    	String uploadBoard = "dashboard";
		
		SimpleDateFormat dateFile = new SimpleDateFormat("yyyyMMdd");
		Date nowFile = new Date();
		String curDateFile = dateFile.format(nowFile);    	
		
		// dir save
		String uploadPath = scontext.getRealPath("/") + "/" + upload + "/" + uploadBoard + "/" +  curDateFile;
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists() || saveFolder.isFile()) {
    		saveFolder.mkdirs();
    	}
		
		// file save 
		InputStream is = part.getValueAs(InputStream.class);
		ContentDisposition detail =  part.getContentDisposition();
		
		String filename  = detail.getFileName();
		
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Date now = new Date();
		String curDate = date.format(now);
		
		int i = -1;
		i = filename.lastIndexOf(".");
		String realFileName = curDate + filename.substring(i, filename.length());
		
		String filePath = uploadPath + "/" + realFileName;
		String path = "/" + upload + "/" + uploadBoard + "/" + curDateFile + "/" + realFileName;
		int read = writeToFile(is,filePath);
		
		Map<String,Object> fileInfo = new HashMap<String, Object>();
		fileInfo.put("fieldName", part.getName());
		fileInfo.put("orgFileName", detail.getFileName());
		fileInfo.put("fileSize", read);
		fileInfo.put("fileName", realFileName );
		fileInfo.put("filePath", path);
		fileInfo.put("isFile", true);
		
		return fileInfo;
		
	}
	
	private int writeToFile(InputStream uploadedInputStream, String uploadedFileLocation) {
		int totalread = 0;
		try {
			int read = 0;
			OutputStream out = new FileOutputStream(new File(uploadedFileLocation));
			
			byte[] bytes = new byte[1024];

			out = new FileOutputStream(new File(uploadedFileLocation));
			while ((read = uploadedInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
				totalread += read;
			}
			out.flush();
			out.close();
		} catch (IOException e) {

			e.printStackTrace();
		}
		return totalread;
	}
	
	private void writeToFile1(InputStream uploadedInputStream, String uploadedFileLocation) {

		try {
			OutputStream out = new FileOutputStream(new File(uploadedFileLocation));
			int read = 0;
			byte[] bytes = new byte[1024];

			out = new FileOutputStream(new File(uploadedFileLocation));
			while ((read = uploadedInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
			out.flush();
			out.close();
		} catch (IOException e) {

			e.printStackTrace();
		}

	}
	
	/**
	 * array 를 vo에 반영하기 위함 함수
	 * @param request
	 * @param vo
	 */
	@SuppressWarnings("rawtypes")
	public void requestToVo(HttpServletRequest request, Map<Object,Object> vo){
		Map map = request.getParameterMap();
		for (Object key: map.keySet()) {
			String keyStr = (String)key;
			String[] value = (String[])map.get(keyStr);
			vo.put(keyStr+"Arr",value);
			
			if(keyStr.equals("searchJson")){
				Object searchJsonStr = vo.get("searchJson");
		    	if(searchJsonStr != null){
		    		JSONObject searchJson = JSONObject.fromObject(searchJsonStr.toString());
		    		vo.put("searchJsonOrigin", searchJsonStr.toString());
		    		vo.put("searchJson", searchJson);
		    	}
			}
			if(keyStr.equals("origindata")){
				Object origindata = vo.get("origindata");
		    	if(origindata != null){
		    		JSONObject origindataJson = JSONObject.fromObject(origindata.toString());
		    		vo.put("origindataOrigin", origindata.toString());
		    		vo.put("origindata", origindataJson);
		    	}
			}
			/**
			 * 201804. kimdoyoun 추가
			 * */
			if(keyStr.equals("autoJson")){
				Object autoJsonStr = vo.get("autoJson");
		    	if(autoJsonStr != null){
		    		JSONArray autoJson = JSONArray.fromObject(autoJsonStr.toString());
		    		vo.put("autoJsonOrigin", autoJsonStr.toString());
		    		vo.put("autoJson", autoJson);
		    	}
			}
			
			// mysql page variable : mysql_offset
			if ( vo.get("rows") != null) {
				String str_page = (String)vo.get("page");
				int int_page = Integer.parseInt(str_page);
				

				String str_rows = (String)vo.get("rows");
				int int_rows = Integer.parseInt(str_rows);

				int offset = (int_page - 1) * int_rows;
				
				vo.put("int_offset", offset);
				vo.put("int_limit", int_rows);
			}
			
			
		   
		}
		
		
	}

	
	public void updateAllSaveBeforeDel(String statement,Object parameter) {
		int result = 0;
		Map<Object,Object> param = (Map<Object,Object>)parameter;
		net.sf.json.JSONArray autoJson = (net.sf.json.JSONArray)param.get("autoJson");
		if(autoJson != null){
			net.sf.json.JSONObject delete = (net.sf.json.JSONObject)autoJson.get(0);
			param.put("detail",delete);
			result += dao.delete("dashboard.ssd_sm.testSetDtlGridSave.beforeDel", param);
		}
	}
	
	
	public void transactionTest(Map<Object,Object> searchVO) {
		DefaultTransactionDefinition def = null ;
		TransactionStatus status = null ;
		try{
			def = new DefaultTransactionDefinition();
			def.setName("transactionTest");
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
			status = transactionManager.getTransaction(def);
			
			dao.update("dashbaord.test.transaction.1", searchVO);
			dao.update("dashbaord.test.transaction.2", searchVO);
			
			transactionManager.commit(status);
			searchVO.put("result", "success");
		}catch (Exception ex){
			transactionManager.rollback(status);
			searchVO.put("result", "fail: " + ex.getMessage());
		}
	}
	
	
}
