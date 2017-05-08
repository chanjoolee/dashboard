package dashboard.rms.controller;

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
import dashboard.regression.service.RegressionTestService;
import dashboard.rms.service.RmsService;
import dashboard.schedule.service.ScheduleService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class RmsController {

    private static final Logger logger = LoggerFactory.getLogger(RmsController.class);

    @Autowired
    private RmsService service;
    @Autowired
    private ScheduleService scheduleService;
    
    @RequestMapping(value = "/rms",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView rms(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("rms");
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
    @RequestMapping(value = "/rmsJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView rmsJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	List<?> dataList = service.rms(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    @RequestMapping(value = "/rmsVirtual",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView rmsVirtual(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("rmsVirtual");
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
    @RequestMapping(value = "/rmsVirtualJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView rmsVirtualJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	List<?> dataList = service.rmsVirtual(searchVO);
        mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
}
