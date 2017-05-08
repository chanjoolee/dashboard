package dashboard.controller.jira;

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
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class IssueTrendsJsonController {

    private static final Logger logger = LoggerFactory.getLogger(IssueTrendsJsonController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService service;

    @RequestMapping(value = "/issueTrendsJson")
    public ModelAndView issueTrendsJson(HttpServletRequest request,@RequestParam Map<Object,Object> searchVO ,Locale locale, Model model) {

    	
    	ModelAndView mav = new ModelAndView(); 
    	searchVO.put("priority",request.getParameterValues("priority[]"));
    	searchVO.put("issuetype",request.getParameterValues("issuetype[]"));    
    	searchVO.put("subProjects",request.getParameterValues("subProjects[]"));
    	
    	List<?> data = service.selectDefectsTrends(searchVO);
    	List<?> phase = service.selectProjectPhase(searchVO);
    	List<?> priority = null;
    	List<?> issuetype = null;
    	//if(searchVO.get("priority") == null)
    		priority = service.selectDefectsTrendsPriority(searchVO);
    	
    	//if(searchVO.get("issuetype") == null)
    		issuetype = service.selectDefectsTrendsIssueType(searchVO);
    	
    	Map tat = service.getJiraAverageTat(searchVO);
    	
        mav.addObject("data", data);
        mav.addObject("phase", phase);
        mav.addObject("priority", priority);
        mav.addObject("issuetype", issuetype);
        mav.addObject("tat", tat);
        
        
        // 2015-06-23 add
        JSONObject searchCondition = new JSONObject();
        searchCondition.putAll(searchVO);
        
        if(searchVO.get("userId") != null  && !searchVO.get("userId").toString().equals("")){
        	// 2015-07-02. confluence에서는 userId를 넘겨주지 않으므로 저장하지 않는다.
	        searchVO.put("search", searchCondition.toString());
	        service.saveSearchCondition(searchVO);     
        }
        mav.setViewName("jsonView");        

        return mav;
    }
}
