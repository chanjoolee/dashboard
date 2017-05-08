package dashboard.controller;

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
import dashboard.deliverable.service.DeliverableService;
import dashboard.regression.service.RegressionTestService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class StudyController {

    private static final Logger logger = LoggerFactory.getLogger(StudyController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private DeliverableService service;
    
    
    @RequestMapping(value = "/study",method = { RequestMethod.GET, RequestMethod.POST })
    public String deliverableGeneral(@SuppressWarnings("rawtypes") Map parameter,Locale locale, Model model) {

        return "study";
    }

    @RequestMapping(value = "/studyJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView deliverableGeneralJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	
    	
    	List<?> projectList = service.participateProjects(searchVO);
    	searchVO.put("projectList", projectList);
    	List<?> dataList = service.getParticipateProjectData(searchVO);
        
    	mav.addObject("projectList", projectList);
    	mav.addObject("dataList", dataList);
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
}
