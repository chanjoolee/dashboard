package dashboard.fvt.controller;

import java.net.URLEncoder;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import dashboard.fvt.service.FvtService;

@Controller
public class FvtController {

    private static final Logger logger = LoggerFactory.getLogger(FvtController.class);
    
    @Autowired
    private FvtService service;
    
    @RequestMapping(value = "/fvtExcelUploadJson", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView fvtExcelUploadJson(HttpServletRequest req, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) throws Exception {
   	
    	
    	final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) req;
    	ModelAndView mav = new ModelAndView();
    	
    	String type = searchVO.get("type").toString();
    	if("UFS".equals(type)) {
    		service.fvtUfsExcelUpload(multiRequest);
    		service.fvtUfsCallProc();
    	} else if ("EMMC".equals(type)) {
    		service.fvtEmmcExcelUpload(multiRequest);
    		service.fvtEmmcCallProc();
    	}
    	
    	mav.addObject("searchVO",searchVO);
    	mav.addObject("result","success");
        mav.setViewName("jsonView");       

        return mav;
    }
    
    @RequestMapping(value = "/fvtExcelDownJson", method = { RequestMethod.GET, RequestMethod.POST })
    public void fvtExcelDownJson(HttpServletRequest req, HttpServletResponse res, @RequestParam Map<String, Object> searchVO ,Locale locale, Model model) throws Exception {
    	
    	Map<String, Object> rtnMap = null;
    	
    	String type = searchVO.get("type").toString();
    	if("UFS".equals(type)) {
    		rtnMap = service.fvtUfsExcelDownload(req, searchVO);
    	} else if ("EMMC".equals(type)) {
    		rtnMap = service.fvtEmmcExcelDownload(req, searchVO);    		
    	}
    	
    	Workbook workbook = (Workbook) rtnMap.get("workbook");
    	String fileName = (String) rtnMap.get("fileName");
    	String header = req.getHeader("User-Agent");
    	if (header.indexOf("MSIE") > -1) {
    		fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", " ");
    	} else {
    		fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
    	}
    	
    	res.setContentType("application/vnd.ms-excel;charset=utf-8");
    	res.setHeader("Content-Disposition", "attachment;filename=" + fileName);
    	workbook.write(res.getOutputStream());
    }
}
