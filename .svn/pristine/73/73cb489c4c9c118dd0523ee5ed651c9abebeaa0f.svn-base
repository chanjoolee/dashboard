package dashboard.schedule.controller;

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
import dashboard.schedule.service.ScheduleService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class ScheduleController {

    private static final Logger logger = LoggerFactory.getLogger(ScheduleController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ScheduleService service;
    
    
    @RequestMapping(value = "/pmsSchedule",method = { RequestMethod.GET, RequestMethod.POST })
    public String pmsSchedule(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "pmsSchedule";
    }

    @RequestMapping(value = "/pmsScheduleJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView pmsScheduleJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
    	List<?> dataPhase = service.getDataPhase(searchVO);
    	List<?> dataPhaseCount = service.getDataPhaseCount(searchVO);
    	List<?> dataList = service.getDataList(searchVO);
    	
        mav.addObject("dataPhase", dataPhase);
        mav.addObject("dataPhaseCount", dataPhaseCount);
        mav.addObject("dataList", dataList);
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
    /**
     * 데이타 로딩속도를 줄이기 위함. 백단에서 호출되는 모든데이타.
     * @param request
     * @param searchVO
     * @param locale
     * @param model
     * @return
     */
    @RequestMapping(value = "/pmsScheduleAllJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView pmsScheduleAllJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	List<?> dataList = service.getDataList(searchVO);
        mav.addObject("dataList", dataList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/pmsScheduleProject",method = { RequestMethod.GET, RequestMethod.POST })
    public String pmsScheduleProject(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "pmsScheduleProject";
    }

    @RequestMapping(value = "/pmsScheduleProjectJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView pmsScheduleProjectJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	List<?> dataPhase = service.getDataPhase(searchVO);
    	List<?> dataPhaseCount = service.getDataPhaseRevisionCount(searchVO);
    	List<?> dataList = service.getRevisions(searchVO);
    	
        mav.addObject("dataPhase", dataPhase);
        mav.addObject("dataPhaseCount", dataPhaseCount);
        mav.addObject("dataList", dataList);
        
        mav.setViewName("jsonView");        

        return mav;
    }
    
}
