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
import dashboard.ssd.service.SSDService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class SSDController {

    private static final Logger logger = LoggerFactory.getLogger(SSDController.class);

    @Autowired
    private SSDService service;
    
    @Autowired
    private CommonService commonService;
    
    @RequestMapping(value = "/ssdReliabilityMain",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdReliabilityMain(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("ssdReliabilityMain");
        return mav;
    }
    
    @RequestMapping(value = "/reliabilityModelListJson" ,method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView reliabilityModelListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.testModelList(searchVO);
        mav.addObject("dataList", dataList);       
        mav.setViewName("jsonView");        
        

        return mav;
    }
    
    @RequestMapping(value = "/reliabilityTestTypeListJson" ,method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView reliabilityTestTypeListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.testTypeList(searchVO);
        mav.addObject("dataList", dataList);       
        mav.setViewName("jsonView");        
        

        return mav;
    }
    
    @RequestMapping(value = "/reliabilityFWVersionListJson" ,method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView reliabilityFWVersionListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.fwversionList(searchVO);
        mav.addObject("dataList", dataList);       
        mav.setViewName("jsonView");        
        

        return mav;
    }
    
    @RequestMapping(value = "/reliabilityCapacityListJson" ,method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView reliabilityCapacityListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.capacityList(searchVO);
        mav.addObject("dataList", dataList);       
        mav.setViewName("jsonView");        
        

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
	 * @RequestMapping(value = "/ssdReliabilityMainJson",method = {
	 * RequestMethod.GET, RequestMethod.POST }) public ModelAndView
	 * ssdReliabilityMain(HttpServletRequest request,HttpServletResponse
	 * response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model
	 * model) {
	 * 
	 * ModelAndView mav = new ModelAndView();
	 * //searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
	 * commonService.requestToVo(request, searchVO);
	 * 
	 * List<?> dataList = service.mainList(searchVO); mav.addObject("dataList",
	 * dataList); mav.setViewName("jsonView");
	 * 
	 * return mav; }
	 */
    
    @RequestMapping(value = "/ssdReliabilityChartPop",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdReliabilityChartPop(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("ssdReliabilityChartPop");
        return mav;
    }
    
    @RequestMapping(value = "/ssdReliabilityChartPopJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView ssdReliabilityChartPopJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("productNames",request.getParameterValues("searchPRODUCT_NAME"));
    	searchVO.put("testNames",request.getParameterValues("searchTEST_NAME"));
    	searchVO.put("fwVersions",request.getParameterValues("searchFW_VERSION"));
    	searchVO.put("capacitys",request.getParameterValues("searchCAPACITY"));
    	
    	List<?> dataList = service.chartList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
   
}
