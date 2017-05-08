package dashboard.regression.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import dashboard.regression.service.RegressionTestService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class RegressionTestController {

    private static final Logger logger = LoggerFactory.getLogger(RegressionTestController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private RegressionTestService service;
    
    
    @RequestMapping(value = "/regressionTestProject",method = { RequestMethod.GET, RequestMethod.POST })
    public String regressionTestProject(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "regressionTestProject";
    }

    @RequestMapping(value = "/regressionTestProjectJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTestProjectJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	List<?> dataList = service.selectDataRegressionProject(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/regressionProjectListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionProjectListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.regressionProjectList(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    @RequestMapping(value = "/regressionTestRevision",method = { RequestMethod.GET, RequestMethod.POST })
    public String regressionTestRevision(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "regressionTestRevision";
    }
    
    
    @RequestMapping(value = "/regressionTestRevisionJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTestRevisionJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.selectDataRegressionRevision(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    @RequestMapping(value = "/regressionTestCategory",method = { RequestMethod.GET, RequestMethod.POST })
    public String regressionTestCategory(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "regressionTestCategory";
    }
    
    
    @RequestMapping(value = "/regressionTestCategoryJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTestCategoryJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.selectDataRegressionCategory(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/regressionTestCategoryList",method = { RequestMethod.GET, RequestMethod.POST })
    public String regressionTestCategoryList(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "regressionTestCategoryList";
    }
    
    
    @RequestMapping(value = "/regressionTestCategoryListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView regressionTestCategoryListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.selectDataRegressionCategoryList(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
}
