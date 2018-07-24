package dashboard.fvt.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import common.dao.CommonDao;
import util.DrmDecoderUtil;


@Service
public class FvtService {
	
	@Autowired
    private CommonDao dao;
	
	/**
	 * UFS Excelupload
	 */
	public void fvtUfsExcelUpload(MultipartHttpServletRequest multi) throws Exception {

		//파일 업로드
		Map<String, Object> fileInfo = this.uploadAttach(multi);
		
		String fileName = (String) fileInfo.get("fileName");
		String filePath = (String) fileInfo.get("filePath");
		String uploadPath = (String) fileInfo.get("uploadPath");
		String newFileName = fileName.substring(0, fileName.lastIndexOf(".")) + "_decode" + fileName.substring(fileName.lastIndexOf("."));
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		
		//파일 업로드 DRM Decoding
        DrmDecoderUtil.drmDecoder(multi, filePath);
        
		//엑셀파싱
		this.ufsParseXlsx(uploadPath + File.separator + newFileName, dataList);
		
		//데이터 저장
		this.ufsSave(dataList);
		
		//업로드 파일 삭제
		File newFile = new File(filePath);
		newFile.delete();
		
		//DRM 파일 삭제
		File drmFile = new File(uploadPath + File.separator + newFileName);
		drmFile.delete();
	}
	
	/**
	 * EMMC Excelupload
	 */
	public void fvtEmmcExcelUpload(MultipartHttpServletRequest multi) throws Exception {

		//파일 업로드
		Map<String, Object> fileInfo = this.uploadAttach(multi);
		
		String fileName = (String) fileInfo.get("fileName");
		String filePath = (String) fileInfo.get("filePath");
		String uploadPath = (String) fileInfo.get("uploadPath");
		String newFileName = fileName.substring(0, fileName.lastIndexOf(".")) + "_decode" + fileName.substring(fileName.lastIndexOf("."));
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		
		//파일 업로드 DRM Decoding
        DrmDecoderUtil.drmDecoder(multi, filePath);
        
		//엑셀파싱
		this.emmcParseXlsx(uploadPath + File.separator + newFileName, dataList);
		
		//데이터 저장
		this.emmcSave(dataList);
		
		//업로드 파일 삭제
		File newFile = new File(filePath);
		newFile.delete();
		
		//DRM 파일 삭제
		File drmFile = new File(uploadPath + File.separator + newFileName);
		drmFile.delete();
	}
	
	public void fvtUfsCallProc() throws Exception {
		dao.update("dashboard.corona.ufs.script.master.sp", null);
	}
	
	public void fvtEmmcCallProc() throws Exception {
		dao.update("dashboard.corona.emmc.script.master.sp", null);
	}
    
    /**
	 * UFS Exceldownload
	 */
    public Map<String, Object> fvtUfsExcelDownload(HttpServletRequest req, Map<String, Object> param) throws Exception {
    	Map<String, Object> rtnMap = new HashMap<String, Object>();
    	String upload = "upload";
    	String uploadBoard = "dashboard";
    	
    	SimpleDateFormat dateFile = new SimpleDateFormat("yyyyMMdd");
		Date nowFile = new Date();
		String curDateFile = dateFile.format(nowFile);
		
    	String saveDir = req.getSession().getServletContext().getRealPath("/") + upload + File.separator + uploadBoard + File.separator +  curDateFile;
    	
		File fdir = new File(saveDir);

		if(!fdir.isDirectory()){
			fdir.mkdirs();
		}
		
		try {
			String fileName = "UFS_MASTER_TEST_SCRIPT.xlsx";
			String filePath = saveDir + File.separator + fileName;
			
			Workbook workBook = new XSSFWorkbook();
			Sheet sheet = workBook.createSheet("result");
			
			this.setUfsExcelCreateRows(sheet);
			this.setUfsExcelData(sheet);
			
			rtnMap.put("fileName", fileName);
			rtnMap.put("filePath", filePath);
			rtnMap.put("workbook", workBook);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
		
		return rtnMap;
    }
    
    /**
	 * EMMC Exceldownload
	 */
    public Map<String, Object> fvtEmmcExcelDownload(HttpServletRequest req, Map<String, Object> param) throws Exception {
    	Map<String, Object> rtnMap = new HashMap<String, Object>();
    	String upload = "upload";
    	String uploadBoard = "dashboard";
    	
    	SimpleDateFormat dateFile = new SimpleDateFormat("yyyyMMdd");
		Date nowFile = new Date();
		String curDateFile = dateFile.format(nowFile);
		
    	String saveDir = req.getSession().getServletContext().getRealPath("/") + upload + File.separator + uploadBoard + File.separator +  curDateFile;
    	
		File fdir = new File(saveDir);

		if(!fdir.isDirectory()){
			fdir.mkdirs();
		}
		
		try {
			String fileName = "EMMC_MASTER_TEST_SCRIPT.xlsx";
			String filePath = saveDir + File.separator + fileName;
			
			Workbook workBook = new XSSFWorkbook();
			Sheet sheet = workBook.createSheet("result");
			
			this.setEmmcExcelCreateRows(sheet);
			this.setEmmcExcelData(sheet);
			
			rtnMap.put("fileName", fileName);
			rtnMap.put("filePath", filePath);
			rtnMap.put("workbook", workBook);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
		
		return rtnMap;
    }
    
    private Map<String, Object> uploadAttach(MultipartHttpServletRequest req)   throws Exception {
    	
    	String upload = "upload";
    	String uploadBoard = "dashboard";
      
    	final MultipartHttpServletRequest multiRequest = req;
 
		SimpleDateFormat dateFile = new SimpleDateFormat("yyyyMMdd");
		Date nowFile = new Date();
		String curDateFile = dateFile.format(nowFile);    	

		String uploadPath = multiRequest.getSession().getServletContext().getRealPath("/") + upload + File.separator + uploadBoard + File.separator +  curDateFile;
 
    	File saveFolder = new File(uploadPath);
    	if (!saveFolder.exists() || saveFolder.isFile()) {
    		saveFolder.mkdirs();
    	}
    	
		MultipartFile file = multiRequest.getFile("datafile");
		Map<String, Object> fileInfo = new HashMap<String, Object>();
		
		if (!"".equals(file.getOriginalFilename())) {
			SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			Date now = new Date();
			String curDate = date.format(now);

			int i = -1;
			i = file.getOriginalFilename().lastIndexOf(".");
			String realFileName = curDate+file.getOriginalFilename().substring(i,file.getOriginalFilename().length());

			String filePath = uploadPath + File.separator + realFileName;
			
			String path = File.separator + upload + File.separator + uploadBoard + File.separator + curDateFile + File.separator + realFileName;
			file.transferTo(new File(filePath));
			
			fileInfo.put("fieldName", file.getName());
			fileInfo.put("orgFileName", file.getOriginalFilename());
			fileInfo.put("fileSize", file.getSize());
			fileInfo.put("fileName", realFileName);
			fileInfo.put("filePath", filePath);
			fileInfo.put("path", path);
			fileInfo.put("isFile", true);
			fileInfo.put("uploadPath", uploadPath);
		}
		
    	return fileInfo;
    }

    private Workbook getWorkbook(String filePath) throws Exception {
    	
    	InputStream fis = new FileInputStream(filePath);
    	Workbook wb = null;
    	
    	if(filePath.toUpperCase().endsWith(".XLS")) {
    		wb = new HSSFWorkbook(fis);
    	} else if(filePath.toUpperCase().endsWith(".XLSX")) {
    		wb = new XSSFWorkbook(fis);
    	}
    	return wb;
    }
    
    private String getCellValue(Cell cell, int cellIndex) throws Exception {
    	if (cell == null) {
    		return "";
    	}
    	
		String value = "";
		if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC)
			value = String.valueOf(cell.getNumericCellValue());
		else if(cell.getCellType() == Cell.CELL_TYPE_STRING)
			value = cell.getStringCellValue();
		else if(cell.getCellType() == Cell.CELL_TYPE_BLANK)
			value = "";
		else
			value = cell.getStringCellValue();
		
		return value.trim();
	}
    
    /**
     * scriptName의 16진수를 10진수로 변환한다.
     * @param scriptName
     * @return
     * @throws Exception
     */
    private String getConvertScriptName(String scriptName, String type) throws Exception {
    	
    	String regx = "";
    	
    	if ("UFS".equals(type)) regx = "^([\\w]+\\s[\\w]+)\\s([\\s*\\w]+)";
    	else if ("EMMC".equals(type)) regx = "^([\\w]+[\\w]+)\\s([\\s*\\w]+)";
    	
    	Pattern p = Pattern.compile(regx);
    	Matcher m = p.matcher(scriptName);
    	
    	StringBuffer rtnStr = new StringBuffer();
    	
    	String param = "";
    	
    	if(m.find()) {
    		rtnStr.append(m.group(1));
    		param = m.group(2);
    		
    		p = Pattern.compile("[\\w]+");
    		m = p.matcher(param);
    		
    		while(m.find()) {
    			String parameter = m.group().toLowerCase();
    			rtnStr.append(" ");
    			if(parameter.indexOf("0x") > -1)  
    				rtnStr.append(Long.parseLong(parameter.replaceFirst("0x", ""), 16));
    			else 
    				rtnStr.append(parameter);
    		}
    	}
    	
    	if (rtnStr.length() == 0) return scriptName;
    	
    	return rtnStr.toString();
    }
    
    private void ufsParseXlsx(String filePath, List<Map<String, String>> dataList) throws Exception {
    	try {
	    	Workbook wb = this.getWorkbook(filePath);
	    	Sheet sheet = wb.getSheetAt(0);
	    	
	    	int rowsCnt = sheet.getPhysicalNumberOfRows();
	    	for(int rowIndex = 1; rowIndex < rowsCnt; rowIndex ++) {
	    		
	    		Map<String, String> data = new HashMap<String, String>();
	    		Row row = sheet.getRow(rowIndex);
	    		if(row != null) {
	    			
	    			String scriptName = this.getCellValue(row.getCell(21),21);
	    			if ("".equals(scriptName)) continue;
	    				
	    			data.put("category",this.getCellValue(row.getCell(0), 0));
	    			data.put("testItem",this.getCellValue(row.getCell(1) ,1));
	    			data.put("singleMulti",this.getCellValue(row.getCell(2), 2));
	    			data.put("powerModeSpeed",this.getCellValue(row.getCell(3),3));
	    			data.put("testTime",this.getCellValue(row.getCell(4), 4));
	    			data.put("needVendorCmd",this.getCellValue(row.getCell(5),5));
	    			data.put("luconfigYn",this.getCellValue(row.getCell(6), 6));
	    			data.put("ufsVer",this.getCellValue(row.getCell(7), 7));
	    			data.put("targetOperation",this.getCellValue(row.getCell(8),8));
	    			data.put("precondition",this.getCellValue(row.getCell(9),9));
	    			data.put("por",this.getCellValue(row.getCell(10),10));
	    			data.put("hwReset",this.getCellValue(row.getCell(11),11));
	    			data.put("epReset",this.getCellValue(row.getCell(12),12));
	    			data.put("h8",this.getCellValue(row.getCell(13),13));
	    			data.put("ssu",this.getCellValue(row.getCell(14),14));
	    			data.put("targetLu",this.getCellValue(row.getCell(15),15));
	    			data.put("powerControl",this.getCellValue(row.getCell(16),16));
	    			data.put("itemName",this.getCellValue(row.getCell(17),17));
	    			data.put("itemPurpose",this.getCellValue(row.getCell(18),18));
	    			data.put("itemDescription",this.getCellValue(row.getCell(19),19));
	    			data.put("inputParameter",this.getCellValue(row.getCell(20),20));
	    			data.put("scriptName", scriptName);
	    			data.put("scriptTatLvl",this.getCellValue(row.getCell(22),22));
	    			data.put("scriptVersion",this.getCellValue(row.getCell(23),23));
	    			data.put("pf110",this.getCellValue(row.getCell(24),24));
	    			data.put("exynos7420",this.getCellValue(row.getCell(25),25));
	    			data.put("p4Rev",this.getCellValue(row.getCell(26),26));
	    			data.put("priority",this.getCellValue(row.getCell(27),27));
	    			data.put("tg645",this.getCellValue(row.getCell(28),28));
	    			data.put("userComment",this.getCellValue(row.getCell(29),29));
	    			data.put("needPowerCycle",this.getCellValue(row.getCell(30),30));
	    			data.put("resetYn",this.getCellValue(row.getCell(31),31));
	    			data.put("scriptLvl",this.getCellValue(row.getCell(32),32));
	    			data.put("refactoring",this.getCellValue(row.getCell(33),33));
	    			data.put("resetType",this.getCellValue(row.getCell(34),34));
	    			data.put("convertScript", getConvertScriptName(scriptName, "UFS"));
	    			dataList.add(data);
	    		}
	    	}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    }
    
    private void emmcParseXlsx(String filePath, List<Map<String, String>> dataList) throws Exception {
    	try {
	    	Workbook wb = this.getWorkbook(filePath);
	    	Sheet sheet = wb.getSheetAt(0);
	    	
	    	int rowsCnt = sheet.getPhysicalNumberOfRows();
	    	for(int rowIndex = 1; rowIndex < rowsCnt; rowIndex ++) {
	    		
	    		Map<String, String> data = new HashMap<String, String>();
	    		Row row = sheet.getRow(rowIndex);
	    		if(row != null) {
	    			
	    			String scriptName = this.getCellValue(row.getCell(0),0);
	    			if ("".equals(scriptName)) continue;
	    				
	    			data.put("scriptName",this.getCellValue(row.getCell(0), 0));
	    			data.put("category",this.getCellValue(row.getCell(1), 1));
	    			data.put("testItem",this.getCellValue(row.getCell(2), 2));
	    			data.put("time",this.getCellValue(row.getCell(3),3));
	    			data.put("customerItem",this.getCellValue(row.getCell(4), 4));
	    			data.put("needVendorCmd",this.getCellValue(row.getCell(5), 5));
	    			data.put("needPowerCycle",this.getCellValue(row.getCell(6), 6));
	    			data.put("emmcVer",this.getCellValue(row.getCell(7), 7));
	    			data.put("targetDevice",this.getCellValue(row.getCell(8), 8));
	    			data.put("targetPartition",this.getCellValue(row.getCell(9), 9));
	    			data.put("category1",this.getCellValue(row.getCell(10), 10));
	    			data.put("category2",this.getCellValue(row.getCell(11), 11));
	    			data.put("category3",this.getCellValue(row.getCell(12), 12));
	    			data.put("category4",this.getCellValue(row.getCell(13), 13));
	    			data.put("category5",this.getCellValue(row.getCell(14), 14));
	    			data.put("writeMode",this.getCellValue(row.getCell(15), 15));
	    			data.put("readMode",this.getCellValue(row.getCell(16), 16));
	    			data.put("description",this.getCellValue(row.getCell(17), 17));
	    			data.put("argument",this.getCellValue(row.getCell(18), 18));
	    			data.put("platform",this.getCellValue(row.getCell(19), 19));
	    			data.put("functionName",this.getCellValue(row.getCell(20), 20));
	    			data.put("convertScript", getConvertScriptName(scriptName, "EMMC"));
	    			dataList.add(data);
	    		}
	    	}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    @SuppressWarnings("unchecked")
	@Transactional
    private void ufsSave(List<Map<String, String>> dataList) throws Exception {
    	
    	List<Map<String, String>> insertTarget = new ArrayList<Map<String, String>>();
    	for (Map<String, String> m : dataList) {
    		
			Map<String, Object> chkMap = (Map<String, Object>) dao.selectOne("dashboard.corona.ufs.script.master.upload.dupCheck", m);
    		int cnt = Integer.parseInt(chkMap.get("CNT").toString());
    		
    		if (cnt == 0) {
    			insertTarget.add(m);
    		} 
    	}
    	
    	dao.update("dashboard.corona.ufs.script.master.upload.deleteAll", null);
    	for (Map<String, String> m : dataList) {
    		dao.update("dashboard.corona.ufs.script.master.upload.merge", m);
    	}
    	
    	dao.update("dashboard.corona.ufs.script.target.deleteAll", null);
    	for (Map<String, String> m : insertTarget) {
    		dao.update("dashboard.corona.ufs.script.target.insert", m);
    	}
    }
    @SuppressWarnings("unchecked")
    @Transactional
    private void emmcSave(List<Map<String, String>> dataList) throws Exception {
    	
    	List<Map<String, String>> insertTarget = new ArrayList<Map<String, String>>();
    	for (Map<String, String> m : dataList) {
    		
			Map<String, Object> chkMap = (Map<String, Object>) dao.selectOne("dashboard.corona.emmc.script.master.upload.dupCheck", m);
    		int cnt = Integer.parseInt(chkMap.get("CNT").toString());
    		
    		if (cnt == 0) {
    			insertTarget.add(m);
    		} 
    	}
    	
    	dao.update("dashboard.corona.emmc.script.master.upload.deleteAll", null);
    	for (Map<String, String> m : dataList) {
    		dao.update("dashboard.corona.emmc.script.master.upload.merge", m);
    	}
    	
    	dao.update("dashboard.corona.emmc.script.target.deleteAll", null);
    	for (Map<String, String> m : insertTarget) {
    		dao.update("dashboard.corona.emmc.script.target.insert", m);
    	}
    }
    
    private void setUfsExcelCreateRows(Sheet sheet) throws Exception {
    	Row row = sheet.createRow(0);
    	row.createCell(0).setCellValue("CATEGORY");
    	row.createCell(1).setCellValue("TEST_ITEM");
    	row.createCell(2).setCellValue("SINGLE_MULTI");
    	row.createCell(3).setCellValue("POWER_MODE_SPEED");
    	row.createCell(4).setCellValue("TEST_TIME");
    	row.createCell(5).setCellValue("NEED_VENDOR_CMD");
    	row.createCell(6).setCellValue("LUCONFIG_YN");
    	row.createCell(7).setCellValue("UFS_VER");
    	row.createCell(8).setCellValue("TARGET_OPERATION");
    	row.createCell(9).setCellValue("PRECONDITION");
    	row.createCell(10).setCellValue("POR");
    	row.createCell(11).setCellValue("HW_RESET");
    	row.createCell(12).setCellValue("EP_RESET");
    	row.createCell(13).setCellValue("H8");
    	row.createCell(14).setCellValue("SSU");
    	row.createCell(15).setCellValue("TARGET_LU");
    	row.createCell(16).setCellValue("POWER_CONTROL");
    	row.createCell(17).setCellValue("ITEM_NAME");
    	row.createCell(18).setCellValue("ITEM_PURPOSE");
    	row.createCell(19).setCellValue("ITEM_DESCRIPTION");
    	row.createCell(20).setCellValue("INPUT_PARAMETER");
    	row.createCell(21).setCellValue("SCRIPT_NAME");
    	row.createCell(22).setCellValue("SCRIPT_TAT_LVL");
    	row.createCell(23).setCellValue("SCRIPT_VERSION");
    	row.createCell(24).setCellValue("PF110");
    	row.createCell(25).setCellValue("EXYNOS_7420");
    	row.createCell(26).setCellValue("P4_REV");
    	row.createCell(27).setCellValue("PRIORITY");
    	row.createCell(28).setCellValue("TG645");
    	row.createCell(29).setCellValue("USER_COMMENT");
    	row.createCell(30).setCellValue("NEED_POWER_CYCLE");
    	row.createCell(31).setCellValue("RESET_YN");
    	row.createCell(32).setCellValue("SCRIPT_LVL");
    	row.createCell(33).setCellValue("REFACTORING");
    	row.createCell(34).setCellValue("RESET_TYPE");
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	private void setUfsExcelData(Sheet sheet) throws Exception {
		List<?> dataList = (List) dao.selectList("dashboard.corona.ufs.script.master.selectAll", new HashMap<Object, Object>());
    	int rowIndex = 1;
    	for (int i = 0; i < dataList.size(); i++) {
    		Map<String, String> m = (Map<String, String>) dataList.get(i);
    		Row row = sheet.createRow(rowIndex);
    		row.createCell(0).setCellValue((String) m.get("CATEGORY"));
    		row.createCell(1).setCellValue((String) m.get("TEST_ITEM"));
    		row.createCell(2).setCellValue((String) m.get("SINGLE_MULTI"));
    		row.createCell(3).setCellValue((String) m.get("POWER_MODE_SPEED"));
    		row.createCell(4).setCellValue((String) m.get("TEST_TIME"));
    		row.createCell(5).setCellValue((String) m.get("NEED_VENDOR_CMD"));
    		row.createCell(6).setCellValue((String) m.get("LUCONFIG_YN"));
    		row.createCell(7).setCellValue((String) m.get("UFS_VER"));
    		row.createCell(8).setCellValue((String) m.get("TARGET_OPERATION"));
    		row.createCell(9).setCellValue((String) m.get("PRECONDITION"));
    		row.createCell(10).setCellValue((String) m.get("POR"));
    		row.createCell(11).setCellValue((String) m.get("HW_RESET"));
    		row.createCell(12).setCellValue((String) m.get("EP_RESET"));
    		row.createCell(13).setCellValue((String) m.get("H8"));
    		row.createCell(14).setCellValue((String) m.get("SSU"));
    		row.createCell(15).setCellValue((String) m.get("TARGET_LU"));
    		row.createCell(16).setCellValue((String) m.get("POWER_CONTROL"));
    		row.createCell(17).setCellValue((String) m.get("ITEM_NAME"));
    		row.createCell(18).setCellValue((String) m.get("ITEM_PURPOSE"));
    		row.createCell(19).setCellValue((String) m.get("ITEM_DESCRIPTION"));
    		row.createCell(20).setCellValue((String) m.get("INPUT_PARAMETER"));
    		row.createCell(21).setCellValue((String) m.get("SCRIPT_NAME"));
    		row.createCell(22).setCellValue((String) m.get("SCRIPT_TAT_LVL"));
    		row.createCell(23).setCellValue((String) m.get("SCRIPT_VERSION"));
    		row.createCell(24).setCellValue((String) m.get("PF110"));
    		row.createCell(25).setCellValue((String) m.get("EXYNOS_7420"));
    		row.createCell(26).setCellValue((String) m.get("P4_REV"));
    		row.createCell(27).setCellValue((String) m.get("PRIORITY"));
    		row.createCell(28).setCellValue((String) m.get("TG645"));
    		row.createCell(29).setCellValue((String) m.get("USER_COMMENT"));
    		row.createCell(30).setCellValue((String) m.get("NEED_POWER_CYCLE"));
    		row.createCell(31).setCellValue((String) m.get("RESET_YN"));
    		row.createCell(32).setCellValue((String) m.get("SCRIPT_LVL"));
    		row.createCell(33).setCellValue((String) m.get("REFACTORING"));
    		row.createCell(34).setCellValue((String) m.get("RESET_TYPE"));
    		rowIndex++;
    	}
    }
    
    private void setEmmcExcelCreateRows(Sheet sheet) throws Exception {
    	Row row = sheet.createRow(0);
    	row.createCell(0).setCellValue("SCRIPT_NAME");
    	row.createCell(1).setCellValue("CATEGORY");
    	row.createCell(2).setCellValue("TEST_ITEM");
    	row.createCell(3).setCellValue("TIME");
    	row.createCell(4).setCellValue("CUSTOMER_ITEM");
    	row.createCell(5).setCellValue("NEED_VENDOR_CMD");
    	row.createCell(6).setCellValue("NEED_POWER_CYCLE");
    	row.createCell(7).setCellValue("EMMC_VER");
    	row.createCell(8).setCellValue("TARGET_DEVICE");
    	row.createCell(9).setCellValue("TARGET_PARTITION");
    	row.createCell(10).setCellValue("CATEGORY1");
    	row.createCell(11).setCellValue("CATEGORY2");
    	row.createCell(12).setCellValue("CATEGORY3");
    	row.createCell(13).setCellValue("CATEGORY4");
    	row.createCell(14).setCellValue("CATEGORY5");
    	row.createCell(15).setCellValue("WRITE_MODE");
    	row.createCell(16).setCellValue("READ_MODE");
    	row.createCell(17).setCellValue("DESCRIPTION");
    	row.createCell(18).setCellValue("ARGUMENT");
    	row.createCell(19).setCellValue("PLATFORM");
    	row.createCell(20).setCellValue("FUNCTION_NAME");
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	private void setEmmcExcelData(Sheet sheet) throws Exception {
		List<?> dataList = (List) dao.selectList("dashboard.corona.emmc.script.master.selectAll", new HashMap<Object, Object>());
    	int rowIndex = 1;
    	for (int i = 0; i < dataList.size(); i++) {
    		Map<String, String> m = (Map<String, String>) dataList.get(i);
    		Row row = sheet.createRow(rowIndex);
    		row.createCell(0).setCellValue((String) m.get("SCRIPT_NAME"));
    		row.createCell(1).setCellValue((String) m.get("CATEGORY"));
    		row.createCell(2).setCellValue((String) m.get("TEST_ITEM"));
    		row.createCell(3).setCellValue((String) m.get("TIME"));
    		row.createCell(4).setCellValue((String) m.get("CUSTOMER_ITEM"));
    		row.createCell(5).setCellValue((String) m.get("NEED_VENDOR_CMD"));
    		row.createCell(6).setCellValue((String) m.get("NEED_POWER_CYCLE"));
    		row.createCell(7).setCellValue((String) m.get("EMMC_VER"));
    		row.createCell(8).setCellValue((String) m.get("TARGET_DEVICE"));
    		row.createCell(9).setCellValue((String) m.get("TARGET_PARTITION"));
    		row.createCell(10).setCellValue((String) m.get("CATEGORY1"));
    		row.createCell(11).setCellValue((String) m.get("CATEGORY2"));
    		row.createCell(12).setCellValue((String) m.get("CATEGORY3"));
    		row.createCell(13).setCellValue((String) m.get("CATEGORY4"));
    		row.createCell(14).setCellValue((String) m.get("CATEGORY5"));
    		row.createCell(15).setCellValue((String) m.get("WRITE_MODE"));
    		row.createCell(16).setCellValue((String) m.get("READ_MODE"));
    		row.createCell(17).setCellValue((String) m.get("DESCRIPTION"));
    		row.createCell(18).setCellValue((String) m.get("ARGUMENT"));
    		row.createCell(19).setCellValue((String) m.get("PLATFORM"));
    		row.createCell(20).setCellValue((String) m.get("FUNCTION_NAME"));
    		rowIndex++;
    	}
    }
}
