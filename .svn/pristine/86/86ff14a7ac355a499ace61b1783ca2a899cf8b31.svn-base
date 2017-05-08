package dashboard.bamboo.controller;

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
public class BambooTestController {

    private static final Logger logger = LoggerFactory.getLogger(BambooTestController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private dashboard.bamboo.service.BambooTestService service;
    
    
    @RequestMapping(value = "/bambooTestProject",method = { RequestMethod.GET, RequestMethod.POST })
    public String bambooTestProject(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "bambooTestProject";
    }
    
    
    

    @RequestMapping(value = "/bambooTestProjectJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView bambooTestProjectJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.bambooTestProject(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    @RequestMapping(value = "/bambooTestProjectPop",method = { RequestMethod.GET, RequestMethod.POST })
    public String bambooTestProjectPop(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "bambooTestProjectPop";
    }
    
    @RequestMapping(value = "/bambooTestClassName",method = { RequestMethod.GET, RequestMethod.POST })
    public String bambooTestClassName(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "bambooTestClassName";
    }

    @RequestMapping(value = "/bambooTestClassNameJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView bambooTestClassNameJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.bambooTestClassName(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/bambooTestClassNameTime",method = { RequestMethod.GET, RequestMethod.POST })
    public String bambooTestClassNameTime(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "bambooTestClassNameTime";
    }

    @RequestMapping(value = "/bambooTestClassNameTimeJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView bambooTestClassNameTimeJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.bambooTestClassNameTime(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/bambooTestClassNameTimeList",method = { RequestMethod.GET, RequestMethod.POST })
    public String bambooTestClassNameTimeList(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "bambooTestClassNameTimeList";
    }

    @RequestMapping(value = "/bambooTestClassNameTimeListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView bambooTestClassNameTimeListJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataList = service.bambooTestClassNameTimeList(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    
    
}
