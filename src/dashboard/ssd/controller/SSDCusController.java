package dashboard.ssd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;
import dashboard.bean.SearchVO;
import dashboard.fwq.service.FwqService;
import dashboard.jira.service.JiraService;
import dashboard.performance.service.PerformanceService;
import dashboard.regression.service.RegressionTestService;
import dashboard.schedule.service.ScheduleService;
import dashboard.service.ComplexService;
import dashboard.ssd.service.SSDCusService;
import dashboard.ssd.service.SSDService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class SSDCusController {

    private static final Logger logger = LoggerFactory.getLogger(SSDCusController.class);

    @Autowired
    private SSDCusService service;
    
    @Autowired
    private CommonService commonService;
    
    @RequestMapping(value = "/ssdCusMain",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCusMain(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("ssdCusMain");
        return mav;
    }
    
    
    
    /**
     * 
     * @param request
     * @param searchVO
     * @param locale
     * @param model
     * @return
     */
	/*
	 * @RequestMapping(value = "/ssdCusMainJson",method = { RequestMethod.GET,
	 * RequestMethod.POST }) public ModelAndView ssdCusMainJson(HttpServletRequest
	 * request,HttpServletResponse response, @RequestParam Map<Object,Object>
	 * searchVO ,Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView();
	 * //searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
	 * commonService.requestToVo(request, searchVO); Object filterStr =
	 * searchVO.get("filters"); if(filterStr != null){ JSONObject filters =
	 * JSONObject.fromObject(filterStr.toString()); searchVO.put("filtersOrigin",
	 * filterStr.toString()); searchVO.put("filters", filters); }
	 * 
	 * List<?> dataList = service.mainList(searchVO); mav.addObject("rows",
	 * dataList);
	 * 
	 * Map<String,Object> paging = service.mainListPage(searchVO);
	 * mav.addObject("total", paging.get("TOTAL")); mav.addObject("page",
	 * paging.get("PAGE")); mav.addObject("records", paging.get("RECORDS"));
	 * 
	 * mav.setViewName("jsonView");
	 * 
	 * return mav; }
	 */
    
    @RequestMapping(value = "/ssdCusMainAllJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCusMainAllJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	commonService.requestToVo(request, searchVO);
    	Object filterStr = searchVO.get("filters");
    	if(filterStr != null){
    		JSONObject filters = JSONObject.fromObject(filterStr.toString());
        	searchVO.put("filtersOrigin", filterStr.toString());
        	searchVO.put("filters", filters);
    	}
    	
    	
    	List<?> dataList = service.mainListAll(searchVO);
    	mav.addObject("dataList",dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/ssdCusPop",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCusPop(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("ssdCusPop");
        return mav;
    }
    
    
    @RequestMapping(value = "/ssdCusPopJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCusPopJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	Map<String,Object> testInformation  = service.testInformation(searchVO);
        mav.addObject("testInformation", testInformation);
        
        List<?> testDisks = service.testDisk(searchVO);
        mav.addObject("testDisks", testDisks);
        
        List<?> testResults = service.testResult(searchVO);
        mav.addObject("testResults", testResults);
        
        List<?> testFiles = service.testFiles(searchVO);
        mav.addObject("testFiles", testFiles);
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/ssdCustomFilesJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCustomFilesJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
        
        List<?> testFiles = service.testFiles(searchVO);
        mav.addObject("rows", testFiles);
        mav.addObject("total", 1);
    	mav.addObject("page", 1);
    	mav.addObject("records", testFiles.size());
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/ssdCustomResultJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCustomResultJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
        
        List<?> testResults = service.testResult(searchVO);
        mav.addObject("rows", testResults);
        mav.addObject("total", 1);
    	mav.addObject("page", 1);
    	mav.addObject("records", testResults.size());
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/ssdCusDummySaveJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCusDummySaveJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	try{
    		service.savedummy(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		mav.addObject("result","fail");
    		mav.addObject("message",ex.getMessage());
    	}

    	mav.setViewName("jsonView"); 
        return mav;
    }
    
    
    @RequestMapping(value = "/ssdCusMainChart",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCusMainChart(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("ssdCusMainChart");
        return mav;
    }
    
    @RequestMapping(value = "/ssdCusMainChartJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCusMainChartJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	Map<String,Object> testInformation  = service.testInformation(searchVO);
        mav.addObject("testInformation", testInformation);
        
        List<?> testDisks = service.testDisk(searchVO);
        mav.addObject("testDisks", testDisks);
        
        List<?> testResults = service.testResult(searchVO);
        mav.addObject("testResults", testResults);
        
        List<?> testFiles = service.testFiles(searchVO);
        mav.addObject("testFiles", testFiles);
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/ssdCusDistinctFieldJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCusDistinctFieldJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	Object filterStr = searchVO.get("filters");
    	if(filterStr != null){
    		JSONObject filters = JSONObject.fromObject(filterStr.toString());
        	searchVO.put("filtersOrigin", filterStr.toString());
        	searchVO.put("filters", filters);
    	}
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.ssdCusDistinctField(searchVO);
    	mav.addObject("dataList",dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/ssdCustomCommentJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdCustomCommentJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
        
        List<?> testComments = service.testComment(searchVO);
        mav.addObject("rows", testComments);
        mav.addObject("total", 1);
    	mav.addObject("page", 1);
    	mav.addObject("records", testComments.size());
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
   
}
