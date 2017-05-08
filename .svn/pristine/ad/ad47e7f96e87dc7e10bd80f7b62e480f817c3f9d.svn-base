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
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.jersey.core.header.ContentDisposition;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataBodyPart;

import common.dao.CommonDao;
import common.dao.PmsDao;

@Service
public class CommonService {
	private static final Logger logger = LoggerFactory.getLogger(CommonService.class);

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsDao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
	@SuppressWarnings("rawtypes")
    public List selectList(String statement,Object parameter) {
        return (List)dao.selectList(statement, parameter);
    }
	
	@SuppressWarnings("rawtypes")
    public List pmsCodeList(Map<Object, Object> parameter) {
        return (List)pmsDao.selectList("pms.cmm.cdbase", parameter);
    }
	
	@SuppressWarnings("rawtypes")
    public List pmsProjectList(Map<Object, Object> parameter) {
        return (List)pmsDao.selectList("dashboard.pms.project.list", parameter);
    }
	
	@SuppressWarnings("rawtypes")
    public List pmsModelListByPjtId(Map<Object, Object> parameter) {
        return (List)pmsDao.selectList("dashboard.pms.modelname.by.pjtid", parameter);
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
		   
		}
	}

	
}
