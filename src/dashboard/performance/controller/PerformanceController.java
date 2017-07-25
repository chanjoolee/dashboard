package dashboard.performance.controller;

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

/**
 * 
 * @author grechan
 *
 */
@Controller
public class PerformanceController {

    private static final Logger logger = LoggerFactory.getLogger(PerformanceController.class);

    @Autowired
    private PerformanceService service;
    @Autowired
    private ScheduleService scheduleService;
    
    @Autowired
    private CommonService commonService;
    
    @RequestMapping(value = "/performance",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performance(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("performance");
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
    @RequestMapping(value = "/performanceJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performanceJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	List<?> dataList = service.dataList(searchVO);
    	List<?> folderList = service.folderList(searchVO);
        mav.addObject("dataList", dataList);
        mav.addObject("folderList", folderList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/performanceFolderListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performanceFolderListJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	List<?> folderList = service.folderList(searchVO);
    	//List<?> tabList = service.tabList(searchVO);
        mav.addObject("folderList", folderList);
        //mav.addObject("tabList", tabList);
        mav.setViewName("jsonView");        

        return mav;
    }
    @RequestMapping(value = "/performanceDataListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performanceDataListJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	commonService.requestToVo(request, searchVO);
    	searchVO.put("FOLDER_NAME",request.getParameterValues("FOLDER_NAME[]"));
    	List<?> dataList = service.dataList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/performanceTabListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performanceTabListJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	searchVO.put("FOLDER_NAME",request.getParameterValues("FOLDER_NAME[]"));
    	List<?> dataList = service.tabList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/performanceHigh",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performanceHigh(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName(parameter.get("viewName").toString());
        return mav;
    }
    
    @RequestMapping(value = "/performanceSaveJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performanceSaveGoodDataJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	try{
    		service.saveGoodData(searchVO);
    		mav.addObject("result","success");
    	}catch(Exception ex){
    		mav.addObject("result","fail");
    		mav.addObject("message",ex.getMessage());
    	}

    	mav.setViewName("jsonView"); 
        return mav;
    }
    
    @RequestMapping(value = "/performanceDistinctFieldJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performanceDistinctFieldJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	Object filterStr = searchVO.get("filters");
    	if(filterStr != null){
    		JSONObject filters = JSONObject.fromObject(filterStr.toString());
        	searchVO.put("filtersOrigin", filterStr.toString());
        	searchVO.put("filters", filters);
    	}
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.ssdDistinctField(searchVO);
    	mav.addObject("dataList",dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/performanceReportJson" ,method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView performanceReportJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	
        mav.addObject("chartData", searchVO.get("searchJson"));       
        mav.setViewName("jsonView");        
        

        return mav;
    }
    
   
}
