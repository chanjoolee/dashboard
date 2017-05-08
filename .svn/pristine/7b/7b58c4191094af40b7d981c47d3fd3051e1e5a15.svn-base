package dashboard.jsonforms.contrroller;

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
public class JsonformsController {

    private static final Logger logger = LoggerFactory.getLogger(JsonformsController.class);

    @Autowired
    private PerformanceService service;
    @Autowired
    private ScheduleService scheduleService;
    
    @RequestMapping(value = "/jsonforms",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jsonforms(@SuppressWarnings("rawtypes") @RequestParam Map<Object,Object> parameter,Locale locale, Model model, HttpServletRequest req,ModelAndView mav) {
    	//parameter.put("pjtCodeList",req.getParameterValues("pjtCodeList"));
    	mav.addObject("searchVO",parameter);
    	mav.setViewName("jsonforms");
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
    @RequestMapping(value = "/jsonformsJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView jsonformsJson(HttpServletRequest request,HttpServletResponse response, @RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	//searchVO.put("pjtCodeList",request.getParameterValues("pjtCodeList"));
    	
//    	List<?> dataList = service.dataList(searchVO);
//    	List<?> folderList = service.folderList(searchVO);
//        mav.addObject("dataList", dataList);
//        mav.addObject("folderList", folderList);
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    
   
}
