package dashboard.regression.controller;

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
import dashboard.regression.service.RegressionTabViewService;
import dashboard.regression.service.RegressionTestService;
import dashboard.schedule.service.ScheduleService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class RegressionTabViewController {

    private static final Logger logger = LoggerFactory.getLogger(RegressionTabViewController.class);

    @Autowired
    private RegressionTabViewService service;
    
    @Autowired
    private CommonService commonService;
    
    @RequestMapping(value = "/regressionTabView",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabView(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("regressionTabView");
        return mav;
    }
        
    @RequestMapping(value = "/regressionTabViewFolderListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabViewFolderListJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> folderList = service.folderList(searchVO);
        mav.addObject("folderList", folderList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/regressionTabViewFolderMetaJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabViewFolderMetaJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.folderMeta(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/regressionTabViewSmartJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabViewSmartJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.smartList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/regressionTabViewHostJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabViewHostJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.hostList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/regressionTabViewPecountJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabViewPecountJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.pecountList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/regressionTabViewErrologJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabViewErrologJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.errorlogList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/regressionTabViewMainJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabViewMainJson(HttpServletRequest request,HttpServletResponse response, 
    		@RequestParam Map<Object,Object> searchVO ,
    		//@RequestParam(value="folderNames[]") List<Map> folderNames,
    		//@RequestParam(value="selectedPoints[]") List<Map> selectedPoints,
    		Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	//searchVO.put("folderNames", folderNames);
    	//searchVO.put("selectedPoints", selectedPoints);
    	searchVO.put("folderNames",request.getParameterValues("folderNames[]"));
    	searchVO.put("selectedPoints",request.getParameterValues("selectedPoints[]"));
    	
    	List<?> dataList = service.mainList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    @RequestMapping(value = "/regressionTabViewCommonJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTabViewCommonJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	commonService.requestToVo(request, searchVO);
    	List<?> dataList = service.commonList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
   
}
