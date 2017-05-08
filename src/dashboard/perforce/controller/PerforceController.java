package dashboard.perforce.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.service.CommonService;

import dashboard.jiraIssue.service.JiraIssueService;
import dashboard.perforce.service.PerforceService;
import dashboard.service.ComplexService;

/**
 * 
 * @author grechan
 *
 */
@Controller
public class PerforceController {

    private static final Logger logger = LoggerFactory.getLogger(PerforceController.class);

    @Autowired
    private CommonService commonService;
    
    @Autowired
    private ComplexService complexService;
    
    @Autowired
    private JiraIssueService jiraservice;
    
    @Autowired
    private PerforceService perforceservice;
    
    @RequestMapping(value = "/perforceHMS",method = { RequestMethod.GET, RequestMethod.POST })
    public String perforceHMS(@SuppressWarnings("rawtypes") Map parameter, Locale locale, Model model) {
    	
        return "perforceHMS";
    }
    
    
    
    
    @RequestMapping(value = "/perforceHmsListJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView perforceHmsListJson(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	commonService.requestToVo(request, searchVO);
    	
    	List<?> dataListProject = jiraservice.jiraProjects(searchVO);
    	searchVO.put("projects", dataListProject);
    	
    	List<?> dataListUser = perforceservice.perforceHmsListForGraphUser(searchVO);
    	List<?> dataListBlock = perforceservice.perforceHmsListForGraphBlock(searchVO);
    	List<?> dataListActivity = perforceservice.perforceHmsListForGraphActivity(searchVO);
    	
        mav.addObject("dataListUser", dataListUser);
        mav.addObject("dataListBlock", dataListBlock);
        mav.addObject("dataListActivity", dataListActivity);
        
        //****  start 검색조건유지 ***//
        // 2015-06-23 add
        // 2017-03-24 copy from dashboard.controller.jira.IssueTrendsJsonController.issueTrendsJson
        JSONObject searchCondition = new JSONObject();
        searchCondition.putAll(searchVO);        
        if(searchVO.get("userId") != null  && !searchVO.get("userId").toString().equals("")){
        	// 2015-07-02. confluence에서는 userId를 넘겨주지 않으므로 저장하지 않는다.
	        searchVO.put("search", searchCondition.toString());
	        complexService.saveSearchCondition(searchVO);
        }
        //****  end 검색조건유지 ***//
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/perforceHmsListUserJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView perforceHmsListUserJson(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	commonService.requestToVo(request, searchVO);
    	
    	List<?> dataListProject = jiraservice.jiraProjects(searchVO);
    	searchVO.put("projects", dataListProject);
    	
    	List<?> dataListUser = perforceservice.perforceHmsListForGraphUser(searchVO);
    	
        mav.addObject("dataListUser", dataListUser);
        
        //****  start 검색조건유지 ***//
        // 2015-06-23 add
        // 2017-03-24 copy from dashboard.controller.jira.IssueTrendsJsonController.issueTrendsJson
        JSONObject searchCondition = new JSONObject();
        searchCondition.putAll(searchVO);        
        if(searchVO.get("userId") != null  && !searchVO.get("userId").toString().equals("")){
        	// 2015-07-02. confluence에서는 userId를 넘겨주지 않으므로 저장하지 않는다.
	        searchVO.put("search", searchCondition.toString());
	        complexService.saveSearchCondition(searchVO);
        }
        //****  end 검색조건유지 ***//
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/perforceHmsListBlockJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView perforceHmsListBlockJson(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	commonService.requestToVo(request, searchVO);
    	
    	List<?> dataListProject = jiraservice.jiraProjects(searchVO);
    	searchVO.put("projects", dataListProject);
    	
    	List<?> dataListBlock = perforceservice.perforceHmsListForGraphBlock(searchVO);
    	
        mav.addObject("dataListBlock", dataListBlock);
        
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    @RequestMapping(value = "/perforceHmsListActivityJson",method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView perforceHmsListActivityJson(HttpServletRequest request, @RequestParam Map<Object,Object> searchVO, Locale locale, Model model) {
    	
    	ModelAndView mav = new ModelAndView(); 
    	
    	commonService.requestToVo(request, searchVO);
    	
    	List<?> dataListProject = jiraservice.jiraProjects(searchVO);
    	searchVO.put("projects", dataListProject);
    	
    	List<?> dataListActivity = perforceservice.perforceHmsListForGraphActivity(searchVO);
    	
        mav.addObject("dataListActivity", dataListActivity);
        
       
        mav.setViewName("jsonView");        

        return mav;
    }
    
    
    
}
